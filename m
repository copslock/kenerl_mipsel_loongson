Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 16:27:46 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:22575
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225396AbTJAP1h>; Wed, 1 Oct 2003 16:27:37 +0100
Received: from hydra.mmc.atmel.com (hydra.mmc.atmel.com [10.127.240.58])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id LAA05151
	for <linux-mips@linux-mips.org>; Wed, 1 Oct 2003 11:27:29 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by hydra.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id LAA07881
	for <linux-mips@linux-mips.org>; Wed, 1 Oct 2003 11:27:29 -0400 (EDT)
X-Authentication-Warning: hydra.mmc.atmel.com: dkesselr owned process doing -bs
Date: Wed, 1 Oct 2003 11:27:29 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: sound drivers
Message-ID: <Pine.GSO.4.44.0310011123390.7534-100000@hydra.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Has anyone used alsa on mips? I need to impement a sound driver for our
dsp. It seems like all sound drivers should be developed for alsa. Is that
true? I've tried to build alsa and its' drivers but ran into a cross
compile problem.
Thanks,

David Kesselring
