Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 03:16:10 +0100 (CET)
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36586 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012552AbcBDCPGzdHzx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 03:15:06 +0100
Received: by mail-pf0-f169.google.com with SMTP id n128so26677289pfn.3;
        Wed, 03 Feb 2016 18:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kYK4JiyG1pJdqBYcBxIULWdM7yfVi8i068Md8La2670=;
        b=o2RAREEtM8YoaNttBE+kft26YO1OrLrBvAJicm46dyx8m947sA3hS+mMDi3YJ8bgtt
         Fj4pgbujuYhjPPWfBaz3JM+H3pkhXm6p37W715G4Q5mBpqJeXvgJ4+T2U2yJKe/uzk5e
         1/6JPe9pe2SLUL3fwnfnY7BhwajCihhm/nH295iAlaNMMtmwC5hrbWxoHmTORVpOhNpS
         kh64PdtOE8IFMOfL8DtwuSlXqkqg0FihK4C3I8j0FXnpAuf0lHYTNMuFopp+DOXxISCq
         O0JrfPI+7XlVQjmsEEw2qCFWYODvWQ2p6F0QSJVa7kc3jTKodf+VWEkvisyV7h29Pckb
         jWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kYK4JiyG1pJdqBYcBxIULWdM7yfVi8i068Md8La2670=;
        b=W32g1HwooSluVYeF3rezmjKUp0sPXcnnwzf6l/Ed0VZCZu4rncMNXY19vPNGuTm+2Y
         Hx6+G8ro7CX3pCaf6Rcb+2EcasLzK0/2FsERi0KznucADQnwgKd7PvoxpROgVaRdjAZi
         4gzxPKNuMtHyR3+4B/VOHc0g4mwwC20Ds6b7j8ENLaDv/aj4hpixgkUIKFBLsY6YCQCq
         TC3ym4q22S3BbUwYcjigKJLhJHF4n9uuu3YTVpXbBQ4vg2Y0nSFmyvrHWf9RAm0VnDxr
         ms2Y6Bdjn1pKyIFdoLz8FPRa/vw5fgBWF7pLzyaTRO+XSy5jcF+HUqD/wNr1doZgCFbN
         EeTQ==
X-Gm-Message-State: AG10YOT3lGA8uKU2GgnCT/YwaQrFIEvsVrmPX2rMXhwViM5SsPrQxOMuBQV3ALVIhhj/Kg==
X-Received: by 10.66.97.39 with SMTP id dx7mr7421792pab.74.1454552101221;
        Wed, 03 Feb 2016 18:15:01 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id l14sm12646282pfb.73.2016.02.03.18.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 18:15:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, jaedon.shin@gmail.com,
        dragan.stancevic@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/4] MIPS: BMIPS: Fill in current_cpu_data.core
Date:   Wed,  3 Feb 2016 18:14:53 -0800
Message-Id: <1454552093-17897-5-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
References: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51716
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

Read the core ID in bmips_smp_finish() for BMIPS5000 CPUs to get appropriate
processor parenting in set_cpu_sibling_map().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 78cf8c2f1de0..6d11788b4502 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -243,6 +243,7 @@ static void bmips_init_secondary(void)
 		break;
 	case CPU_BMIPS5000:
 		write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
+		current_cpu_data.core = (read_c0_brcm_config() >> 25) & 3;
 		break;
 	}
 }
-- 
2.1.0
