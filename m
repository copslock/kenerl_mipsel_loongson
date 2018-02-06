Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2018 04:13:50 +0100 (CET)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:43342
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990393AbeBFDNlxNUtP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Feb 2018 04:13:41 +0100
Received: by mail-pl0-x244.google.com with SMTP id f4so390206plr.10;
        Mon, 05 Feb 2018 19:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lvkMOYhT+DyqjVAsGbyg/PLFCiKpG+RVdxINj3+3I54=;
        b=G0cH94Z1F6BP9q8laNgtuSs/gHQLJF4Px0YIpVy2KxBwDXfAFGKuBLpJc0ZGQwV7a6
         kUSBQi83OMmb9zHsDur7P8AOESEm0yL2YfEciVMRSr85hObsdHjrWQ5L0jMlPFCuxvg3
         zNdR3l5EMNvaOFGwCQm5gfKP2BDzKZNrkqx0vgIzyBa/IaDfRoqm9nkJN5SwDfV/B7O+
         XgAoIpM3l3agnHt5Z6sAq7iAjw4K0S9Hwk0b4CEeAjiGx1tOKWsvJ/8w2zvpipd4vX2E
         dt72jVddv7Y3M4JhWRF04y1gW00kimC6AGxwHl49C3+yIh91znOEbJCfiZQ983L1Amaa
         +N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lvkMOYhT+DyqjVAsGbyg/PLFCiKpG+RVdxINj3+3I54=;
        b=R03PSql/PP6rkMgiw/Kaq2DUV+AxcvjI04Bbbv2FrnCRwGQkwmlbr8JF24BeyW+SEm
         j0FdmGhg4l0z06TzwvH9fnKpA5NxQiJrjRwjqrKHbdzF9fHR8zuL7UGiDJeQNjYMOIyn
         XsvUyLpPuTQ5i8ARsZRl7Z8b6EA24GlGyyPqLRf/S/7/KhaVTLDGUxvKlJHN/PQ4EXn4
         2m7vqWts7SwN9kg1MDPYc+nKqr3PqAKhGRCTbMaoERxtWKTjVHAgExBPQVimeR7Ub7XX
         4wUYSUwk+8YwmLqDFbFJHORq2EaK56Ip0yLHrL6SUKqHd3Lm+FajQv8Qygk6oSDeCzE9
         uatQ==
X-Gm-Message-State: APf1xPATqH6p7tElbAOUBmIVlK3bsnjn1O1NvKO5fuiiWQwMVuZY4NCY
        ua41vnWrtzzI9Q498A3E1ZpcoPHv
X-Google-Smtp-Source: AH8x226bFa0T3NpmRYpNjPG1ktwGQLDTZUdZB7PdiqF0pE9sPJwqaAh4eJBOjBkPaUvlEpnDJKXeOg==
X-Received: by 2002:a17:902:a9ca:: with SMTP id b10-v6mr953480plr.223.1517886814841;
        Mon, 05 Feb 2018 19:13:34 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id g63sm9719548pfg.17.2018.02.05.19.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 19:13:34 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Fix section mismatch warning
Date:   Tue,  6 Feb 2018 12:13:21 +0900
Message-Id: <20180206031321.34599-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.16.1
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Remove the __init annotation from bmips_cpu_setup() to avoid the
following warning.

WARNING: vmlinux.o(.text+0x35c950): Section mismatch in reference from the function brcmstb_pm_s3() to the function .init.text:bmips_cpu_setup()
The function brcmstb_pm_s3() references
the function __init bmips_cpu_setup().
This is often because brcmstb_pm_s3 lacks a __init
annotation or the annotation of bmips_cpu_setup is wrong.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 87dcac2447c8..9d41732a9146 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -572,7 +572,7 @@ asmlinkage void __weak plat_wired_tlb_setup(void)
 	 */
 }
 
-void __init bmips_cpu_setup(void)
+void bmips_cpu_setup(void)
 {
 	void __iomem __maybe_unused *cbr = BMIPS_GET_CBR();
 	u32 __maybe_unused cfg;
-- 
2.16.1
