Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:19:19 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35745 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014577AbcAWURxEmXmd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:53 +0100
Received: by mail-lb0-f181.google.com with SMTP id bc4so56846661lbc.2
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=950k85P6XQTWzF/KoWC3Yt02C/y/0adYTsTadeP/bh8=;
        b=lT6VQyA1pFr9QHmAgic0F9C7YRjrVhufMt35PcOtYjr83KE0BvKRJmr8Qtw3tzMlwv
         k1P39ozxrVEo90aSflBAZOXiG+iRKFc+KGGf2zOtTp6HZB9NSnQpOGQyJ5CeX52MttMJ
         TCA3qJ3zzrSq8KD8TZVvumeBKN6rQThnoWmeg31lbgR907SFjWBPgB/gynsa0laBxCZP
         72zI3cofmbOhD6v2vpEVUW8ZdrlD1IqLrjIvAeEFvIGTa7DLpNiQwC93GO+kAteCb9cB
         sYW6dpapgho0zsWolA9/+RHyguhgvRYKwkd38ljPTUvBHiniOGBjpYeiXSLkVm8lcC+Y
         8LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=950k85P6XQTWzF/KoWC3Yt02C/y/0adYTsTadeP/bh8=;
        b=brIjke7I3rfEFenSZLhVZLvjtxP4SaWxW28Lg0qhGi3X7iPoMfTPLbz/YllK3cxGeK
         W3uK5+rtmE+9bhoYUy1+zDDuoxznmqr+vXeiSCTOGVgVrC5qNccwPgBzt8VelYdlMw4R
         r2RXrmxLUwyrUuig228suhSvvn6e7y01gUherCdVQYiJZfZlqbd8XxUeSaQz6IkcY6mP
         Omry9a8jQGUUviSESez3cNREnjxTgpzEZRRTXXF5nVMKtto3tvJ0c53SiudQncRh6YKB
         QeKP/XvVaDkVqk2xmnCq6ywaopStKCaT2fSUaJwFfXuh8MhAfCMd6BFhGPiUG3/7VzP6
         mq1g==
X-Gm-Message-State: AG10YOS1+tCVJQrf24spDwHQeEYpoXkxLJgf908GuZAFLJK7S+In9ixM7E+SLFfhyR7dmA==
X-Received: by 10.112.160.104 with SMTP id xj8mr3565265lbb.77.1453580267737;
        Sat, 23 Jan 2016 12:17:47 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:47 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org
Subject: [RFC v3 05/14] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
Date:   Sat, 23 Jan 2016 23:17:22 +0300
Message-Id: <1453580251-2341-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

The TP-LINK TL-WR1043ND board has only one serial port,
so replacing the default of 0 with 0 does nothing useful.

Moreover, the correct name for aliases node is "aliases" not "alias".

An overview of the "aliases" node usage can be found
on the device tree usage page at devicetree.org [1].

Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].

[1] http://devicetree.org/Device_Tree_Usage#aliases_Node
[2] https://www.power.org/documentation/epapr-version-1-1/

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 53057ca..9618105 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -9,10 +9,6 @@
 	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
 	model = "TP-Link TL-WR1043ND Version 1";
 
-	alias {
-		serial0 = "/ahb/apb/uart@18020000";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x2000000>;
-- 
2.6.2
