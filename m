Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 16:14:34 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:36318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493713AbZKZPNo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 16:13:44 +0100
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id F173F8672B;
        Thu, 26 Nov 2009 16:13:43 +0100 (CET)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
Subject: [PATCH 0/5] PCM mmap (temporary) fixes for non-coherent architectures
Date:   Thu, 26 Nov 2009 16:13:03 +0100
Message-Id: <1259248388-20095-1-git-send-email-tiwai@suse.de>
X-Mailer: git-send-email 1.6.5.3
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

Hi,

this is a patchset to fix Oopses from ALSA PCM core with mmap on MIPS
and PPC non-coherent architectures.  This contains also a clean-up for
ARM mmap.

In this patch series, I don't try to port dma_mmap_coherent() to these
architectures yet, but just put ugly ifdefs in the ALSA core side.
Understand that this is a first step forward to a more cleaner solution,
and the purpose right now is just to fix up long-standing Oops.
I'll try to push dma_mmap_coherent() patches for the next kernel once
again after this gets merged.

Since the changes are minimal, I'd like to put them in ASAP for 2.6.33.
Please review and give feedbacks if any problem is found.


Thanks,

Takashi
