Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Apr 2004 22:13:37 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:32248
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225772AbUDPVNf>; Fri, 16 Apr 2004 22:13:35 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3GLDTm13849
	for <linux-mips@linux-mips.org>; Fri, 16 Apr 2004 23:13:30 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Fri, 16 Apr 2004 23:13:29 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3GLDTp26462
	for <linux-mips@linux-mips.org>; Fri, 16 Apr 2004 23:13:29 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Fri, 16 Apr 2004 23:13:29 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: IP30 goes relatively far now
Message-ID: <Pine.GSO.4.10.10404162305570.25696-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello,

I'm currently doing a reverse-engineered IP30 port of Linux-MIPS.
Currently I'm using 2.6.1 as my base.

I don't know if it's been already fixed in >2.6.1, but in genex.S there
should be a 'nop' between 'jal do_\handler' and 'ret_from_exception'. The
symptom is a hang on 'Checking for the daddi bug...'. Somebody apparently
got used to '.set reorder' :P

Well, now the kernel crashes a bit later. Actually, it gets to 'mice: PS/2
mouse device common for all mice' and then gets an Instruction bus error.
I will look into this.

Currently the kernel supports only MGRAS graphics (SI, SSI, MXI, SE, SSE,
MXE) and uniprocessor. I don't have a SMP machine here, but I guess it
would not be particularly hard to do. The ODYSSEY (VPro) would be a bit
harder, as its architecture is vastly different from the MGRAS. Anyone
interested may send me a VPro6 ;)

When I get to 'cannot mount root', I will release the kernel patch.

Yours,

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
