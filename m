Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Mar 2013 14:40:17 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59242 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3CQNjb6MGcb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Mar 2013 14:39:31 +0100
Received: by mail-pd0-f173.google.com with SMTP id v10so601149pde.4
        for <multiple recipients>; Sun, 17 Mar 2013 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sLSB9AjRpBHlNg/NOCBse9seNEKIskd4osTX5vG7mXw=;
        b=UciWLBjSnj7zuyTBHp6rLgQB2fbO3Iz5FIXn9w+tU6aQ6nHREQyTsO9YsLo8SC/J7v
         N8jeavzwVD2OgGUjJplJpvwcxJYrtXQ3Qd+GnpcaHLtzdvBXvhJpzncStHUjzy8POHPO
         Ur80tt8WrDdo70d5M2xKjQqREF6XI7JvWgsqz2txFU1g5pbpm8d0uLR1dAffoMlFlEcU
         9dtdDtiZOZVaDCrYfpEkc56AhWXXzckOlRdmKoi7P8X+XaovxKZTQo+D7Fz4vvJSxnPY
         aCRX9YSe8TQYu3SWr8IzMVhHYELtVrJVdFlYpVMF2oyTZ2qAxDazWAqmB3SkY2a9ob1l
         b+Pg==
X-Received: by 10.68.75.109 with SMTP id b13mr28588140pbw.25.1363527564729;
        Sun, 17 Mar 2013 06:39:24 -0700 (PDT)
Received: from localhost.localdomain (softbank126010191003.bbtec.net. [126.10.191.3])
        by mx.google.com with ESMTPS id xr3sm16722123pbc.46.2013.03.17.06.39.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 06:39:24 -0700 (PDT)
From:   Alexandre Courbot <gnurou@gmail.com>
To:     Mike Frysinger <vapier@gentoo.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, gnurou@gmail.com,
        Alexandre Courbot <acourbot@nvidia.com>
Subject: [RFC 3/3] blackfin: force use of gpiolib
Date:   Sun, 17 Mar 2013 22:42:03 +0900
Message-Id: <1363527723-32713-4-git-send-email-acourbot@nvidia.com>
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363527723-32713-1-git-send-email-acourbot@nvidia.com>
References: <1363527723-32713-1-git-send-email-acourbot@nvidia.com>
X-archive-position: 35903
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

Set the GENERIC_GPIO option to false by default and force the use of
gpiolib instead of making it optional, to prepare for the removal of
GENERIC_GPIO.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/blackfin/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index c3f2e0b..20e203a 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -31,7 +31,7 @@ config BLACKFIN
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select ARCH_HAVE_CUSTOM_GPIO_H
-	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_UID16
 	select VIRT_TO_BUS
 	select ARCH_WANT_IPC_PARSE_VERSION
@@ -56,7 +56,7 @@ config ZONE_DMA
 	def_bool y
 
 config GENERIC_GPIO
-	def_bool y
+	def_bool n
 
 config FORCE_MAX_ZONEORDER
 	int
-- 
1.8.2
