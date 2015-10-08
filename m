Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2015 19:54:25 +0200 (CEST)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36802 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010204AbbJHRyL6Gf6r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2015 19:54:11 +0200
Received: by obcgx8 with SMTP id gx8so44417101obc.3;
        Thu, 08 Oct 2015 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/bXr62oYyILnRNZNC4eKteIS/oPdzD4KzrkW1HrFjUI=;
        b=Cze5AY4MXwk6O9r/apGb/5Q86ZiIE7STjkXOumLxWD+gr12b84GbAZoD9DndSNq1La
         2+wYL53LzpDo1J6IiGR5CGkDTlIuTGfjGGoc+YpnpAsmZiD5KbbyJ1EBbnUshJU/c2bv
         UqNOCqlzJ2HWHUZQvOfay+k6uYD5Y6kFgHAF9oojZlmaS67P+RBOIwJj1rDY+AQ8i1m0
         fErm1lMfGljSPJeKT+3rgtpKOP5XN8e0UYYcqtMgZsovskuln5etqRQY8kMaaWQXUlgv
         h9iGORyKtq/R3BOdFHNT5YryLTtXyJh22v7Lh4vaIluPe3zXyWUQtgjWH38w9nYbGALT
         y4tQ==
X-Received: by 10.60.125.8 with SMTP id mm8mr5689421oeb.73.1444326844738;
        Thu, 08 Oct 2015 10:54:04 -0700 (PDT)
Received: from rob-hp-laptop.herring.priv (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.googlemail.com with ESMTPSA id f81sm994967oia.11.2015.10.08.10.54.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Oct 2015 10:54:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 09/13] mips: enable building of all dtbs
Date:   Thu,  8 Oct 2015 12:53:43 -0500
Message-Id: <1444326827-3565-10-git-send-email-robh@kernel.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1444326827-3565-1-git-send-email-robh@kernel.org>
References: <1444326827-3565-1-git-send-email-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

Enable building all dtb files when CONFIG_OF_ALL_DTBS is enabled. The dtbs
are not really dependent on a platform being enabled or any other kernel
config, so for testing coverage it is convenient to build all of the dtbs.
This builds all dts files in the tree, not just targets listed.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/boot/dts/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 778a340..bac7b8d 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -9,6 +9,9 @@ dts-dirs	+= ralink
 
 obj-y		:= $(addsuffix /, $(dts-dirs))
 
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
+
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
 clean-files	:= *.dtb *.dtb.S
-- 
2.1.4
