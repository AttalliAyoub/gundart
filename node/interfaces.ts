class _Message {
    id: string;
    command: string;
    args: any;
    date: number;

    constructor(data: {
        id: string,
        command: string,
        args: any,
        date: number,
    }) {
        this.id = data.id;
        this.command = data.command;
        this.args = data.args;
        this.date = data.date;
    }

    get json(): {
        id: string;
        command: string;
        args: any;
        date: number;
    } {
        return {
            id: this.id,
            command: this.command,
            args: this.args,
            date: this.date,
        };
    }

    get toString(): string {
        return JSON.stringify(this.json);
    } 

    compaire(other: any): boolean {
        if (other instanceof _Message)
            return other.date == this.date;
        return false;
    }
}
