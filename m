Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 13:03:52 +0100 (BST)
Received: from hibernia.jakma.org ([IPv6:::ffff:212.17.55.49]:34453 "EHLO
	hibernia.jakma.org") by linux-mips.org with ESMTP
	id <S8224919AbUIWMDs>; Thu, 23 Sep 2004 13:03:48 +0100
Received: from hibernia.jakma.org (IDENT:paul@hibernia.jakma.org [192.168.0.3])
	by hibernia.jakma.org (8.12.11/8.12.11) with ESMTP id i8NC3jVr001154
	for <linux-mips@linux-mips.org>; Thu, 23 Sep 2004 13:03:45 +0100
Date: Thu, 23 Sep 2004 13:03:45 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: O2/IP32 R10k status / gbefb and LCD
Message-ID: <Pine.LNX.4.61.0409231251580.21165@hibernia.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <paul@clubi.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@clubi.ie
Precedence: bulk
X-list: linux-mips

Hi,

Does anyone know the status of current CVS for IP32 R10k? Many parts 
of the O2 patches seem now to have been merged to CVS (gbefb), some 
parts I cant figure out though. Eg MACE audio? The "glaurung" patch 
adds a new file for mace audio driver support, which isnt in CVS, yet 
the definition for struct mace_audio in CVS is now filled out.

Does anyone know?

Also, R10k cache coherence, what's the status of that?

Also, does anyone have a known-working reasonably current IP32 kernel 
image? I've compiled my own from recent CVS, but it doesnt appear to 
work - no modechange once PROM loads it. If anyone would have a known 
good recent build of an IP32 kernel (with gbefb obviously), I'd be 
very grateful.. i dont quite yet have anything to serial console it 
to, and i'm trying to figure out if the apparent LCD support in 
gbefb is working (gbefb=monitor:lcd).

Thanks in advance from someone who'd desperately prefer to be running 
Linux to IRIX.. ;)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Q:	Why is it that Mexico isn't sending anyone to the '84 summer games?
A:	Anyone in Mexico who can run, swim or jump is already in LA.
