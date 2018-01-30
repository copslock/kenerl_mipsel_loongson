Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2018 20:25:10 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:46699
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994747AbeA3TZD3i8W- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2018 20:25:03 +0100
Received: by mail-lf0-x243.google.com with SMTP id q194so17018511lfe.13;
        Tue, 30 Jan 2018 11:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohlAZVaha05HlLEXzfPN/XNqEi9JWpDwTcxRL4PSXVE=;
        b=lvabyb/NZw/mXJGkPJGeVy9Aq9wZwiScvLz5VvszySU9CkOMMA2lg5SCyEapKPResD
         Js+isphvlangdoayhzgxUWXx5NY/2xlPXQFlxiPiSOkh++C/Hz+l/PnwbSm/470lFq1H
         eb3Looc58WK6BoIotP4IRwpzl4AtdzRm4/G6QbIMMK/uGFMR2w2lsfsQ41766r0Kr7Kt
         aJkQcku3eyDQ2FqeX5DukoarfD6PRbbvFL8rl/x6lYAoiU+plAXbgV3bGT8VcE0iMSJw
         ijYmLc8tRqSSSdCniM1FafyEHlnForoayfHKnzYzSt9lb8C9H7wy+h6mdZkfKDzs2uTv
         WEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ohlAZVaha05HlLEXzfPN/XNqEi9JWpDwTcxRL4PSXVE=;
        b=cHM/EleHga60GdCHQYeWSCS2MT7oiuPRVKCYJI6vpUJaGEc2Ym0olNm2JZ5LxvwLYZ
         3BToYZ8k/e4zvElMyhCxTcavpSPJm5n+Y5390mF6UD3THCabCJr/WA/hzRFEhnBUXPT+
         Jr5/aVrIy1SbtFPADob9mD9tCUtCC6/yVmbgeVwJpMUMuNYqzDH0evXaUwXe17mOBamI
         kEdPef21TZNZS9dHZzBmxtt6IFf/oxI4FoUGKe5dY8QmdZfdlA+C7dJKjJDX6NrRS2Vx
         b2A3uERiJfke+gM5MHtMq5hdI0Fr2tqkqMNmABmkhZnadyjPqp3UvNNGrPRY12yTS4OT
         p3pw==
X-Gm-Message-State: AKwxytdRzf/UVTSJ+EGqmUpbG4jMlSPPTQuT2/dmza683BHJumX71PoU
        NmCnpiJmqSEQIkPFL9hq2dY=
X-Google-Smtp-Source: AH8x224YJLgbzygoqZTBZs5TPUrgU03XP/yxvgpLyDSgC7QKx7Mdkzxin4YmHjI6G9+JVCf04V5bhg==
X-Received: by 10.25.209.205 with SMTP id i196mr17288517lfg.43.1517340298002;
        Tue, 30 Jan 2018 11:24:58 -0800 (PST)
Received: from huvuddator.lan (ua-213-113-106-221.cust.bredbandsbolaget.se. [213.113.106.221])
        by smtp.gmail.com with ESMTPSA id l16sm3534818lfk.65.2018.01.30.11.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 11:24:57 -0800 (PST)
From:   Ulf Magnusson <ulfalizer@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/10] MIPS: BCM63XX: kconfig: Remove empty help text
Date:   Tue, 30 Jan 2018 20:23:02 +0100
Message-Id: <20180130192349.8420-8-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130192349.8420-1-ulfalizer@gmail.com>
References: <20180130192349.8420-1-ulfalizer@gmail.com>
Return-Path: <ulfalizer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62367
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
