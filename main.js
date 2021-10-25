import {parse} from "https://deno.land/std@0.112.0/flags/mod.ts";
import * as actions from './actions.js';

const args = parse(Deno.args);
const [action, code] = args._;

console.log(actions['$' + action](code));
