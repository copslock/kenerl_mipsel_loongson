Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:12:42 +0100 (CET)
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35902 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011937AbcBAAK7uFygA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:10:59 +0100
Received: by mail-lf0-f45.google.com with SMTP id 78so37424445lfy.3
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e8XGm7XJ3zfEgSwI62uVIAQL67Xg6pbSdjta5rDnkYk=;
        b=O7BD5+sXejcWvKex/ChcJQp/hu8Kqmtw0WE/pvrlPRQaW7bWxQn+DLhRM2uHyD9W3x
         ChT5+gUDRGaH9rUubK9l9b2ZikEG6pqsyy82hUJpdFvUHAic7cN4mVb3xTAZqRF6/rWd
         BVIvQmVxrxBO4uii6TLXa+iFQhoS4EiI+WjR9C2pj6YGx+y6fUvUMmp3IXm+I+o5nIVB
         cKnYS+QVhU1jKQFq6eKleKMgzMI5NIBjitLE5J1U8lehc6Rspiw/aJI0HSLLSwzL2ixl
         0oZTkKtQSVWpgaNQMsxKsOwFdNQ76zh+cL8pmcrmNW2wVc4Mg4OLeg2auE/OYrMlEhOC
         LP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e8XGm7XJ3zfEgSwI62uVIAQL67Xg6pbSdjta5rDnkYk=;
        b=i3Ain5Wrloq7f4AlZdeus/xBKBI/QA6OTwY6RR0mmUg2TauT8x6cF/vk76xgEKoXZk
         hvvfsmy4UwEZTwIfnqGCwJnOfcxQ0iIdWZN+kGn8vReqH8RxY0C+KhmyHAmSJ4vjzSzN
         T3r9AEwth2bTb+zCZtamAkE3giDMmvm18Ns44lclNtYFIzH8rIa/k9yQMLfYIjVJa3ot
         1i1ljxoJ4FvPPLbYvfvPbuHHylTqzYLrGvP+AU/qAOepAGy++rP5baC5oqLWAosH7b5a
         ByLutU2GmnJsXsZhHrVLhrEZ1eLd1JO3fd8KFoZ2Rnxy5NTpvBXvpIcaIePvw2wFBhGj
         j9nw==
X-Gm-Message-State: AG10YOQdm6Br/ub4NltZJFu/MnpZJylpjHVGLITS0lHMydrXNM2ADkrOpcGRCL3sqJO1LA==
X-Received: by 10.25.170.129 with SMTP id t123mr7358081lfe.103.1454285454583;
        Sun, 31 Jan 2016 16:10:54 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:53 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org
Subject: [RFC v4 06/15] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
Date:   Mon,  1 Feb 2016 03:10:31 +0300
Message-Id: <1454285440-18916-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51567
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
index 9b4132f..89703cf 100644
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
2.7.0
