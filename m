Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 14:05:13 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:59132 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbTGPNFK>; Wed, 16 Jul 2003 14:05:10 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA26695;
	Wed, 16 Jul 2003 15:05:06 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 16 Jul 2003 15:05:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@linux-mips.org
Subject: Re: sudo oops on mips64 linux_2_4
In-Reply-To: <20030716110735.GA10511@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1030716150225.25959B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2003, Florian Lohoff wrote:

> debian:~# sudo ls
> Cpu 0 Unable to handle kernel paging request at address 0000000000000000, epc == ffffffff88171104, ra == ffffffff880159f0
> 
> These are by the System.map
> 	ffffffff88171104 l_exc
> 	ffffffff880159f0 dev_ifconf
> 
> Oops in fault.c::do_page_fault, line 231:
> Cpu 0
> $0      : 0000000000000000 ffffffff881e0000 0000000000000020 0000000000000000
> $4      : 0000000000000000 ffffffff881dffff ffffffff881e0000 0000000000000020
> $8      : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> $12     : 0000000000000000 0000000000000001 0000000000000028 0000000000000003
> $16     : ffffffffffffffff 000000007fff7a20 0000000000000000 000000007fff7a28
> $20     : 0000000000000004 000000007fff7aa0 000000007fff7b60 000000007fff7bf0
> $24     : 0000000000000000 000000002ad0d6f0
> $28     : ffffffff8a188000 ffffffff8a18be30 000000007fff7c80 ffffffff880159f0
> Hi      : 0000000000000040
> Lo      : 0000000000000010
> epc     : ffffffff88171104    Not tainted
> badvaddr: 0000000000000000
> Status  : b000cce3  [ KX SX UX KERNEL EXL IE ]
> Cause   : 0000000c
> Process sudo (pid: 225, stackpage=ffffffff8a188000)
> Stack: 0000004000000000 000000050000013a 000000505d00f61c 0000000000000000
>        ffffffff881cdd08 0000000000008912 ffffffff8a231a80 000000007fff7a20
>        ffffffff880157dc 0000000000000002 000000007fff7e34 0000000000000004
>        0000000000000004 000000007fff7a64 000000007fff7a60 ffffffff8801aeec
>        0000000000000000 00000000100006c0 0000000000000fd6 0000000000000000
>        0000000000000004 0000000000008912 000000007fff7a20 0000000000000000
>        0000000000000000 0000000000000000 0000000010003ec0 0000000000000010
>        000000002adc3f44 000000002adc3f44 0000000020666f72 0000000020256820
>        000000007fff7e34 0000000000000001 0000000000000001 0000000000000002
>        0000000000000000 000000007fff7aa0 000000007fff7b60 000000007fff7bf0
>        0000000000000006 ...
> Call Trace: [<ffffffff880157dc>] [<ffffffff8801aeec>]
> 
> Code: 0085202f  10c0fff2  64c5ffff <a0800000> 64840001  14a0fffd  64a5ffff  03e00008  00000000
> Segmentation fault

 Please pass it through ksymoops for more details.  Version 2.4.9 should
work just fine for mips64.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
