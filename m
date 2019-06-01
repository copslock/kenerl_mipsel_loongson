Return-Path: <SRS0=xPwI=UA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EEFC28CC1
	for <linux-mips@archiver.kernel.org>; Sat,  1 Jun 2019 13:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF427521
	for <linux-mips@archiver.kernel.org>; Sat,  1 Jun 2019 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396071;
	bh=zGPXe6yKB8iHpDJBGyZgJ2inSNUo5k/VZIINshdLB9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HywDxhsRtJNrb0x+q1eVk7//f55yfNjRW4r2YWc+pCh4JajMhHHzdXZbufZXO2T+s
	 0AjSpB6f7FcmkLQ9qYsadjq3eygXlUUoCts1jQK8wDCYdn6Q4yS3SJH0c5pc8TZA3x
	 MPrfFcyStDenPWOJdOh/D7zSGeVsVh8feWhUDaGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfFANXn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfFANXm (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 1 Jun 2019 09:23:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E55927336;
        Sat,  1 Jun 2019 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395421;
        bh=zGPXe6yKB8iHpDJBGyZgJ2inSNUo5k/VZIINshdLB9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpXvjZf0fTIp9qSxq9NRoxkPzgn3LlGXgBTbX33K8VImzFMvyahpOJFTTk2LWUGKA
         1jigkVOIwngi9JTFEUAXIvWtju9w5txqSO9DR5N/laHxgbEJ03sID0W4TOpz3s9lJk
         OSJmVJEr1omIa/kGXSOGFhEFvF7xzYyXwiMhz2i4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 053/141] mips: Make sure dt memory regions are valid
Date:   Sat,  1 Jun 2019 09:20:29 -0400
Message-Id: <20190601132158.25821-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 93fa5b280761a4dbb14c5330f260380385ab2b49 ]

There are situations when memory regions coming from dts may be
too big for the platform physical address space. This especially
concerns XPA-capable systems. Bootloader may determine more than 4GB
memory available and pass it to the kernel over dts memory node, while
kernel is built without XPA/64BIT support. In this case the region
may either simply be truncated by add_memory_region() method
or by u64->phys_addr_t type casting. But in worst case the method
can even drop the memory region if it exceeds PHYS_ADDR_MAX size.
So lets make sure the retrieved from dts memory regions are valid,
and if some of them aren't, just manually truncate them with a warning
printed out.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/prom.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 89950b7bf536b..bdaf3536241a2 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -41,7 +41,19 @@ char *mips_get_machine_name(void)
 #ifdef CONFIG_USE_OF
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-	return add_memory_region(base, size, BOOT_MEM_RAM);
+	if (base >= PHYS_ADDR_MAX) {
+		pr_warn("Trying to add an invalid memory region, skipped\n");
+		return;
+	}
+
+	/* Truncate the passed memory region instead of type casting */
+	if (base + size - 1 >= PHYS_ADDR_MAX || base + size < base) {
+		pr_warn("Truncate memory region %llx @ %llx to size %llx\n",
+			size, base, PHYS_ADDR_MAX - base);
+		size = PHYS_ADDR_MAX - base;
+	}
+
+	add_memory_region(base, size, BOOT_MEM_RAM);
 }
 
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
-- 
2.20.1

