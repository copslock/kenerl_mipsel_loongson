Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PDuO014314
	for linux-mips-outgoing; Mon, 25 Mar 2002 05:56:24 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PDuHq14311
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 05:56:17 -0800
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 16pUza-0000Sm-00
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 14:58:34 +0100
Date: Mon, 25 Mar 2002 14:58:34 +0100
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@oss.sgi.com
Subject: Mips16 toolchain?
Message-ID: <20020325135834.GA1736@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

I'm currently using a toolchain based on binutils 2.12.90.0.1
and gcc-2.95.4-debian for my Linux kernel work.

Since I'm developing for an embedded target, I wanted to
check out mips16 code generation for the userspace apps.
Unfortunately my gcc aborts with an internal error
on even the simplest test program:

$ cat t16.c
extern int write(int fd, const char *buf, unsigned int size);

int main(int argc, char *argv[])
{
	write(0, "xy", 2);
	return 0;
}
$ mips-linux-gcc -mips16 -Wall -S t16.c
t16.c: In function `main':
t16.c:8: Internal compiler error:
t16.c:8: Unable to generate reloads for:
(call_insn 18 16 21 (parallel[ 
            (set (reg:SI 2 v0)
                (call (mem:SI (symbol_ref:SI ("write")) 0)
                    (const_int 16 [0x10])))
            (clobber (reg:SI 31 ra))
        ] ) 469 {call_value_internal2} (nil)
    (nil)
    (expr_list (use (reg:SI 6 a2))
        (expr_list (use (reg:SI 5 a1))
            (expr_list (use (reg:SI 4 a0))
                (nil)))))


I saw that the algorithmics toolchain (which Dominic Sweetman
offered to the Linux/MIPS community here a month ago) claims
to have full support for the mips16 instruction set.

My questions:
Does anyone here have experiences with mips16 and/or with the
algorithmics toolchain?
Is there working support for mips16 in any other gcc-version?
How about gcc-3.x from CVS?
Any other comments or recommendations regarding mips16?


glibc support wrt mips16 is not an issue for us, since we
plan to use the dietlibc (http://www.fefe.de/dietlibc/).
MIPS support for the dietlibc is still bit rough, though.


Regards,
Johannes
