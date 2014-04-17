Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 19:43:42 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:55875 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837155AbaDQRnWvTg2T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2014 19:43:22 +0200
Received: by mail-wi0-f181.google.com with SMTP id hm4so1178244wib.2
        for <linux-mips@linux-mips.org>; Thu, 17 Apr 2014 10:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WpEJlc5/k/c+T7PJGBFIAWjSFGT1N3vhiF3DRq36bE8=;
        b=NoCkH05KiPFVY02kIACKjf2EMikRTWj+HvMuBU/h5GV0Mjx6BnCTvEBCCHHY27CvYu
         +ZOc46/MLUpstkKJdgPuDAFKdaNw0iWd06WRbVRfVM1PBk4C440w8bt7A9cOMXpHergK
         cBAYZU2ha2MrrkAIw0kfH8oSIhHn4UOARgiJzWQCOSKG7yCvKWnrOMqq2Nsw241ZDK74
         IfiMUHA17t76SV6B8fMZrMBy3YqCDLUdl5qexuvE1CiFuxetpUqeAVPELwWD8p0cp/hq
         rhkWnP96ov+0fY/ft1GAJ+0auyBaEmpFDKf9HNgh0rnglKDoOs9MsBDu/1GoqZlUPYyu
         7YZw==
X-Gm-Message-State: ALoCoQkRPo/cfFm2Qw0ZmxrTfhjOMKjUJ6a2bM9FbBFTqTHdoUFccRjNcWK7jKuJGlRqWbjq6wzI
X-Received: by 10.180.76.244 with SMTP id n20mr10752769wiw.4.1397756596464;
        Thu, 17 Apr 2014 10:43:16 -0700 (PDT)
Received: from mohikan.mushroom.smurfnet.nu (cpc4-cmbg17-2-0-cust71.5-4.cable.virginm.net. [86.14.224.72])
        by mx.google.com with ESMTPSA id lh6sm39895218wjb.27.2014.04.17.10.43.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Apr 2014 10:43:15 -0700 (PDT)
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@linaro.org, Leif Lindholm <leif.lindholm@linaro.org>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/3] mips: dts: add device_type="memory" where missing
Date:   Thu, 17 Apr 2014 18:42:00 +0100
Message-Id: <1397756521-29387-3-git-send-email-leif.lindholm@linaro.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
Return-Path: <leif.lindholm@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: leif.lindholm@linaro.org
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

A few platforms lack a 'device_type = "memory"' for their memory
nodes, relying on an old ppc quirk in order to discover its memory.
Add this, to permit that quirk to be made ppc only.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: John Crispin <blogic@openwrt.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/mips/lantiq/dts/easy50712.dts    |    1 +
 arch/mips/ralink/dts/mt7620a_eval.dts |    1 +
 arch/mips/ralink/dts/rt2880_eval.dts  |    1 +
 arch/mips/ralink/dts/rt3052_eval.dts  |    1 +
 arch/mips/ralink/dts/rt3883_eval.dts  |    1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
index fac1f5b..143b8a3 100644
--- a/arch/mips/lantiq/dts/easy50712.dts
+++ b/arch/mips/lantiq/dts/easy50712.dts
@@ -8,6 +8,7 @@
 	};
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/ralink/dts/mt7620a_eval.dts
index 35eb874..709f581 100644
--- a/arch/mips/ralink/dts/mt7620a_eval.dts
+++ b/arch/mips/ralink/dts/mt7620a_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink MT7620A evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
index 322d700..0a685db 100644
--- a/arch/mips/ralink/dts/rt2880_eval.dts
+++ b/arch/mips/ralink/dts/rt2880_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT2880 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x8000000 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
index 0ac73ea..ec9e9a0 100644
--- a/arch/mips/ralink/dts/rt3052_eval.dts
+++ b/arch/mips/ralink/dts/rt3052_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT3052 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
index 2fa6b33..e8df21a 100644
--- a/arch/mips/ralink/dts/rt3883_eval.dts
+++ b/arch/mips/ralink/dts/rt3883_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT3883 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
-- 
1.7.10.4
