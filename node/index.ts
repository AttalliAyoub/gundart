// import fs from 'fs';
import Gun from 'gun';
import 'gun/sea';
import { IGunChainReference } from 'gun/types/chain';

const refs: { [key: number]: IGunChainReference } = {};

process.stdin.on('data', (data) => {
    const cmd = new _Message(JSON.parse(data.toString().trim()));
    switch (cmd.command) {
        case 'init':
            if (!refs[cmd.date]) refs[cmd.date] = Gun(cmd.args.options);
            process.stdout.write(cmd.toString);
            break;
        case 'close':
            delete refs[cmd.date];
            process.stdout.write(cmd.toString);
            break;
        case 'get':
            // refs[cmd.date].get('qdsfmlj').map((data, key) => data, qf).
            break;
        default:
            break;
    }
});
