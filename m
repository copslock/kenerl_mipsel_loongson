Received:  by oss.sgi.com id <S553724AbQLVKrH>;
	Fri, 22 Dec 2000 02:47:07 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:59594 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553695AbQLVKqu>;
	Fri, 22 Dec 2000 02:46:50 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA25883;
	Fri, 22 Dec 2000 11:44:33 +0100 (MET)
Date:   Fri, 22 Dec 2000 11:44:32 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Martin Michlmayr <tbm@cyrius.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Kernel Oops when booting on DECstation
In-Reply-To: <20001219134828.A361@katze.cyrius.com>
Message-ID: <Pine.GSO.3.96.1001222114052.24791E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 19 Dec 2000, Martin Michlmayr wrote:

> Unable to handle kernel paging request at virtual address 00000004, epc == 8005a16c, ra == 8005a124
> Oops in fault.c:do_page_fault, line 172:
> $0 : 00000000 10002000 80720410 00000000 80720410 00000000 81088460 10002000
> $8 : 00000000 00000000 00000000 00000000 00bc8000 fffffff7 ffffffff 8021f180
> $16: 00010f00 8021c000 00000000 80048000 30464354 a0002f88 fffffff4 00010f00
> $24: 00000001 0000000a                   80720000 80720f58 80721090 8005a124
> epc  : 8005a16c
> Status: 10002004
> Cause : 30000008
> Process  (pid: 0, stackpage=80720000)
> Stack: 80061d94 00000001 000000c0 80061a58 801e0eec 800f82fc 00000000 00000000
>        00000000 80720f7c 80720f7c 00000023 00000000 00000000 00000000 80720f7c
>        80720f7c 00000023 00010f00 00010000 00000000 80048000 30464354 a0002f88
>        bfc00cbc a000f404 40208a0a 8004e1a8 00000000 00000020 80720fe0 00000000
>        8004b46c 00002617 00010f00 00000000 80721090 00002617 00bc8000 fffffff7
>        00000000 ...
> Call Trace: [<80061d94>] [<80061a58>] [<800f82fc>] [<80048000>] [<8004e1a8>] [<8004b46c>]
> Code: 24630010  8e2501d4  8e230218 <8ca20004> 00000000  0043102b  10400431  2416fff5  40046000
> 
> sym2call says:
> 
> Address		Function
> 
> 80061d94	tasklet_hi_action
> 80061a58	do_softirq
> 800f82fc	do_IRQ
> 80048000	init
> 8004e1a8	_sys_clone
> 8004b46c	stack_done

 Could you please decode your oops with ksymoops or, better yet, send me
the object (*.o) file the oops is happening?  I tried to match the code
above with my kernel binary but I failed.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
