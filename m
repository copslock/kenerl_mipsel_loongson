Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:07:47 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34935
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992735AbdBGXFCt6GDI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:05:02 +0100
Received: by mail-wm0-x243.google.com with SMTP id u63so30972212wmu.2;
        Tue, 07 Feb 2017 15:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q73CdVLIk6vuhudTICMfnqAMooSDtHB4qcEuVKEhn5A=;
        b=rRBqOEPfYTk1TGq/pZopIJGHmR4y7LPaffZ011ESO0UJF0Xy9A/G1ye2iu5SxcbaDW
         DYo6PemMnrOXPEqllDVICkkN3nC66MmbvJN1VxaSemTl3s8CUv+5ICTxepiDF3dw2U0z
         7MKQ7haKtPE9C/qX5nmiMzYfJlLbuR6QsX6M0rY/1Jyrnwid27xPHo+ecvZIwnVR1dZR
         gzELPIdYAT3U2ecL5jUKHe9gOMSwuqFq//kGCLRUPx08DZfNEKGAGr1RoXLPoUlU55K7
         EOeb9xN1QB74LMIMsV2jjFYURBHjxlguFV7ig80rtF8TEqb0grOmZQ2R8pFnNc9XN8l0
         V5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q73CdVLIk6vuhudTICMfnqAMooSDtHB4qcEuVKEhn5A=;
        b=hrbPilS55l2oA7ZWeDgBYk4VV3vcZ/XymdcsyKafqT6BKtytyA30qfjs7KuOtJOMbz
         OIkPPbFGuB36Uc2py3CmsqMHYT8L17D9nZPgNB5LS/m7tHQnrIMN7YoXZcTtsHG4IIZv
         thwvclM/oh6vqznwNdtZJNG9tXz+h/nebpeoS5g7efvd4Gu0yX9ozUZNKp6aVRz5r78L
         01f2vbLdb7LOQaPkf4TdP6Ra4Gr8DzYhrv1eMzFGGbWdVpDkmszD4fzIZWVbCV8naf/e
         qjfTmfDb4JfKlTrfhzIsJQprYjI1LRlLjCbFihem9egQNY6Qc351FUbMKwfhydF09Pzc
         MKpw==
X-Gm-Message-State: AMke39kJztO+q2sVC5Iz8eM67HYTmqKPSx/Zu7rsBylKtnk/KwoYhXO0Toohpr9dC/fhaQ==
X-Received: by 10.28.143.5 with SMTP id r5mr15445970wmd.141.1486508697466;
        Tue, 07 Feb 2017 15:04:57 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:04:56 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jiri Slaby <jirislaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next v2 09/12] MIPS: Octeon: Remove unnecessary MODULE_*()
Date:   Tue,  7 Feb 2017 15:03:02 -0800
Message-Id: <20170207230305.18222-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Russell King <rmk+kernel@armlinux.org.uk>

octeon-platform.c can not be built as a module for two reasons:

(a) the Makefile doesn't allow it:
    obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o

(b) the multiple *_initcall() statements, each of which are translated
    to a module_init() call when attempting a module build, become
    aliases to init_module().  Having more than one alias will cause a
    build error.

Hence, rather than adding a linux/module.h include, remove the redundant
MODULE_*() from this file.

Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/mips/cavium-octeon/octeon-platform.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 37a932d9148c..8297ce714c5e 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -1060,7 +1060,3 @@ static int __init octeon_publish_devices(void)
 	return of_platform_bus_probe(NULL, octeon_ids, NULL);
 }
 arch_initcall(octeon_publish_devices);
-
-MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Platform driver for Octeon SOC");
-- 
2.9.3
