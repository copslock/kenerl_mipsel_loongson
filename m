Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Apr 2004 17:30:29 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:61883
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226091AbUDLQa2>; Mon, 12 Apr 2004 17:30:28 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3CGUQD00661
	for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 18:30:26 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 12 Apr 2004 18:30:25 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3CGUPl28904
	for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 18:30:25 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Mon, 12 Apr 2004 18:30:25 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: XIO invalid access
Message-ID: <Pine.GSO.4.10.10404121821430.28412-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello!

I have a question: what happens on a XIO invalid access? I am looking at
the MGras MAIN_WIDGET space and sometimes the Octane just locks up. I
have captured all exceptions (I pass interrupts to the original PROM
handler) and an access to MAIN_WIDGET_BASE+00020104 causes a hang. The
reset button works, which is nothing special. But the power button works,
too, and that's something I don't really understand, as it is an
interrupt, too.

Do you know something more about XIO exception handling?

Thank you in advance,

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
