Return-Path: <SRS0=5/jd=PN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB6C43387
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B88E2085A
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 15:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCuFJowo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAEPBM (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:01:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46984 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEPBM (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 5 Jan 2019 10:01:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so18752055ply.13
        for <linux-mips@vger.kernel.org>; Sat, 05 Jan 2019 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z6QohCfjUAlpVS3+5Mx2RTATgU/q4jLJs7i4ICxN0SE=;
        b=NCuFJowoGxz/oUN2FbUqlGpiER9k0U4acsOGEn1h4idvzV5kG4L0iwPtjRdk4pVI/M
         ZyT0Jtl8Cnp+OK81ZJFKqPa1q6Knd9jMnBvzxJEkr3EUNLl4teRoorkPfF/8Qfu3stEe
         d4umMUOHAz8436B7ofdmPz0oqEbOvHgYNIzTnE3AAL8rTWQgtYmttMmY+Gz3AhGP8hNs
         kdkAGF8H4gXS5O/58nABF2Eo7G2R3033q5Rub9ro/OgalmKKFAGtCnR7CmwGKkYDFso9
         y7uBcGRb1qDmHIwpA/1j+CjjN5WmwqGt/H/kN6XpBPQuRgFdklomQx4D5W7AWrmGTBei
         EALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Z6QohCfjUAlpVS3+5Mx2RTATgU/q4jLJs7i4ICxN0SE=;
        b=Xc/do2pSY8lA4T9BEoYJXLP0z9+EO0I/ZMzz/AFpnFr5tSyqvQ/aTclM8JMJDO7jHE
         GrYBhwfl+ML6Q9gcDJOy0DqVrgtdKDy1nLcPNAj3vSIFD1HYARmgpuOpnGhVjAszX/yi
         VGh/CJfximYArSwNM9Nrv58yNDIc8EMNdR5diVYLLPFsWIeXaxhA4ljQeUiRdasCReIl
         /Vgglt1709UETONx3DoB0eIVUuGymZfo3sQSDvvtuRzVkyGP8GLK0ydTL57NXro+OFXe
         KeeaxOsjPFSvfw5HzRz+9MZYZTQau0VfHTr8wuZqHS09YmX2mnSL0sKOQn0HKJRku3X3
         p/Gw==
X-Gm-Message-State: AJcUukcmURAdhYQEhtmmmQhMPEjzfrkuRaXExWpgLnYekfgJYsrIyeZ6
        xexAW+YcVguBsT13EYlmucE=
X-Google-Smtp-Source: ALg8bN7DgYdIASRl9Rr2JjpRU3f3DUehkxbxxnias9slbtyBwEc/ZF6JAOnTVwsm6cduvdrs1xXrIw==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr53222909plm.45.1546700470892;
        Sat, 05 Jan 2019 07:01:10 -0800 (PST)
Received: from localhost.localdomain ([47.74.12.188])
        by smtp.gmail.com with ESMTPSA id j21sm87248890pfn.175.2019.01.05.07.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 07:01:09 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     pburton@wavecomp.com, linux-mips@vger.kernel.org
Cc:     chehc@lemote.com, syq@debian.org, zhangfx@lemote.com,
        wuzhangjin@gmail.com, linux-mips@linux-mips.org,
        YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH 1/2] MIPS: Loongson, add sync before target of branch between llsc
Date:   Sat,  5 Jan 2019 23:00:36 +0800
Message-Id: <20190105150037.30261-1-syq@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: YunQiang Su <ysu@wavecomp.com>

Loongson 2G/2H/3A/3B is quite weak sync'ed. If there is a branch,
and the target is not in the scope of ll/sc or lld/scd, a sync is
needed at the postion of target.

Loongson doesn't plan to fix this problem in future, so we add the
sync here for any condition.

This is based on the patch from Chen Huacai.

Signed-off-by: YunQiang Su <ysu@wavecomp.com>
---
 arch/mips/mm/tlbex.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 37b1cb246..08a9a66ef 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -932,6 +932,8 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 * to mimic that here by taking a load/istream page
 		 * fault.
 		 */
+		if(current_cpu_type() == CPU_LOONGSON3)
+			uasm_i_sync(p, 0);
 		UASM_i_LA(p, ptr, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(p, ptr);
 
@@ -1556,6 +1558,7 @@ static void build_loongson3_tlb_refill_handler(void)
 
 	if (check_for_high_segbits) {
 		uasm_l_large_segbits_fault(&l, p);
+		uasm_i_sync(&p, 0);
 		UASM_i_LA(&p, K1, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(&p, K1);
 		uasm_i_nop(&p);
@@ -2259,6 +2262,8 @@ static void build_r4000_tlb_load_handler(void)
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
+	if(current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_0 & 1) {
@@ -2313,6 +2318,8 @@ static void build_r4000_tlb_store_handler(void)
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
+	if(current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
@@ -2368,6 +2375,8 @@ static void build_r4000_tlb_modify_handler(void)
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
+	if(current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-- 
2.20.1

