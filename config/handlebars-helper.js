module.exports = {
    ifeq: function (a, b, options) {
        if (a === b) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    var: function (name, value, options) {
        options.data.root[name] = value;
    },
    ifnot: function (a, options) {
        if (!a) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    compare: function (lvalue, rvalue, options) {
        if (lvalue >= 10) {
            lvalue = lvalue % 10;
        }

        if (arguments.length < 3)
            throw new Error("Handlebars Helper 'compare' needs 2 parameters");

        let operator = options.hash.operator || "==";

        let operators = {
            '==': function (l, r) {
                return l == r;
            },
            '===': function (l, r) {
                return l === r;
            },
            '!=': function (l, r) {
                return l != r;
            },
            '<': function (l, r) {
                return l < r;
            },
            '>': function (l, r) {
                return l > r;
            },
            '<=': function (l, r) {
                return l <= r;
            },
            '>=': function (l, r) {
                return l >= r;
            },
            'typeof': function (l, r) {
                return typeof l == r;
            },
            '%': function (l, r) {
                return l % r === 0;
            }
        }

        if (!operators[operator])
            throw new Error("Handlerbars Helper 'compare' doesn't know the operator " + operator);

        let result = operators[operator](lvalue, rvalue);

        if (result) {
            return options.fn(this);
        } else {
            return options.inverse(this);
        }

    },
    comp: function (lvalue, rvalue, options) {
        if (arguments.length < 3)
            throw new Error("Handlebars Helper 'compare' needs 2 parameters");
        if (typeof rvalue !== "string") {
            rvalue = lvalue;
        }

        let operator = options.hash.operator || "==";

        let operators = {
            '==': function (l, r) {
                return l == r;
            },
            '===': function (l, r) {
                return l === r;
            },
            '!=': function (l, r) {
                return l != r;
            },
            '<': function (l, r) {
                return l < r;
            },
            '>': function (l, r) {
                return l > r;
            },
            '<=': function (l, r) {
                return l <= r;
            },
            '>=': function (l, r) {
                return l >= r;
            },
            'typeof': function (l, r) {
                return typeof l == r;
            },
            '%': function (l, r) {
                return l % r === 0;
            }
        }

        if (!operators[operator])
            throw new Error("Handlerbars Helper 'compare' doesn't know the operator " + operator);

        let result = operators[operator](lvalue, rvalue);

        if (result) {
            return options.fn(this);
        } else {
            return options.inverse(this);
        }
    },
    getFromArr: function (array, index) {
        return array[index]
    },
    times: function (n, block) {
        var accum = '';
        for (var i = 0; i < n; ++i)
            accum += block.fn(i);
        return accum;
    },
    cl: function (str) {
        return console.log(str);
    }
}