Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 18:42:24 +0000 (GMT)
Received: from natsmtp01.rzone.de ([IPv6:::ffff:81.169.145.166]:39339 "EHLO
	natsmtp01.rzone.de") by linux-mips.org with ESMTP
	id <S8225226AbUBBSmX>; Mon, 2 Feb 2004 18:42:23 +0000
Received: from excalibur.cologne.de (pD9E408CD.dip.t-dialin.net [217.228.8.205])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i12Ig8nf024357
	for <linux-mips@linux-mips.org>; Mon, 2 Feb 2004 19:42:08 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 1Anj2b-0000N1-00
	for <linux-mips@linux-mips.org>; Mon, 02 Feb 2004 19:43:25 +0100
Date: Mon, 2 Feb 2004 19:43:25 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: MIPS Kernel size
Message-ID: <20040202184325.GE913@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202140925.GB22008@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 03:09:25PM +0100, Ralf Baechle wrote:
> On Tue, Jan 27, 2004 at 03:51:31PM +0100, kip.r2@free.fr wrote:
> 
> > What will be the approximate size for a minimal MIPS kernel?
> 
> Btw, the -tiny tree of 2.6 has been booted on a 2MB system.  Supposedly that
> was an i386 system so MIPS16 should boot in an even smaller system and a
> normal 32-bit MIPS kernel should have enough space to wiggle in 4 megs.
> 
> Does anybody on this list actually still care about that small systems?

Depends on what you consider "that small". Kernel size is a large
issue for the Cobalt series due to the firmware limits (although
Peter Hortons attempts at a Cobalt bootloader will hopefully help in
this regard). Embedded stuff and PDAs is another field where 2.6
currently seems to pose a problem.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
