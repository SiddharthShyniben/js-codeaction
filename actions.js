import recast from 'https://dev.jspm.io/recast';

export const {parse, print, visit} = recast;
export const {builders: b, namedType: n} = recast.types;

export const mappings = {
	$1: 'Add braces to if statement'
};

export function $1(code) {
	const ast = parse(code);

	visit(ast, {
		visitIfStatement(path) {
			const {node} = path;

			if (node.consequent.type !== 'BlockStatement') {
				path.get('consequent').replace(
					b.blockStatement([node.consequent])
				);
			}

			this.traverse(path);
		}
	});

	return print(ast).code;
}

export function detectAvailableActions(code) {
	const ast = parse(code);
	const actions = [];

	visit(ast, {
		visitIfStatement({node}) {
			if (node.consequent.type !== 'BlockStatement') {
				actions.push({id: 1, description: mappings.$1});
				return false;
			}

			this.traverse();
		}
	});

	return JSON.stringify(actions);
}
