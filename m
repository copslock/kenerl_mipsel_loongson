Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DNiI904221
	for linux-mips-outgoing; Fri, 13 Jul 2001 16:44:18 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DNiGV04215
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 16:44:17 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id BE694125BA; Fri, 13 Jul 2001 16:44:15 -0700 (PDT)
Date: Fri, 13 Jul 2001 16:44:15 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: GDB <gdb@sourceware.cygnus.com>
Cc: linux-mips@oss.sgi.com
Subject: Gdb quit problem on Linux/mips
Message-ID: <20010713164415.A31747@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Did anyone see the quit problem on Linux/mips with gdb 2001-07-13-cvs?
I got

(gdb) b main
Breakpoint 1 at 0x400744: file x.c, line 3.
(gdb) r
Starting program: /tmp/./a.out 

Breakpoint 1, main () at x.c:3
3         printf ("Hello\n");
(gdb) q
The program is running.  Exit anyway? (y or n) y

It stops here. I get

 1540 pts/0    S      0:04 ./gdb ./a.out
 1550 pts/0    T      0:00 /tmp/./a.out

# strace -p 1540
wait4(-1,

It may be a kernel bug. I am running 2.4.3.


H.J.
