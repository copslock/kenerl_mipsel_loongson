Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Sep 2017 09:09:25 +0200 (CEST)
Received: from cpanel2.indieserve.net ([199.212.143.6]:53535 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdIBHJPfLBSU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Sep 2017 09:09:15 +0200
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:47406 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1do2YG-00035k-C4
        for linux-mips@linux-mips.org; Sat, 02 Sep 2017 03:09:08 -0400
Date:   Sat, 2 Sep 2017 03:09:06 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Standardize DTS files, status "ok" -> "okay"
Message-ID: <alpine.LFD.2.21.1709020307150.11468@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
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


While the current kernel code in drivers/of/ allows developers to be
sloppy and use the status value "ok", the current DTSpec 0.1 makes it
clear that the only officially proper spelling is "okay", so adjust
the very small number of DTS files under arch/mips/.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts b/arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts
index 430d35c..18397f4 100644
--- a/arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts
+++ b/arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts
@@ -18,7 +18,7 @@
 };

 &leds0 {
-	status = "ok";
+	status = "okay";
 	brcm,serial-leds;
 	brcm,serial-dat-low;
 	brcm,serial-shift-inv;
diff --git a/arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts b/arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts
index 702eae2..cfffbba 100644
--- a/arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts
+++ b/arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts
@@ -18,7 +18,7 @@
 };

 &leds0 {
-	status = "ok";
+	status = "okay";

 	led@0 {
 		reg = <0>;
diff --git a/arch/mips/boot/dts/ralink/rt3052_eval.dts b/arch/mips/boot/dts/ralink/rt3052_eval.dts
index ec9e9a0..564870f 100644
--- a/arch/mips/boot/dts/ralink/rt3052_eval.dts
+++ b/arch/mips/boot/dts/ralink/rt3052_eval.dts
@@ -46,6 +46,6 @@
 	};

 	usb@101c0000 {
-		status = "ok";
+		status = "okay";
 	};
 };

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
