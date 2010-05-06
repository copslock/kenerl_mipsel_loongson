Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:31:10 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:62885 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492659Ab0EFRaN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:30:13 +0200
Received: by pxi1 with SMTP id 1so87780pxi.36
        for <multiple recipients>; Thu, 06 May 2010 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=cGxNLxtGAmwMoBTLvay6CnmQHy0RaPXjevi0hWlWRrs=;
        b=pETGg2fayTpBsISVxay4I/92bAJxWpmiYZNmh8JiuF+RYT77b+hDmfs8DqDFLqmgUx
         HrKe6tCXNd0a6SBLDRnNqlhZCzaH/f4rC7QAXl/79A2BnHPBym03cbXPuXkf/AUvbiEW
         kY30h6Dww1kz4/Dx/n9Hp7rU4lkFIOecZy5vM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VJTJxLJHetvUdzqcPCLMfdciGrs3z0eufr17vlbh+dzrgEn8uPn5Cs/GI0RNMyy1uQ
         AxMC3jqAnZQpBhODhgXuxXa29G0Cl8hqjp1c3bGC+9Nqvi1LW6aqwz48Ztsmt37q728w
         alqS6Ug94HiTK2g0hZ6uRf4K8sntxm8jHn1DY=
Received: by 10.114.250.6 with SMTP id x6mr9641753wah.33.1273167006759;
        Thu, 06 May 2010 10:30:06 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm5257084wam.5.2010.05.06.10.30.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 10:30:06 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/5] Oprofile: Loongson: Remove unneeded Parentheses
Date:   Fri,  7 May 2010 01:29:45 +0800
Message-Id: <211d09af2c3e38694f6a1cdb3954402c20adb70e.1273166351.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <cover.1273165681.git.wuzhangjin@gmail.com>
References: <cover.1273165681.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273166351.git.wuzhangjin@gmail.com>
References: <cover.1273166351.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index afa0d7c..e2696d9 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -72,7 +72,7 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
 
 	if (cfg[1].enabled) {
 		ctrl |= LOONGSON2_PERFCTRL_EVENT(1, cfg[1].event);
-		reg.reset_counter2 = (0x80000000ULL - cfg[1].count);
+		reg.reset_counter2 = 0x80000000ULL - cfg[1].count;
 	}
 
 	if (cfg[0].enabled || cfg[1].enabled) {
-- 
1.7.0
