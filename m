Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 08:11:35 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36598
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990601AbdEKGL13gd-K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 08:11:27 +0200
Received: by mail-wm0-x243.google.com with SMTP id u65so4392744wmu.3
        for <linux-mips@linux-mips.org>; Wed, 10 May 2017 23:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9u79LkJDNtGTZVBAS8tmHE/cl2YexJgR1gPOdeewFUo=;
        b=RrAJqFLnc/2w3ife1/4wrYXm0TcgCo/dOF6IGo35SjqEUd3ZTH5h90pVy82rrVOzBZ
         8zU4s3OffHdpfvNmAdaDwCol6fcGqK/NPCeTApv6J09MdA4zrmVel4oEm7GVcOvHSkTA
         C3PbgKiLJ+0vgL89AP/folVSWQte6EGayZpOv0OcUsfUxn6esSWcC49EGbOgYKJKaW5v
         VIiJSt1DpZ+7d1Q5ygNWS23KcTdUzfXHsBjWAmzlZXohbQUc+EDMOx9WXbGvOnTg36EB
         ic0/FCNaQTmX3vhum4h6nJHGl7Xa0IqeJEjyYZDRyO/WOQ5Z2RKHAxaGmHG10mz/0Qwb
         /7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9u79LkJDNtGTZVBAS8tmHE/cl2YexJgR1gPOdeewFUo=;
        b=kjMaqnaEYoo3xWr9GJSZmDQccqaC9dmrsGAN3TRHvsHpRJtVXCVevCxxHv+MCYqUI7
         wcjfCpmn12mbCrHe358dzRz9+9muqzdn02mcy8JNvUVmMcKiZxw4rQbWhos7ezXc64FQ
         K+2BoD9Ks5th8D54ZGBBNp2ZHfjEDG5N++TFXIAZr79BTT4TVCUkBF8m8Euu2unkV2wx
         IHDImROpBj3smbFNDVm9tHY+UzGQKkXO2hAGtlmGT5PTf9KmvebMlO+aXodqs9vt828i
         3OL3V3V0UO+PoxOMVUlBuppQK4FmZ70os+cB8x1YJrezDK8vsK7Hbp+HbsKnH+uaQgAe
         k/SQ==
X-Gm-Message-State: AODbwcAi09SUdfYehL0ByvL7sv7Zm81itZSZd+EXfuOZiCwHdekV0mnd
        W7atqgmJUUt9bA==
X-Received: by 10.28.168.3 with SMTP id r3mr3269132wme.33.1494483081914;
        Wed, 10 May 2017 23:11:21 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p2003008C2F2A1200A8F56D34CBAF763D.dip0.t-ipconnect.de. [2003:8c:2f2a:1200:a8f5:6d34:cbaf:763d])
        by smtp.gmail.com with ESMTPSA id e125sm952871wmd.33.2017.05.10.23.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 23:11:21 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     ralf@linux-mips.org
Cc:     john@phrozen.org, linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: ralink: fix MT7628 pinmux
Date:   Thu, 11 May 2017 08:11:14 +0200
Message-Id: <1494483075-17816-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

According to the datasheet the REFCLK pin is shared with GPIO#37 and
the PERST pin is shared with GPIO#36.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/ralink/mt7620.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 094a0ee..528a6ac 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -144,8 +144,8 @@ static struct rt2880_pmx_func i2c_grp_mt7628[] = {
 	FUNC("i2c", 0, 4, 2),
 };
 
-static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 36, 1) };
-static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 37, 1) };
+static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 37, 1) };
+static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 36, 1) };
 static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 38, 1) };
 static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
 
-- 
2.7.4
