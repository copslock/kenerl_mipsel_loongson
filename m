Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:28:00 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54586 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903638Ab2FLIYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:41 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so5334449bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cDCzWD+xfJ4McDl9ZeUAVe4QUVnrAVz1eXUGFo+ZI+s=;
        b=ZEDzABfRx6mkfKkH4vIRL2fk1SC6tI222eVwmVV/iys07p4qli65K3qnUXheqvTggL
         vJTubZiY9t8KKK+bKgqtmwMeuLbD5wWaZ5c6boG8qhOaX6s7azrSYjjA6eBaL9SHpdLg
         dyiI0bELYE/05yiTp+px8MaMG/iAsOWQAHdssw4dnw2bT7C5ds5Ywy7rWq6vegpvyt2q
         3OyTRQhvITealJWPp+aIvOm5OFcph8qQo/qWz0Gb1pzuv265guC6EAZwFoEIaxYBlqZ+
         kmB3XTxGqBNITAvkbwMKPFYqcXk1xKdLNWwKreWVSSv4LRo0SjXttvaS/5KUvY24KRFc
         zJiw==
Received: by 10.204.136.214 with SMTP id s22mr11464450bkt.92.1339489481216;
        Tue, 12 Jun 2012 01:24:41 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.39
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:40 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 7/8] MIPS: expose PCIe drivers for MIPS
Date:   Tue, 12 Jun 2012 10:23:44 +0200
Message-Id: <1339489425-19037-8-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f39850c..08dfc79 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2370,6 +2370,8 @@ config PCI_DOMAINS
 
 source "drivers/pci/Kconfig"
 
+source "drivers/pci/pcie/Kconfig"
+
 #
 # ISA support is now enabled via select.  Too many systems still have the one
 # or other ISA chip on the board that users don't know about so don't expect
-- 
1.7.2.5
