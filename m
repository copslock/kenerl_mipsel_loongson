Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 07:28:14 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:25743
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225204AbUDXG2N>; Sat, 24 Apr 2004 07:28:13 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O6SBN11772
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 08:28:11 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 08:28:10 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O6SAJ10879
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 08:28:10 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 08:28:09 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: 32-bit ABI
In-Reply-To: <Pine.LNX.4.55.0404231849480.14494@jurand.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello,

why do we attempt to compile the kernel with 32-bit GAS abi and 64-bit GCC
abi? Is it because the module loader is broken and supports only 32-bit
ELFs? Then what about machines which load their kernels at weird 64-bit
addresses, like 0xa800000020004000 (Octane)?

I have changed it to 64-bit abi in my Octane kernel, because it won't even
compile otherwise. I've got gcc 3.3.2, gas 2.14.

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
