Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2018 20:08:17 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:33629
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994748AbeA3THuQiaZ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2018 20:07:50 +0100
Received: by mail-lf0-x243.google.com with SMTP id t139so16989120lff.0;
        Tue, 30 Jan 2018 11:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DrxXdiWWbNjvXacFDQ80uUw3x4XjUJ6shA9HeDmAfRg=;
        b=o1R79iSPnDs40APDXVN1eS0WxHE4dwyONKCDdvX5ATLBiBt8hkbBmvl0RTVV5VeTc5
         1qSPECmuTd5G09SS8qoxi3B3x9CQCCJYt0bcqMfkAEtSk0KVbO551lzpsjzLYPWV/TOe
         n3GO+zS1iBZp8m2DT2es3IxlRB+XpjbS9E9vPQn6rmowBS6mQDypYnK9dh+f4g0IXaLk
         Z7X27JyK4eHVDIQv4UVHxF8joptdFr627aOs7HZdVYlM4Gnb94VOi38NjtWsVhP01Aua
         TIV8Z22Preg6ktVStCtxHsPma4IAZncF+I/v3oWHLvkUiFdZJKKzZ/Fsh6RYrzSM3kFI
         tOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DrxXdiWWbNjvXacFDQ80uUw3x4XjUJ6shA9HeDmAfRg=;
        b=XGaLL9VG4EjqxEtyul9N7cmwRlrbRkNm3TQRbOOgFsMyTAyNbKXYStLbhidlXasAQ3
         8BKoKO+AM2Pr+3CucVeG7KRTA4GKTPw4BdzbAM5sGkY8FzcGnCpBjac1B0uBD8K71SEU
         2RMmEEtGaMeW1ofT+ma9EVvBJFxVKtze4VGavlki0XEJoQdzHtwrfbrJRsIX7VVR7NwQ
         anLHCflsgSylJcExdEqi892Txh8BxDP76KVKBv9Oevzkfo98r0gPsRcn9XyfuDVf2Uqz
         enrChENQ3+Lrc4+G24wkoMNKd9sZvD7BLigONbpgc56cmY2Ov93KTUTocf3OoThFGlLZ
         xkHA==
X-Gm-Message-State: AKwxytdBau2Rmxro/F3jmlXYFt++WhRrtNQCqbe0TXff2JitVGy6lYwY
        DYLr1rf/6F57XYYdVXRbjuY=
X-Google-Smtp-Source: AH8x227fKki/5Z6VmrGUOWNr+ILj59H8M3KuJy6sTdVOSf3cvo4OIRiwgVn1e79obZVcHx3GchflFQ==
X-Received: by 10.25.145.94 with SMTP id y30mr16582125lfj.1.1517339264847;
        Tue, 30 Jan 2018 11:07:44 -0800 (PST)
Received: from huvuddator.lan (ua-213-113-106-221.cust.bredbandsbolaget.se. [213.113.106.221])
        by smtp.gmail.com with ESMTPSA id s65sm3547115lfi.93.2018.01.30.11.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 11:07:44 -0800 (PST)
From:   Ulf Magnusson <ulfalizer@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, mcgrof@kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] MIPS: kconfig: Remove empty help text
Date:   Tue, 30 Jan 2018 20:05:30 +0100
Message-Id: <20180130190555.6577-9-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130190555.6577-1-ulfalizer@gmail.com>
References: <20180130190555.6577-1-ulfalizer@gmail.com>
Return-Path: <ulfalizer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulfalizer@gmail.com
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

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ab98569994f0..57cd591e7b28 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2326,7 +2326,6 @@ config MIPS_VPE_LOADER_TOM
 config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
 	depends on MIPS_VPE_LOADER
-	help
 
 config MIPS_VPE_APSP_API_CMP
 	bool
-- 
2.14.1
