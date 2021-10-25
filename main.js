import {parse} from "https://deno.land/std@0.112.0/flags/mod.ts";
import * as actions from './actions.js';

const args = parse(Deno.args);
const [command, action, code] = args._;

if (command === 'fix') console.log(actions['$' + action](code));
if (command === 'detect') console.log(actions.detectAvailableActions(action));
