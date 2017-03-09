Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 22:12:17 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:33196
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992123AbdCIVMKSeW7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Mar 2017 22:12:10 +0100
Received: by mail-wm0-x241.google.com with SMTP id n11so12883406wma.0;
        Thu, 09 Mar 2017 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3EB3HIMFy8ckJUbOvh0Yho8bUItUM6f0GLS+Dt2GZao=;
        b=XzprBMoi9Z41iefDnF8bLKWChNgi1qIhpQIGV9nDKe6QUMWbJVUBi4Im4p/4x/sYOu
         8jHXE/K1VzPhf7E20DweFfX1YYX3Mo+L5sj4SaMqfEqksLxtYs84xdOBpxSV2T0OUMSH
         N5bhnvn8CHdZy517ADtaELJs2ye9pZk7iSB0m7HacMwsWo6vLweD9kBUXjQIc+mB+f24
         kgTe5QAFame5CHlsZ3zFoG+trc1DKkhmZyUqRs8ZDITkaYFRNZWNEwPAMbIATq2BJAkg
         aeYTT1Xq1Tie/uguAlU9StwNzWTl4URbJxSYwLhxf1IIUq/JaJbRUUy7iElLE5iFqgtP
         bpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3EB3HIMFy8ckJUbOvh0Yho8bUItUM6f0GLS+Dt2GZao=;
        b=aWqbwNGnAzcloIvbn7V4wZuMbg08ICcgaALj23yu298qlwLPs/l0Jp3llceshz7bDk
         bCDxIEE282e2m+LJw/kWs4S6ulWFAs4TLVmaIpy7iulxxJJVLJR8+WKvFZg/zYHM07bo
         dvB6VQSjQzShiWhuSNj3oPQobAEmSwzHgwRKtlTJDnVI/PD+GSc8WgfhvVH9WVf4Hqpv
         vVxifR4JPDcgmk2H/DULcH9uyYMrINOWHB1VtpDzPibDmJgAesB+/Mcslest4gDEQ81U
         yE9Dr66Tfw1GsKGAFXevoKA6PCBkJ3IURAYU7Jd/7zf1Sbb8Bc5LgNyT6x2EgsG78jFq
         vP6Q==
X-Gm-Message-State: AMke39kBEcP4gbuWE71KxFc//SqA7q/C8nUWC+Dkgsiv+aMrHKLxo9Z77KnZzLBooHvpzg==
X-Received: by 10.28.4.10 with SMTP id 10mr31304595wme.142.1489093924947;
        Thu, 09 Mar 2017 13:12:04 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id m188sm128813wma.27.2017.03.09.13.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 13:12:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, macro@linux-mips.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: page.h: define virt_to_pfn()
Date:   Thu,  9 Mar 2017 13:11:49 -0800
Message-Id: <20170309211149.8339-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Based on the existing definition of virt_to_page() which already does a
PFN_DOWN(vir_to_phys(kaddr)).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/page.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 5f987598054f..ad461216b5a1 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -240,8 +240,8 @@ static inline int pfn_valid(unsigned long pfn)
 
 #endif
 
-#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys((void *)     \
-								  (kaddr))))
+#define virt_to_pfn(kaddr)   	PFN_DOWN(virt_to_phys((void *)(kaddr)))
+#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 
 extern int __virt_addr_valid(const volatile void *kaddr);
 #define virt_addr_valid(kaddr)						\
-- 
2.9.3
