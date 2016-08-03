Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 11:58:28 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34570 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992183AbcHCJ6WKTCe0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 11:58:22 +0200
Received: by mail-wm0-f67.google.com with SMTP id q128so35470655wma.1;
        Wed, 03 Aug 2016 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6+5w3t/08g+uDnltIjmczK8vC/myz4oWS3TTfjfRG8=;
        b=A8e/DA12aK0ghIYN14FLBy3OShLr5hvP4JUVzW/iF4d8ewmYjKIAjmO4m+GVds82cC
         x8xCE3mrGduS5qA554cwCcKS6NviPK7hjHraK6kQM8E9NWYdLlDgHOu49jG9cMQW1T7M
         LdsISBFvnc4xNq/UL7whaveX2iaoCU0JosxG/tcmryKLlCn2+rJoxHDfRvrLoSjIYc2b
         abq2K/iR83bD08mwjUqRVbN5Zu1FPfueQogzlKy/fKoZh87XvAQ+JvCvOKxSRduSdqW1
         iCdgw+cO5wNanwkp6qLwJmLkwctSVAIczHZKz/fcl3AxftOkGQpXYZ1BIySXWBRDJO8c
         qljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6+5w3t/08g+uDnltIjmczK8vC/myz4oWS3TTfjfRG8=;
        b=QZZeOVPY+ABeHx6u+TIDb9ukiRUtO666SWRtf62Pc9pxMAXzwcP78SYLvC6wz6vWnP
         CFwnO0ya7KWkridZ2gPIZZDbUDSNjiPs/TXcAWmUrnRAcmdBoPHAb7Fp0YYROnGLPSyQ
         dx3cIQIbPkX9gqq0dN4TP/yoQwD+yjcSbW/XKwqZ8ANSJrhWzlTcWpLUG7kjQQz0rkeT
         jYCKye8OMzJgXzCW3wvDJ5Zt1A13sRfZVlAz7qeSLTWa+KzYwU7rs2ZD/a6DSR1Wdn7h
         7AXOALYrhgxEdxzlxv7jEH6pjUe9WNl4AEmC8lGbP2PKPn63InkCQecNKmgamJFrGyje
         /VVw==
X-Gm-Message-State: AEkoouvuN42pRQwBV6ylcmZ6Uawobc/xPxuIJ7QgeiUhEyW3XvUpFDshXDsFfEw41ly+Aw==
X-Received: by 10.194.77.97 with SMTP id r1mr64610371wjw.83.1470218296828;
        Wed, 03 Aug 2016 02:58:16 -0700 (PDT)
Received: from localhost.localdomain (219.red-83-55-40.dynamicip.rima-tde.net. [83.55.40.219])
        by smtp.gmail.com with ESMTPSA id d80sm26368107wmd.14.2016.08.03.02.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 02:58:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 1/7] MIPS: BMIPS: add missing bcm97435svmb to DT_NONE
Date:   Wed,  3 Aug 2016 11:58:24 +0200
Message-Id: <1470218310-2978-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

Commit 380e4270 added support for bcm97435svmb.dtb but missed adding it to
DT_NONE.
Also refactor DT_NONE dtbs in order to add larger names in the future.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/Makefile | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index fda9d38..87e07e2 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -12,19 +12,20 @@ dtb-$(CONFIG_DT_BCM97420C)		+= bcm97420c.dtb
 dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
 dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
 
-dtb-$(CONFIG_DT_NONE)			+= \
-						bcm93384wvg.dtb		\
-						bcm93384wvg_viper.dtb	\
-						bcm96358nb4ser.dtb	\
-						bcm96368mvwg.dtb	\
-						bcm9ejtagprb.dtb	\
-						bcm97125cbmb.dtb	\
-						bcm97346dbsmb.dtb	\
-						bcm97358svmb.dtb	\
-						bcm97360svmb.dtb	\
-						bcm97362svmb.dtb	\
-						bcm97420c.dtb		\
-						bcm97425svmb.dtb
+dtb-$(CONFIG_DT_NONE) += \
+	bcm93384wvg.dtb \
+	bcm93384wvg_viper.dtb \
+	bcm96358nb4ser.dtb \
+	bcm96368mvwg.dtb \
+	bcm9ejtagprb.dtb \
+	bcm97125cbmb.dtb \
+	bcm97346dbsmb.dtb \
+	bcm97358svmb.dtb \
+	bcm97360svmb.dtb \
+	bcm97362svmb.dtb \
+	bcm97420c.dtb \
+	bcm97425svmb.dtb \
+	bcm97435svmb.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
-- 
2.1.4
