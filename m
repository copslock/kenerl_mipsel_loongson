Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HAsXnC015080
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 03:54:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HAsXSn015079
	for linux-mips-outgoing; Mon, 17 Jun 2002 03:54:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HAsTnC015076
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 03:54:29 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id DAA06148
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 03:57:12 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA19991
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 03:57:12 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5HAvBb08679
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 12:57:11 +0200 (MEST)
Message-ID: <3D0DC086.27BFAA1D@mips.com>
Date: Mon, 17 Jun 2002 12:57:10 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: PCI DMA transfer
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I can see the 'dma_cache_inv_pc' routines (in the arch/mips/mm cache
files), in almost every incarnation, is actually doing a write-back
invalidation, why ?
My first thought was, that this will never work for the PCI devices
doing DMA, so I was wondering why it actually does work.
And the answer is, that this routine isn't used by the
PCI DMA functions, no matter what the DIRECTION of the DMA transfer is.
Has anyone got an idea why the while PCI DMA stuff is implemented this
way (only using write-back invalidations) ?
I would expect that we did a write-back invalidation of the D-cache,
when the direction was PCI_DMA_TODEVICE and only did invalidation of the
D-cache, when the direction was PCI_DMA_FROMDEVICE.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
