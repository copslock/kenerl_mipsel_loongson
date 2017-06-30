Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 07:48:40 +0200 (CEST)
Received: from mail-pf0-x22d.google.com ([IPv6:2607:f8b0:400e:c00::22d]:35257
        "EHLO mail-pf0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbdF3FrQs46Dm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 07:47:16 +0200
Received: by mail-pf0-x22d.google.com with SMTP id c73so61639617pfk.2
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 22:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgUFbN42bUExTBiKQuWWHB0EIV0fAWCgdJ5DTTjMntQ=;
        b=WP4SYZov6wJipxSoTDlGjARFHLQ1OQhlc/LVEdPbepsJ0idTX0QTOaPohNi28UhTFT
         g7asy32Q0y/w+al/uD5IwH8YHzmuAGlmWQd0QHhmpE4aYcH3yZSwqFWCr54FS0a62Wlj
         aU5NPY3tksCGTArlAelmhnNOrKLQw2+o665No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgUFbN42bUExTBiKQuWWHB0EIV0fAWCgdJ5DTTjMntQ=;
        b=etJ+SofYr75rGSAK+1OsaLHijwJ5pw/KGKc159YI9lw3Bcz5tJVltmuBeLtUM0WAg9
         KbQ6DzYmYOFst4ntH/u+6914fgH0DqZxPEYksYkDM78Nhltv3rl5/ZvnIKtczPF2leAp
         ouJ09KpCCfO2mTpz0pPRRyZ9h6CXlsly6fikmZfn2DQi55UBMI2k/eWyaykRV/JF51q9
         Yldola4fMScUmj8b7i38BF9ry/zlrr4LbDislDjPIZnzoSquOAtIly8h143uJKJQop/B
         o3j0zFqgFat010ChnUy5mXkOBfYfudUmcagyX7UlqnHnjKZxCY5t7pF8DmKSNPvkgSRW
         S79g==
X-Gm-Message-State: AKS2vOxp9kX8IJNdsomchiMU90Hs8j83tN2W8fIEEX/hpNaRHjRgYt2I
        682Y2h8C3Pw69pmB
X-Received: by 10.84.216.26 with SMTP id m26mr22626914pli.112.1498801631078;
        Thu, 29 Jun 2017 22:47:11 -0700 (PDT)
Received: from localhost.localdomain ([106.51.129.233])
        by smtp.gmail.com with ESMTPSA id a187sm11405550pgc.37.2017.06.29.22.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 22:47:09 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 08/16] MIPS: ralink: fix MT7628 pinmux typos
Date:   Fri, 30 Jun 2017 11:16:32 +0530
Message-Id: <1498801600-20896-9-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
References: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Álvaro Fernández Rojas <noltari@gmail.com>

commit d7146829c9da24e285cb1b1f2156b5b3e2d40c07 upstream.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Cc: john@phrozen.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13306/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/ralink/mt7620.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 4c17dc6e8ae9..37cfc7d3c185 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -223,9 +223,9 @@ static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
 #define MT7628_GPIO_MODE_GPIO		0
 
 static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
-	GRP_G("pmw1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pwm1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM1),
-	GRP_G("pmw0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pwm0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM0),
 	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_UART2),
-- 
2.7.4
