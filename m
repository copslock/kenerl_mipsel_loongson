Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 20:09:24 +0200 (CEST)
Received: from mail-wr1-x441.google.com ([IPv6:2a00:1450:4864:20::441]:45120
        "EHLO mail-wr1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeIYSI7S1JDH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 20:08:59 +0200
Received: by mail-wr1-x441.google.com with SMTP id m16so7841030wrx.12;
        Tue, 25 Sep 2018 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aL5T5Qh+oA9oOnuNZ5zxuTk7P9cDVFLf0HY33WTeFy0=;
        b=ikVarA4eJIcV29KoWwcVVYKHU+saFjDeb+Jjoy17lHNYqW6OpFW4WhRK3WWnpqpWIW
         XPvWWTDno4cDf+keHs6qhWQalwvb3UMZazRPrl88KsU0iYbONyQCYBjvFXbdwvpwFA2w
         vwIdEPTLUIejSCuJO1P3Q0MD2ZEaVaRhy7B3ujEWAJUE+uk6RaqoLcCn1SzO9nwthVfn
         wrfrzoPHojlraI80JkdT/56deg4YQG7VCUljuskbuInm2WxfhdEPttyEFO4DYcMPX/SX
         mKfjC2kWkYfXfwbMQHYY3GxNbmTQDPuI0+wZjnKlL3FtPDRKiftFqVyWi2x2EpFzSp6s
         mmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aL5T5Qh+oA9oOnuNZ5zxuTk7P9cDVFLf0HY33WTeFy0=;
        b=WCJA+B0apQthVFfdys5ykKTpwvbeF0GFFaetKHcBW/hf0ILIbB9N139SdkWkDt8biN
         FWiLh+4DLp0CrUqT9AR0uaJNuxrVqAEZ8aLNh8hRdckaS1107OV1af2DIlykEfWd19qa
         eYOHI2aWmPwgwKjLiJNzqvNHZFUVmnGj2XFrWKx7+vRRLX0zUsHi8U0gm3WjAvGh8ihd
         bw6+BEwMLkYVqoUgsrkusUDFgrlZYAoaDK42hQHV5bw2pd4bVonfcmVQmv8qdRMyQH4I
         xKyLP56YV+4XQEDdggJVEOjLj/VNt6P4X9APYoRfePFi5DjUItxkiwinLO8J9+XGmM+/
         JhXg==
X-Gm-Message-State: ABuFfojGy828hXqeKtJzfWKvzzgxqN958KrJGToxfj2/b41hHz8J2IgU
        vOeGQyFANOBB/GY1iDGMCDUyk1vyQdU=
X-Google-Smtp-Source: ACcGV61O0Ko6JP0N3FE8Wa+75Rdo37r87nrfq17PpgBScoOQ0+aBhHeXjl8G19n9HOdHENsYec+ytQ==
X-Received: by 2002:adf:ac4a:: with SMTP id v68-v6mr1915078wrc.165.1537898933774;
        Tue, 25 Sep 2018 11:08:53 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:53 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] MIPS: BMIPS: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
Date:   Tue, 25 Sep 2018 21:08:24 +0300
Message-Id: <20180925180825.24659-4-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

The ELF appended dtb can be accessed now via 'fw_passed_dtb'.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/bmips/setup.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3b6f687f177c..b71b6eaaf7ed 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -153,8 +153,6 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = freq;
 }
 
-extern const char __appended_dtb;
-
 void __init plat_mem_setup(void)
 {
 	void *dtb;
@@ -164,15 +162,10 @@ void __init plat_mem_setup(void)
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 
-#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
-	if (!fdt_check_header(&__appended_dtb))
-		dtb = (void *)&__appended_dtb;
-	else
-#endif
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
-	else if (fw_passed_dtb) /* UHI interface */
+	else if (fw_passed_dtb) /* UHI interface or appended dtb */
 		dtb = (void *)fw_passed_dtb;
 	else if (__dtb_start != __dtb_end)
 		dtb = (void *)__dtb_start;
-- 
2.19.0
