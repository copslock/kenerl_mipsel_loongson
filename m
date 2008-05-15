Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 14:59:14 +0100 (BST)
Received: from pmc216-241-226-184.pmc-sierra.bc.ca ([216.241.226.184]:48043
	"EHLO pmxedge2.pmc-sierra.bc.ca") by ftp.linux-mips.org with ESMTP
	id S20022019AbYEON7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 May 2008 14:59:12 +0100
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.11) with ESMTP id m4FDx1EA006335;
	Thu, 15 May 2008 06:59:01 -0700
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 May 2008 06:57:46 -0700
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problem with MIPS cross toolchain
Date:	Thu, 15 May 2008 06:57:45 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201401EEDA09@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201401EF0B1B@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with MIPS cross toolchain
Thread-Index: Aci11KF4yfiNBuzTQD66oHe+w/sTnAABd0PwAAQu7BgAKimtgA==
References: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi> <20080513232507.GA24102@linux-mips.org> <20080513180225.194f400b.akpm@linux-foundation.org> <20080514150859.GA9898@linux-mips.org> <E06E3B7BBC07864CADE892DAF1EB0FBD07CEB326@NT-SJCA-0752.brcm.ad.broadcom.com> <A7DEA48C84FD0B48AAAE33F328C0201401EF0B1B@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
From:	"Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:	<linux-mips@linux-mips.org>
Cc:	<ralf@linux-mips.org>
X-OriginalArrivalTime: 15 May 2008 13:57:46.0111 (UTC) FILETIME=[A72AD8F0:01C8B693]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Hi,
 
currently I am using binutils 2.15.97 . I though of upgrade binutils
2.18 version( assembler 2.15.97 doesn't have support for mip34k specific
instructions used for SMTC) .Binutils package is compiling without any
problem and I am able to compile my BSP. But while booting I am unable
to detect my embedded rootfs. If I do NFS mount it is booting properly 

( I am using .incbin directive  to add my rootfile system and I am
suspecting problem with incbin directive comes from binutils 2.18 . I am
able use same code properly with 2.15.97 toolchain. anybody else faced
this issue?). 
 
 
One thing I am observing that vmlinux(ELF) built with 2.15.97 contains
39 section while vmlinux built using 2.18 contains 28 sections only.


I am using GCC 3.4.5 and uClibc. 
 
Somebody please help me
 
Thanks
Anoop
 
 
