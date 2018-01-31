Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 10:36:36 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:37347
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994759AbeAaJgIjLKTg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2018 10:36:08 +0100
Received: by mail-lf0-x241.google.com with SMTP id 63so19655926lfv.4;
        Wed, 31 Jan 2018 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6DtyXqRcsqAPE1Ziq2Qkc4bWdK5MAxBqZOcxeFrE7FE=;
        b=D4ZgPCY359IyZXxixJssbd4zOsURZ87tifYMu5TASygo45UeVrnDjxoL1G0mBwdWQ3
         oUmestFkc6zR+EzodjrgxIin4aKgeY/Kf31EMYSuvxXqF1yMNhOyTAxyxjvynNvUWNeI
         W1B+8l4+8tNs/f0kv/Y0HjnAUGqdv2nK+1VQeQ/DIUn7/OapYvXSSHPAWgNdTYgWXyjd
         Nl8edOIZ3NhN4eIgiKh64czIhBOhpF7XVZu4oXIHqSNQ/oh/V+Y1lZF8lutwR8ug7jdm
         13BGmz9TMzaJAIj8mwOzZ6FINQRrmjhhjs/YgdbGe6vjHknSnjiB7aCW6gMEwitXe03x
         YGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6DtyXqRcsqAPE1Ziq2Qkc4bWdK5MAxBqZOcxeFrE7FE=;
        b=uV0zUCdX8+ZkcW0aPLHm0MM3y1GsLvsjsgmMif7WBcdPzx14FYJETHQHagPTcMH203
         ITq6JRjjRnXp8APOnpibzTIrF+1BloHCCMIOjHoJsdxeesBHJyIGzJHHuZSDpskKKF56
         vRB3iHlQ+4E/ibHtVckSRAO1VpPFHQTU8IYj6/BIzJuU4SYjckYZZ7+JbkKmzLna2dFl
         /9Xd/6836Ge3PfeHwmkSDqwRaQege7VPLIYVf7DenvCET9Hho7g3/623lnq49WaRXBOE
         xRJQqqeNPBz+lqvmma5yS612M1DP9R6ui5+zTNoD/xKctE7Kdp/fDKk9NlMrfcYhXyA6
         xiqw==
X-Gm-Message-State: AKwxytdFgSJ8p1Sx5Med+3qWkUZj1IJVYTshIsbH0SjlaW8q2nNJhus2
        EtmEIQ4RQpM7vxw4k2Ulu7E=
X-Google-Smtp-Source: AH8x225F31MyOEDJfce9HyqYuyRU/S/w+O6+oqEUAMmAegsWlj81j7N+3ntD9I7UuCs/WbLCbBd9HA==
X-Received: by 10.46.66.197 with SMTP id h66mr17951235ljf.42.1517391363232;
        Wed, 31 Jan 2018 01:36:03 -0800 (PST)
Received: from huvuddator.lan (ua-213-113-106-221.cust.bredbandsbolaget.se. [213.113.106.221])
        by smtp.gmail.com with ESMTPSA id i18sm3155604ljd.27.2018.01.31.01.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 01:36:02 -0800 (PST)
From:   Ulf Magnusson <ulfalizer@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 08/11] MIPS: kconfig: Remove blank help text
Date:   Wed, 31 Jan 2018 10:34:27 +0100
Message-Id: <20180131093434.20050-9-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180131093434.20050-1-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
Return-Path: <ulfalizer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62375
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

Blank help texts are probably either a typo, a Kconfig misunderstanding,
or some kind of half-committing to adding a help text (in which case a
TODO comment would be clearer, if the help text really can't be added
right away).

Best to remove them, IMO.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ab98569994f0..57cd591e7b28 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2326,7 +2326,6 @@ config MIPS_VPE_LOADER_TOM
 config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
 	depends on MIPS_VPE_LOADER
-	help
 
 config MIPS_VPE_APSP_API_CMP
 	bool
-- 
2.14.1
