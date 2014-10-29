Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 01:13:16 +0100 (CET)
Received: from mail-oi0-f73.google.com ([209.85.218.73]:42651 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011774AbaJ2AMzJpxwo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 01:12:55 +0100
Received: by mail-oi0-f73.google.com with SMTP id e131so296105oig.4
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 17:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ibTkcCvyCBvhEoZ0PmZ8Y16p8Ss4lMjoPiCeGPeY8wI=;
        b=jyDjU7xVWlldRtM+P9VHILhRfJ0G7bvVbD31iLmbYo6VgL4kZcj6aVmR2kSvrLZha0
         gclXAd+z0OhiTQMqC9pnxSjaHO7C+gzbz5yg4QLOiMtXFlOoujQDY2ppY6y5nZ2BTfg2
         n3wtgICNE7d9vA2HGEXCUvkxW8USWpOUujbltTEHt5Zj5dT/jd8uw61LxCGeF6aj037X
         cG4Z5RcAg0XQqdmSBu7wFYqzBb/k9o27CBaQvgAuV9ljVnH3XWQMaHEpYIw4QBVV6UUx
         d0/QDPqgVQx1gv8ep/1vVL/nMlXlQwRVMLpolSEN/c0GzpaLmoDbBzYjbE8ZUFHvQGNK
         O3Wg==
X-Gm-Message-State: ALoCoQnRosUsbTh4DgCG7ehF4c61sVC3R1wS+TqrFQQ/SlLqlm180Nx6JljLJiyirU5oMqC1Gqpx
X-Received: by 10.182.44.135 with SMTP id e7mr4466547obm.21.1414541568119;
        Tue, 28 Oct 2014 17:12:48 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si201247yhe.3.2014.10.28.17.12.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 17:12:48 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id b3ViO5Y4.1; Tue, 28 Oct 2014 17:12:48 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 9C811220EC2; Tue, 28 Oct 2014 17:12:46 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] of: Add vendor prefix for MIPS Technologies, Inc.
Date:   Tue, 28 Oct 2014 17:12:39 -0700
Message-Id: <1414541562-10076-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43666
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

Add the vendor prefix "mti" for MIPS Technologies, Inc.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
I'll update the users of the "mips" prefix to use "mti" instead once
this lands.

No changes from v2.
New for v2.
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0979393..0221b49 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -98,6 +98,7 @@ mitsubishi	Mitsubishi Electric Corporation
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
+mti	MIPS Technologies, Inc.
 mundoreader	Mundo Reader S.L.
 murata	Murata Manufacturing Co., Ltd.
 mxicy	Macronix International Co., Ltd.
-- 
2.1.0.rc2.206.gedb03e5
