Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2018 22:58:09 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:54392
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeDHU5tnAtVf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2018 22:57:49 +0200
Received: by mail-wm0-x241.google.com with SMTP id r191so14023291wmg.4;
        Sun, 08 Apr 2018 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZlhNnoW0pyOBX0F2rVTGt9WxFYEmL88MYx8hr1bDy4=;
        b=hWPUUnwFFkhRRS7uk1JaiMAQbXAfr7Z4E4bdGJ2rXzXKVIj0gESMRAZUee1wpaPpPK
         0Og4f8Gs+18ooa2LTmEhe5aNQGXT4cZYLlxt2J3vWtGWdohRvOqIa5mgpL9a6/yJ1FSv
         EZ69x82HgIEzpx7L/T9aT0QEO9W5Ss1rKeFD+j60rbtsYYfD1xqInpVBp4nVpTrAjdEg
         DWrpfC5YYMkQjwqwMimlcQ86DzNCOW7sJnBiNCUSLC4zSgHWhEPSuD2f7SVvoCnHBeuP
         cTuKBX2VsQOWeTHTcumcspCARvfx4LAaO9sStXUE+Ejhh3K+zI1ks8LLpRae7p1Ad5PV
         THBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZlhNnoW0pyOBX0F2rVTGt9WxFYEmL88MYx8hr1bDy4=;
        b=OIl5a0rb4LaGU0VOTN46cx9dUHxCBCucl0XByZn36ub2pzbSEEuq1ymkqaJv/0wlNY
         5mI4VF8GqO2lM8BV8RN+WAhNyY2MB5+ON/Ci1qZhcC8KkcaS/PGHIOXqb00bSGfPwV+f
         h2y3lwgaTqE+lk/XXFVJR7K65nsYOTil26NoqaIxmJ1qQDSscLY6iIoSWraOYkD8+Lzq
         JA3Dm679jRjq/QzzszL5ufEw7ByOQRTORQLsYpfQlobskhI3XvKyJhm/9nFm6zikKInd
         Qo3BwJkDPYzqMYrbr1QvzE8cuQNodJ/J/ktufKfw8UbgQOhnXWzl8JBoknFXV8jQ1r2c
         w5VA==
X-Gm-Message-State: AElRT7GftnStGddkHMHvyTwGW0q24Z5CXZ4OduU+PXjDACxDiFDxTN8h
        shw/UM6IWSJkP/HQxIFRWW0=
X-Google-Smtp-Source: AIpwx48lnNmiLONpQ7w8rBGSakvNM4f4kZGRJWLfeZq5PVPkSh7y1wKcM+0trTSFEsDLamaC1J5sIQ==
X-Received: by 10.46.133.217 with SMTP id h25mr20766516ljj.109.1523221064327;
        Sun, 08 Apr 2018 13:57:44 -0700 (PDT)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o2sm2558271lja.86.2018.04.08.13.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 13:57:43 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] firmware: bcm47xx_nvram: support small (0x6000 B) NVRAM partitions
Date:   Sun,  8 Apr 2018 22:57:33 +0200
Message-Id: <20180408205733.9026-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180408205733.9026-1-zajec5@gmail.com>
References: <20180408205733.9026-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

From: Rafał Miłecki <rafal@milecki.pl>

Some old devices with 4 MiB flashes were using 0x1000 block size and
could use smaller (0x6000 bytes) flash partition for storing NVRAM
content. This adds support for reading NVRAM on Netgear WNR1000 V3.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 0b631e5b5b84..d25f080fcb0d 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -36,7 +36,7 @@ struct nvram_header {
 
 static char nvram_buf[NVRAM_SPACE];
 static size_t nvram_len;
-static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
+static const u32 nvram_sizes[] = {0x6000, 0x8000, 0xF000, 0x10000};
 
 static u32 find_nvram_size(void __iomem *end)
 {
-- 
2.11.0
