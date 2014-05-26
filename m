Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2014 15:43:22 +0200 (CEST)
Received: from mail-we0-f176.google.com ([74.125.82.176]:33120 "EHLO
        mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822096AbaEZNnAXOWxM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 May 2014 15:43:00 +0200
Received: by mail-we0-f176.google.com with SMTP id q59so8155859wes.35
        for <linux-mips@linux-mips.org>; Mon, 26 May 2014 06:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=a3xoEc6wDixhp4O66kN50P3AiaWNB9aDm4q2XsFah3M=;
        b=TOJsudn8wdZsBmmnP3ndrR8mn4aZDaucGEmBKyJbBERz9HdM7q860GqbeaTVgrxD/N
         GbCE6CjMTvVr+aYNwA5Ftnm45arvm9Xm4gANvFswGQhC89xEZVK4KxtLiq1phxZBXG/e
         RJRxzwd+c9+pmV8u9j4+3aiAOtrtDlLnB86EVlXTR1rUaswqfyh+T1P0Z3bo9rWWucFt
         rAMQrjk7IvxUJGUUsKbC3e4hogYOql10aIuxa8vGwCGY2h3TwhkZD8PHAsPyaMsutjai
         0/OX39du4Ao0BnD6R8oMGhQmVUIILWfcz/yFZjdswNwSfQRPhNkPa6rooXEs3C9wztgP
         59Sg==
X-Gm-Message-State: ALoCoQksOYFXoF8KrO6zi7dwa0CDKePem12+zl3L75h2FY38f0uq4IgoNt7WaywBxRa2Ye2O+HYm
X-Received: by 10.180.126.33 with SMTP id mv1mr27920832wib.6.1401111774620;
        Mon, 26 May 2014 06:42:54 -0700 (PDT)
Received: from trevor.secretlab.ca (host109-153-30-27.range109-153.btcentralplus.com. [109.153.30.27])
        by mx.google.com with ESMTPSA id ge6sm246662wic.0.2014.05.26.06.42.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 May 2014 06:42:53 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id D11ADC41455; Mon, 26 May 2014 22:42:49 +0900 (JST)
From:   Grant Likely <grant.likely@linaro.org>
To:     gaurav.minocha@alumni.ubc.ca
Cc:     Leif Lindholm <leif.lindholm@linaro.org>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, <stable@vger.kernel.org>,
        Grant Likely <grant.likely@linaro.org>
Subject: [PATCH 2/2] mips: dts: Fix missing device_type="memory" property in memory nodes
Date:   Mon, 26 May 2014 14:42:49 +0100
Message-Id: <1401111769-5334-2-git-send-email-grant.likely@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1401111769-5334-1-git-send-email-grant.likely@linaro.org>
References: <1401111769-5334-1-git-send-email-grant.likely@linaro.org>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

From: Leif Lindholm <leif.lindholm@linaro.org>

A few platforms lack a 'device_type = "memory"' for their memory
nodes, relying on an old ppc quirk in order to discover its memory.
Add the missing data so that all parsing code can find memory nodes
correctly.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org>
Acked-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Grant Likely <grant.likely@linaro.org>
---
 arch/mips/lantiq/dts/easy50712.dts    | 1 +
 arch/mips/ralink/dts/mt7620a_eval.dts | 1 +
 arch/mips/ralink/dts/rt2880_eval.dts  | 1 +
 arch/mips/ralink/dts/rt3052_eval.dts  | 1 +
 arch/mips/ralink/dts/rt3883_eval.dts  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
index fac1f5b178eb..143b8a37b5e4 100644
--- a/arch/mips/lantiq/dts/easy50712.dts
+++ b/arch/mips/lantiq/dts/easy50712.dts
@@ -8,6 +8,7 @@
 	};
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/ralink/dts/mt7620a_eval.dts
index 35eb874ab7f1..709f58132f5c 100644
--- a/arch/mips/ralink/dts/mt7620a_eval.dts
+++ b/arch/mips/ralink/dts/mt7620a_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink MT7620A evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
index 322d7002595b..0a685db093d4 100644
--- a/arch/mips/ralink/dts/rt2880_eval.dts
+++ b/arch/mips/ralink/dts/rt2880_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT2880 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x8000000 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
index 0ac73ea28198..ec9e9a035541 100644
--- a/arch/mips/ralink/dts/rt3052_eval.dts
+++ b/arch/mips/ralink/dts/rt3052_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT3052 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
index 2fa6b330bf4f..e8df21a5d10d 100644
--- a/arch/mips/ralink/dts/rt3883_eval.dts
+++ b/arch/mips/ralink/dts/rt3883_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT3883 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
-- 
1.9.1
