Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:30:46 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46434 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011990AbaJUE2urFHP- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:50 +0200
Received: by mail-pa0-f42.google.com with SMTP id bj1so520557pad.29
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6KLX85tO4eKTW1Cc4NquTP5WlkoP/jDSjWAe8DXxWKI=;
        b=0DyDtVGttxEmy5vDzIyKDKinDIL7KGtBQCEG5s6nUPRtzykK37Ky5cYttiBD6FYjYR
         TsW1rUfPuntGLeW9gXg2qkk4i19C9hetadioa3Nk/EUKde5A9OoiVTMBzM/Y9vMhdU/S
         SFBG2ucuZDb+u5dcaetB9MsnmkCGQT863weRFTYta1H9O9yByfPpb8F9nNQWPs/Pt3Gw
         UydD5Sw/l2MZDQI0fH4MBJTM4xgiCgrOBh3VYwcTsWK55Fu5scxpRizb4hYsLyPvbkRV
         rpLgkWWJzo5gsjoLqT5tquDvJozqwz9RGjSFiKd2XVRJG6srw4UffZVBdaC7FFkWpIT0
         SFvw==
X-Received: by 10.68.220.133 with SMTP id pw5mr8029532pbc.129.1413865724510;
        Mon, 20 Oct 2014 21:28:44 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:44 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 07/17] MIPS: Allow MIPS_CPU_SCACHE to be used with different line sizes
Date:   Mon, 20 Oct 2014 21:27:57 -0700
Message-Id: <1413865687-15255-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

CONFIG_MIPS_CPU_SCACHE determines whether to build sc-mips.c.  However,
it is currently hardwired to use an L1_SHIFT of 6 (64 bytes).  Move the
L1_SHIFT selection into the CPU or SoC section so that other SoCs can
select different values.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ad6badb..37b085c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -326,6 +326,7 @@ config MIPS_MALTA
 	select I8259
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
+	select MIPS_L1_CACHE_SHIFT_6
 	select PCI_GT64XXX_PCI0
 	select MIPS_MSC
 	select SWAP_IO_SPACE
@@ -1908,7 +1909,6 @@ config IP22_CPU_SCACHE
 config MIPS_CPU_SCACHE
 	bool
 	select BOARD_SCACHE
-	select MIPS_L1_CACHE_SHIFT_6
 
 config R5000_CPU_SCACHE
 	bool
-- 
2.1.1
