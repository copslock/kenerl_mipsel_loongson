Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 05:30:16 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:37873
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990476AbdKQEaJbqbzO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 05:30:09 +0100
Received: by mail-pg0-x242.google.com with SMTP id o7so1049375pgc.4
        for <linux-mips@linux-mips.org>; Thu, 16 Nov 2017 20:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HlFPZ2vv3wKFNKegXFlum9G3VqkBUVQbaJNpFeSdQ+E=;
        b=XkD6xLjIpspo9umRUOmJU5jIkHdxmIthKLKYSsf60MwOKk9uAE2tAT+1hQ1o6MOqUm
         WSu/aTbkDazEm9aPVKcBUCUTUJ2o8UKwnRVTURDQQwkDTHDuI2XuIiT+gZ6uu/5yDcrF
         dANaiJpKwmTHkFrU+sLH/9cqflziQ7uv9T6/GP3M3nOziw32xwPa2RUZkvHSmKF/O8p7
         3z753fzB1fIGOOz6K7iY8s25eXBzgPYbw8HBKHNL164GZcULUgaALdHgTaYfXdAkE5me
         qal3JEaIgYBnAnnGFq85r+ZdJlj8KzFdFmdasmvF+amEtgpBOqKDR374zb8SKChFHb/P
         pjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=HlFPZ2vv3wKFNKegXFlum9G3VqkBUVQbaJNpFeSdQ+E=;
        b=LS5S2zAqKLbINw4C1T3NxdNZwDkvSP8IdLbRDAyx9Q6V8mEWpTh1NQRohruf4GsQEI
         dV261EPnjsBAExd2FBdQPVG6aygAYjDuI1RXE7e2bMh40xRdszCxKAhNufS3+PPOqTZV
         z/LCGvWAXFSpXeCGVRplpNGBThudm1h06TC1XD1aGBH3TX7hwQtnLNuQ6l6m7QZJYKs7
         erAo5icfU9ERoWmC00XURUIRpthZeXlaLDvHcZi85h2hdXwCeGcEER9v+P2xcl/r6ld6
         PYYJ0BTsYeP6EEQaW23wf/Mr6xg5CVM+DSZq0xcfclT1sbGwIfotO6nHOr7n61EDr5VT
         KXBA==
X-Gm-Message-State: AJaThX6tnsFEz0DbIImY4fZvMjeANwpur/iCEhfFlZNWC+AQHLGgCa76
        4YFg0ud2RiDZZsfCcO3As4Q=
X-Google-Smtp-Source: AGs4zMaJ8NkLoxsms7P9DG6vRY0lNWU3zoYFybdu4FjRRbi8jqjCZGisR0BrCNcaVrq2Cl0uj7m//w==
X-Received: by 10.98.192.202 with SMTP id g71mr685030pfk.33.1510893003455;
        Thu, 16 Nov 2017 20:30:03 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id i3sm4550658pgc.88.2017.11.16.20.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 20:30:02 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-mips@linux-mips.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V10 3/4] scsi: Align block queue to dma_get_cache_alignment()
Date:   Fri, 17 Nov 2017 12:30:05 +0800
Message-Id: <1510893005-325-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

In non-coherent DMA mode, kernel uses cache flushing operations to
maintain I/O coherency, so scsi's block queue should be aligned to
ARCH_DMA_MINALIGN. Otherwise, If a DMA buffer and a kernel structure
share a same cache line, and if the kernel structure has dirty data,
cache_invalidate (no writeback) will cause data corruption.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/scsi/scsi_lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1cbc497..cc4ac97 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2148,11 +2148,11 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 		q->limits.cluster = 0;
 
 	/*
-	 * set a reasonable default alignment on word boundaries: the
-	 * host and device may alter it using
+	 * set a reasonable default alignment on word/cacheline boundaries:
+	 * the host and device may alter it using
 	 * blk_queue_update_dma_alignment() later.
 	 */
-	blk_queue_dma_alignment(q, 0x03);
+	blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment(dev)) - 1);
 }
 EXPORT_SYMBOL_GPL(__scsi_init_queue);
 
-- 
2.7.0
