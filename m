Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2004 17:56:40 +0100 (BST)
Received: from hibernia.jakma.org ([IPv6:::ffff:212.17.55.49]:10884 "EHLO
	hibernia.jakma.org") by linux-mips.org with ESMTP
	id <S8225215AbUIYQ4g>; Sat, 25 Sep 2004 17:56:36 +0100
Received: from hibernia.jakma.org (IDENT:paul@hibernia.jakma.org [192.168.0.3])
	by hibernia.jakma.org (8.12.11/8.12.11) with ESMTP id i8PGuTxO029761
	for <linux-mips@linux-mips.org>; Sat, 25 Sep 2004 17:56:30 +0100
Date: Sat, 25 Sep 2004 17:56:29 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: O2/IP32 R10k status / gbefb and LCD
In-Reply-To: <Pine.LNX.4.61.0409231251580.21165@hibernia.jakma.org>
Message-ID: <Pine.LNX.4.61.0409251748040.29420@hibernia.jakma.org>
References: <Pine.LNX.4.61.0409231251580.21165@hibernia.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <paul@clubi.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@clubi.ie
Precedence: bulk
X-list: linux-mips

On Thu, 23 Sep 2004, Paul Jakma wrote:

> yet have anything to serial console it to, and i'm trying to figure out if 
> the apparent LCD support in gbefb is working (gbefb=monitor:lcd).

Which it doesnt appear to.

Very recent CVS kernel, 8M framebuffer compiled in, it boots 
(keyboard leds work), but no display (screen is left as is from 
PROM).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Everything I like is either illegal, immoral or fattening.
 		-- Alexander Woollcott
