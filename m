Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Mar 2013 14:39:43 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:65025 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823013Ab3CQNj0hUvMp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Mar 2013 14:39:26 +0100
Received: by mail-pb0-f51.google.com with SMTP id un15so5732885pbc.10
        for <multiple recipients>; Sun, 17 Mar 2013 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E9fC0lIGtyaVUK2fx1EcAUx7K1rAO4na32xpiChAA50=;
        b=PHycwjndQGJXoUEPnm2SYApG/1HUf6Dp4zv88tx4HnESmOGKO3fLLyJMW6E3ijnjyI
         0GVA6kBLImMmoIr5wOlNhZcZw+E6Wp9C/+pSsBlxHu8nvo7Tj0LVmKUELmY7T8PEFSQA
         PpxK1YLRSy6nmc4Qw5jJp2D885qMTFFLTPpljUL3yxsChxQ4dltua+GEfOPT29u/oDru
         0gOHZx8L3cpnC3+DX8eEn510fjKD03IAhqRiNopqK1/h7vClsgf9EBh//EjvlvTiJFxj
         lj6GKR1Eh8xf8o1YB93ynZHD89ZCELkJEm+2zcAHTWiFNug60tXg65Qq7ULWGWRBQyv1
         RNPw==
X-Received: by 10.68.137.42 with SMTP id qf10mr27779593pbb.80.1363527560152;
        Sun, 17 Mar 2013 06:39:20 -0700 (PDT)
Received: from localhost.localdomain (softbank126010191003.bbtec.net. [126.10.191.3])
        by mx.google.com with ESMTPS id xr3sm16722123pbc.46.2013.03.17.06.39.17
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 06:39:19 -0700 (PDT)
From:   Alexandre Courbot <gnurou@gmail.com>
To:     Mike Frysinger <vapier@gentoo.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, gnurou@gmail.com,
        Alexandre Courbot <acourbot@nvidia.com>
Subject: [RFC 1/3] mips: pnx833x: remove requirement for GENERIC_GPIO
Date:   Sun, 17 Mar 2013 22:42:01 +0900
Message-Id: <1363527723-32713-2-git-send-email-acourbot@nvidia.com>
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363527723-32713-1-git-send-email-acourbot@nvidia.com>
References: <1363527723-32713-1-git-send-email-acourbot@nvidia.com>
X-archive-position: 35902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

pnx833x does not seem to use the generic gpio API.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 50cded3..ff0e563 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1107,7 +1107,6 @@ config SOC_PNX833X
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select GENERIC_GPIO
 	select CPU_MIPSR2_IRQ_VI
 
 config SOC_PNX8335
-- 
1.8.2
