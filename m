Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2018 20:07:52 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:44936
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994744AbeA3THp51eq8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2018 20:07:45 +0100
Received: by mail-lf0-x244.google.com with SMTP id v188so16961010lfa.11;
        Tue, 30 Jan 2018 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohlAZVaha05HlLEXzfPN/XNqEi9JWpDwTcxRL4PSXVE=;
        b=KfKbyfBzsXrxydoZfWL+p1OlB2gokb2QQ61GSUPuWGuNlRBGefgSc8/7AjuYlF/EQS
         g7dBm1JMW03TV7dUaNapEfNzHWpUEkyZgdEtwYTcneHdsthcH3fiuZwtI3snZT43LkEh
         sZUPYjBuxV5EnzuqKXZ0RzY6qnmVbYly2zUYb/9/HeuJKCP8ry5DpAEt5oMmQm27NqlB
         yWXptOuvyaOaqY0iUi/ZaX9Nhhqd6Rdcj0Eekecsl/KZAniXTEUk/RI0jGqkx4zccPFG
         0gBWGRV5TdsRHNDXprP+BL7oU1R12z1Hi+nNMVdC3kl3wJJLJ86dhXNaAXQjy8QsTsDc
         ovTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ohlAZVaha05HlLEXzfPN/XNqEi9JWpDwTcxRL4PSXVE=;
        b=CYGcEA3oy6Rv/QgI2y/JPvgMawMsLzUvUblpkMdvMMv8xmLEAqWnYKEfIkUncNzyk0
         E6Zg2lPBgGcp4jHRSie/fVyhZiMlEcVty6jbpXOIfRXVCgi5lLKR5O5MtvPLMy01uc8P
         Lg0dzZLHAAsW5FhXee7eVyYFaD3RmajxC+82b/tnddh4YMlT2lgKDKHGyAIV39QzPh0F
         Nkm+U/kHNE+4HjAXKMG3Zit+bbtyfIrcfxELPTUfUXNHlKEDmRHBkoDOq8ajdRzN3Fsy
         dH9ExCe8ueG0o02O11gp6cb840eFI7/THpT0RSYsWPQYBrq7OJ0ZT8AbeVXa1vtZ6+On
         slsg==
X-Gm-Message-State: AKwxytdHEpaZXx6HgFYuW8sjl5Hzl4Uz/u/s9hLGtusJGupzwrSsSjXV
        Nbyad+vky0aLSfV4Hi1Qhog=
X-Google-Smtp-Source: AH8x224O5y9xf/w9C8kU0LJZXdYI7RPT9jSqB3uzBB6ZvdRG5lEEFfD6CfR99CUc7OSLXzeGqdV6kA==
X-Received: by 10.25.113.2 with SMTP id m2mr15994861lfc.71.1517339260288;
        Tue, 30 Jan 2018 11:07:40 -0800 (PST)
Received: from huvuddator.lan (ua-213-113-106-221.cust.bredbandsbolaget.se. [213.113.106.221])
        by smtp.gmail.com with ESMTPSA id s65sm3547115lfi.93.2018.01.30.11.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 11:07:39 -0800 (PST)
From:   Ulf Magnusson <ulfalizer@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, mcgrof@kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] MIPS: BCM63XX: kconfig: Remove empty help text
Date:   Tue, 30 Jan 2018 20:05:29 +0100
Message-Id: <20180130190555.6577-8-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130190555.6577-1-ulfalizer@gmail.com>
References: <20180130190555.6577-1-ulfalizer@gmail.com>
Return-Path: <ulfalizer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62365
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
 arch/mips/bcm63xx/boards/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/bcm63xx/boards/Kconfig b/arch/mips/bcm63xx/boards/Kconfig
index 6ff0a7481081..f60d96610ace 100644
--- a/arch/mips/bcm63xx/boards/Kconfig
+++ b/arch/mips/bcm63xx/boards/Kconfig
@@ -7,6 +7,5 @@ choice
 config BOARD_BCM963XX
        bool "Generic Broadcom 963xx boards"
 	select SSB
-       help
 
 endchoice
-- 
2.14.1
