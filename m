Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 21:09:26 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:52949 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493121Ab0AaUId (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2010 21:08:33 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1Nbg5t-0006Iw-Pv
        for linux-mips@linux-mips.org; Sun, 31 Jan 2010 21:08:29 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH 0/3] AR7 cleanups and fixes
Date:   Sun, 31 Jan 2010 19:37:36 +0000
Message-ID: <0p2h37-ch6.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
X-archive-position: 25794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

A number of patches I have already run by Florian Fainelli and now that 
the GPIO[1] and CLK[2] patches are in, I can submit my generic AR7 
cleanup and fixup patches:
 1. whitespace cleanups
 2. fix usb slave mem range mistype
 3. make ar7_register_devices much more durable

So these patches should apply to the linux-queue...hopefully.

Cheers

[1] http://marc.info/?l=linux-mips&m=126254986304947&w=2
[2] http://marc.info/?l=linux-mips&m=126254989304999&w=2

-- 
Alexander Clouter
.sigmonster says: Someone is speaking well of you.
