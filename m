Received:  by oss.sgi.com id <S553748AbRAXPar>;
	Wed, 24 Jan 2001 07:30:47 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:13071 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553728AbRAXPaY>;
	Wed, 24 Jan 2001 07:30:24 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D05417FA; Wed, 24 Jan 2001 16:30:17 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CFA90EE9C; Wed, 24 Jan 2001 16:30:48 +0100 (CET)
Date:   Wed, 24 Jan 2001 16:30:48 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: OOps - very obscure
Message-ID: <20010124163048.B15348@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
here a short oops while trying to run "find" in a glibc 2.2 root
on a Indigo2 with a current cvs 2.4.0 kernel.

Unable to handle kernel paging request at virtual address 00000000, epc == 00000000, ra == 00000000
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 1004fc00 fffffff2 00000001
$4 : fffffff2 00000000 00000001 00000000
$8 : 00000000 2abf3a94 8800f4a0 00000004
$12: 8ec57f10 7ffffaf8 8ec57f18 8ec57f18
$16: 8801acf8 00000000 10011510 00000002
$20: 10011510 7ffffdd4 7ffffdcc 00000001
$24: 00000000 2abf3a80
$28: 8ec56000 8ec57ef8 7ffffd10 00000000
epc   : 00000000
Status: 1004fc03
Cause : 30000008
Process find (pid: 227, stackpage=8ec56000)
Stack: 10011510 7ffffd10 88028344 00000000 7ffffc80 00402440 2aca4e00 2ac95d10
       00000000 2ac95d10 10011510 00000002 00000001 8800fa88 000007d1 100234f0
       10011510 00000000 00000003 00012000 00000000 1004fc01 00001035 00000000
       000007d1 10011510 00000001 00000000 0000fc00 00000010 00000000 8ec57f0c
       8ec57f10 8ec57f14 8ec57ef8 8ec57efc 2aca4e00 2ac95d10 10011510 00000002
       00000001 ...
Call Trace: [<88028344>] [<8800fa88>]
Code: (Bad address in epc)

I cant identify which system.map ist the correct one - -ETOMANYKERNEL
i extracted this from /proc/ksyms

8800ecb8 __rwsem_wake
8801122c do_gettimeofday

88027394 del_timer
8802869c flush_signals

This oops is reproduceable but not really nice as the fsck takes
~30 minutes :)

I'll build a fresh kernel and retry ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
