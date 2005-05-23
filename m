Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 08:10:49 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:64153 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225240AbVEWHKd>; Mon, 23 May 2005 08:10:33 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4N7ARe06007
	for <linux-mips@linux-mips.org>; Mon, 23 May 2005 09:10:28 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 23 May 2005 09:10:27 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4N7APx04407
	for <linux-mips@linux-mips.org>; Mon, 23 May 2005 09:10:26 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Mon, 23 May 2005 09:10:25 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	linux-mips@linux-mips.org
Subject: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
Message-ID: <Pine.GSO.4.10.10505230905300.4132-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hi!

It seems that gcc (with -O; -O0 fixes the issue) will generate R_MIPS_HI16
without succeeding R_MIPS_LO16 (or the other way - but it's not a real
problem that way) in '.rel.text' (not '.rela.text'). According to SGI ELF
spec this combination is invalid (well, addend AHL is created from low 16
bits from HI16 and low 16 bits from LO16, and the actual result of
relocation might depend on the LO16 part - at least this is what I
understood from the specific[a]tion); it also upsets Indy PROM when
converted into ECOFF.

Gcc 3.4.3 does not exhibit this (wanton) behavior. What the heck?

Stanislaw Skowronek

--<=>--
  "There is no pain, you are receding...
   A distant ship, smoke on the horizon.
   You are only coming through in waves,
   Your lips move, but I can't hear what you're saying."
