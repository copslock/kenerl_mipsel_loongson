Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:56:52 +0100 (MET)
Received: from lopsy-lu.misterjones.org ([IPv6:::ffff:62.4.18.26]:34797 "EHLO
	crisis.wild-wind.fr.eu.org") by ralf.linux-mips.org with ESMTP
	id <S868874AbSKZMsr>; Tue, 26 Nov 2002 13:48:47 +0100
Received: from hina.wild-wind.fr.eu.org ([192.168.70.139])
	by crisis.wild-wind.fr.eu.org with esmtp (Exim 3.35 #1 (Debian))
	id 18GfGl-0000Eo-00; Tue, 26 Nov 2002 13:56:51 +0100
Received: from maz by hina.wild-wind.fr.eu.org with local (Exim 3.35 #1 (Debian))
	id 18GfCu-0000cZ-00; Tue, 26 Nov 2002 13:52:52 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: cli/sti removal from wd33c93.c
References: <Pine.GSO.4.21.0211261340040.18990-100000@vervain.sonytel.be>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 26 Nov 2002 13:52:52 +0100
Message-ID: <wrpadjw1oij.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <Pine.GSO.4.21.0211261340040.18990-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <maz@misterjones.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mzyngier@freesurf.fr
Precedence: bulk
X-list: linux-mips

>>>>> "Geert" == Geert Uytterhoeven <geert@linux-m68k.org> writes:

Geert> BTW, am I correct in assuming that the driver is broken on
Geert> 2.4.x as well?  It looks like there are lots of paths in
Geert> wd33c93_intr() where interrupts aren't properly restored.

Indeed, it looks like being (very) broken. Although it has never
failed on my Indigo-2. Maybe interrupts get restored by luck, or these
paths are never taken...

I'll make a 2.4 patch when I'll have some time...

        M.
-- 
Places change, faces change. Life is so very strange.
