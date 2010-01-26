Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 20:39:05 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:45271 "EHLO
        mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493426Ab0AZTjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 20:39:01 +0100
Received: by bwz21 with SMTP id 21so3920612bwz.24
        for <linux-mips@linux-mips.org>; Tue, 26 Jan 2010 11:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MhMX9Pnrmy48FNvJlA1nYMqEshF41e11KooJf/zQJ64=;
        b=ZHgMItuSBCI5mcowagTzAXylPA53f+NJ/zwM/hZrSa3qgQ09Gxb4TrgGn3ar1/cn/k
         IAsf6iFrFwoq7xK6jLOM75fQWxNLGs81Z/m/XTmD41iB8LaIHF1W3wdExtECsOW1qX/j
         yGHPEHt0z8la/mtK7EV1UWUcLHrYHnx3oHRiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XYZwu0m93PV5Lypwxj5lV6aGkpPYJOFUDJI8n22CZP9snXHVsp+VLv6Dq3F6OBEizc
         jF/p/PCCeWeiUl0F3lUAsepZmXESqGTOprElB7WCxlKMPzF3F2N+sSMOUIWqgPvb4qPw
         RgxvZH0ZZf+D2B7MeowoQpzYV2mcvMeRFENkQ=
Received: by 10.204.141.78 with SMTP id l14mr675940bku.50.1264534735318;
        Tue, 26 Jan 2010 11:38:55 -0800 (PST)
Received: from localhost.localdomain (p5496CA8F.dip.t-dialin.net [84.150.202.143])
        by mx.google.com with ESMTPS id 14sm2826467bwz.1.2010.01.26.11.38.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 11:38:54 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: fix dbdma ring destruction memory debugcheck.
Date:   Tue, 26 Jan 2010 20:39:33 +0100
Message-Id: <1264534773-24909-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16902

DBDMA descriptors need to be located at 32-byte aligned addresses;
however kmalloc in conjunction with the SLAB allocator and 
CONFIG_DEBUG_SLUB enabled doesn't deliver any.  The dbdma code works
around that by allocating a larger area and realigning the start
address within it.

When freeing a channel however this adjustment is not taken into
account which results in an oops:

Kernel bug detected[#1]:
[...]
Call Trace:
[<80186010>] cache_free_debugcheck+0x284/0x318
[<801869d8>] kfree+0xe8/0x2a0
[<8010b31c>] au1xxx_dbdma_chan_free+0x2c/0x7c
[<80388dc8>] au1x_pcm_dbdma_free+0x34/0x4c
[<80388fa8>] au1xpsc_pcm_close+0x28/0x38
[<80383cb8>] soc_codec_close+0x14c/0x1cc
[<8036dbb4>] snd_pcm_release_substream+0x60/0xac
[<8036dc40>] snd_pcm_release+0x40/0xa0
[<8018c7a8>] __fput+0x11c/0x228
[<80188f60>] filp_close+0x7c/0x98
[<80189018>] sys_close+0x9c/0xe4
[<801022a0>] stack_done+0x20/0x3c

Fix this by recording the address delivered by kmalloc() and using
it as parameter to kfree().

This fix is only necessary with the SLAB allocator and CONFIG_DEBUG_SLAB
enabled;  non-debug SLAB, SLUB do return nicely aligned addresses,
debug-enabled SLUB currently panics early in the boot process.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: slightly improved the patch rationale, thanks to David Daney.

 arch/mips/alchemy/common/dbdma.c                 |    7 +++++--
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 40071bd..3b2ccc0 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -411,8 +411,11 @@ u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
 		if (desc_base == 0)
 			return 0;
 
+		ctp->cdb_membase = desc_base;
 		desc_base = ALIGN_ADDR(desc_base, sizeof(au1x_ddma_desc_t));
-	}
+	} else
+		ctp->cdb_membase = desc_base;
+
 	dp = (au1x_ddma_desc_t *)desc_base;
 
 	/* Keep track of the base descriptor. */
@@ -829,7 +832,7 @@ void au1xxx_dbdma_chan_free(u32 chanid)
 
 	au1xxx_dbdma_stop(chanid);
 
-	kfree((void *)ctp->chan_desc_base);
+	kfree((void *)ctp->cdb_membase);
 
 	stp->dev_flags &= ~DEV_FLAGS_INUSE;
 	dtp->dev_flags &= ~DEV_FLAGS_INUSE;
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index c098b45..8c6b110 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -305,6 +305,7 @@ typedef struct dbdma_chan_config {
 	dbdev_tab_t		*chan_dest;
 	au1x_dma_chan_t		*chan_ptr;
 	au1x_ddma_desc_t	*chan_desc_base;
+	u32			cdb_membase; /* kmalloc base of above */
 	au1x_ddma_desc_t	*get_ptr, *put_ptr, *cur_ptr;
 	void			*chan_callparam;
 	void			(*chan_callback)(int, void *);
-- 
1.6.6
