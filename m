Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 01:17:22 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:32843 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014814AbbC3XRE7TB4s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 01:17:04 +0200
Received: by igdh15 with SMTP id h15so1009781igd.0
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 16:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eC03FVSnEzneigl+N3r8MpO9kORFVilYcNfxnsJXRtE=;
        b=KNbaqtseURAvPVPRf9+X7SU0FbIPNVIZYolMVPNpZFzf1Q7r8AY68Tx2/LZDpCpbgP
         CSjB2XjntejaHB46s0QSa2PqsmXQSqrKqY1KYxWltX2N/Poe2JjwdkaTvufPPVXwSGGS
         Z2Z3X484B8TCVUmApT9WJYX0WrqxsLHkc/pr/bI93JpGrc1wUS48fULZdZNbkiqTumae
         GsgsL2DnFgOdNrpSjAtY1e+IvaT9Yc+DdLy+L8ezfMMLkhWDMEhfU/yB+EXc+EQvEhTZ
         bcZzpCLMeKPnLVijcMaUyV7n5++XkFItRwPQLhfe0e27mgUa0Wvkq0lwP5FJo28aSe9h
         uBxw==
X-Gm-Message-State: ALoCoQn4bbgzSQFMtE2utqo4bBXdWiW1wyT/vnUviD8yymeQcaFWV19OnIYp4EahZJj+UHuCSp9S
X-Received: by 10.182.237.18 with SMTP id uy18mr43347554obc.36.1427757420114;
        Mon, 30 Mar 2015 16:17:00 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id c38si497383yho.5.2015.03.30.16.16.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 16:17:00 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id zioW0Ux8.1; Mon, 30 Mar 2015 16:17:00 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 98B91220A56; Mon, 30 Mar 2015 16:16:58 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH V2 1/3] pinctrl: Document "function" + "pins" pinmux binding
Date:   Mon, 30 Mar 2015 16:16:54 -0700
Message-Id: <1427757416-14491-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Currently the "function" + "groups" combination is the only documented
format for pinmux nodes, although many drivers use "function" + "pins".
Update the generic pinctrl binding to include the "function" + "pins"
combination as well.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
New for v2.
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index 47d84b6..f7688e2 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -133,6 +133,9 @@ pin multiplexing nodes:
 
 function		- the mux function to select
 groups			- the list of groups to select with this function
+			  (either this or "pins" must be specified)
+pins			- the list of pins to select with this function (either
+			  this or "groups" must be specified)
 
 Example:
 
@@ -144,6 +147,10 @@ state_1_node_a {
 	function = "spi0";
 	groups = "spi0pins";
 };
+state_2_node_a {
+	function = "i2c0";
+	pins = "mfio29", "mfio30";
+};
 
 == Generic pin configuration node content ==
 
-- 
2.2.0.rc0.207.ga3a616c
