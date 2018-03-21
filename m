Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:36:15 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:34635
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994769AbeCUT3SeYfIZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:29:18 +0100
Received: by mail-qk0-x243.google.com with SMTP id z184so6723194qkc.1
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/vYHgpyAcmfbiYWIad+N8nRx/97zBdHPHIr2FMh0LU=;
        b=Hcn13eOFhjcyqkt/d87Bg7a6u//It0c4iSpMa6yR99E/F83JFyjDvHrJyxJDKsiE1X
         cuZPqVKy4L02e4s564yv4gpHBh6Ar2pmpmXqL6pqJI2hivrTf78ntadi5mCZBz5HHF+3
         sqldNc1gLt/McbvsiwMhhzEnaWEeco3JbKHKyOnib7F78HCKmTkcF0oaI3m9kOJ1ljkM
         1yuSDsmJOEz06htND+q2o7Yk2EskT6hMY6YUFaw57fk81Te7nkAJLZ2CqW0QlfDiP0zS
         ZdT66Vjmkx2vtprPPyWt38NEwRY0WMkwKIDr61tWCyLIPsXHIKE+KXLnNZj6S8dzPUWz
         mzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/vYHgpyAcmfbiYWIad+N8nRx/97zBdHPHIr2FMh0LU=;
        b=H6DLztwespUya3Qyb5p808ey7+L79O+m3CIn5ZhCdAXpHnqFEeNghX5EoEWuHD5ESr
         v1w6XLEWxUmL5He9yf+2tjfXelBxNFV4xW9s6m1w4mP0PSGLZZaR6YB4+ylRzjnZ+Aqp
         lXhgvtwhPOEfIHX9LN05HI8q/Z32I6GwR/KiPJ4A5ERz6xt4/ucB/Bp5C7fEkfOrFsY5
         2+FoFMv0VdD/o0+vMoN7rSbsk5hZvmZEg5lMPOiWs6I/OPio0JAJVQ8v45EqhquWX5ur
         uJtcUELH9ytVpvBup7tlsW8FYE14npc77aI6RNGC3J8mJWlxpx4qHZ+u2VYcx3UBkb/H
         EJ7g==
X-Gm-Message-State: AElRT7GdiqrOtw/hoxyPUTYr2UtOJaBTq7xIcvGwWPhmWe95qco14V3S
        KgJXDEGnrWeyCY6KaEg4Jk+4oA==
X-Google-Smtp-Source: AG47ELujRirFLxJhf/gbipbpT6bPGcr91BcITjkaYkohjh0iaUH621f70n3hLfs46LZPL7Obr/Y3dg==
X-Received: by 10.55.105.131 with SMTP id e125mr31542935qkc.322.1521660552830;
        Wed, 21 Mar 2018 12:29:12 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:29:12 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 13/14] MIPS: dts: ci20: Enable MMC in the devicetree
Date:   Wed, 21 Mar 2018 16:27:40 -0300
Message-Id: <20180321192741.25872-14-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Now that we have support for JZ480 SoCs in the MMC driver,
let's enable it on the devicetree.

Acked-by: James Hogan <jhogan@kernel.org>
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index a4cc52214dbd..0ab5f59a56dc 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -36,6 +36,28 @@
 	clock-frequency = <48000000>;
 };
 
+&mmc0 {
+	status = "okay";
+
+	bus-width = <4>;
+	max-frequency = <50000000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_mmc0>;
+
+	cd-gpios = <&gpf 20 GPIO_ACTIVE_LOW>;
+};
+
+&mmc1 {
+	status = "okay";
+
+	bus-width = <4>;
+	max-frequency = <50000000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_mmc1>;
+};
+
 &uart0 {
 	status = "okay";
 
@@ -203,4 +225,16 @@
 		groups = "nemc-cs6";
 		bias-disable;
 	};
+
+	pins_mmc0: mmc0 {
+		function = "mmc0";
+		groups = "mmc0-1bit-e", "mmc0-4bit-e";
+		bias-disable;
+	};
+
+	pins_mmc1: mmc1 {
+		function = "mmc1";
+		groups = "mmc1-1bit-d", "mmc1-4bit-d";
+		bias-disable;
+	};
 };
-- 
2.16.2
