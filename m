Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:34:00 +0200 (CEST)
Received: from mail-oi0-f73.google.com ([209.85.218.73]:49469 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025902AbaIERanRR0uO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:43 +0200
Received: by mail-oi0-f73.google.com with SMTP id u20so2080229oif.2
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sOfOmfW29+DOv2qjErkSdKj9soZAyu0I7nIL127udA4=;
        b=dOJ1kcBAATcTD7P0szjG0NUUJE8yLRsR0Db/CUhJ0GpN9BUMM1FD8WBKtUjjmVFkkE
         voXGEo+Adp1g5YHERL2jZSzR74dMbHCiP6pVi1fFpXxUFfAKpkELWmpwi6M1PP+dkKsH
         TM0/8EdNFLPXtytU40fLlgtW4+wpdMzE8nQx0RxzZ6dq4vXLXdRIk3MTCWrb479MhX5X
         Jdy60OxeVvNE4zTmRq5Oz2mzfXlNQUB/f45ueWflE45bgTbQNMZurtYZxeQvmXIBYfR7
         VYnQ7oxIeaxYUApr6UCcR+309wtYX4/UnCXcW2iM2at9hcldXC8wlEq/pKkAAWNwMOH7
         ukKw==
X-Gm-Message-State: ALoCoQloGZHt1vBsVQelcEvJaR9rTwg8uZJBR4dNg6quyNu8QsaMow7BFb72VzBKty/cfwZ0uHkN
X-Received: by 10.182.60.36 with SMTP id e4mr8047743obr.3.1409938235851;
        Fri, 05 Sep 2014 10:30:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n22si508811yhd.1.2014.09.05.10.30.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:35 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ABF4E5A427D;
        Fri,  5 Sep 2014 10:30:35 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 702FF2209EA; Fri,  5 Sep 2014 10:30:35 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/16] of: Add vendor prefix for MIPS Technologies, Inc.
Date:   Fri,  5 Sep 2014 10:30:12 -0700
Message-Id: <1409938218-9026-11-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42441
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
New for v2.
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..efa5a5b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -86,6 +86,7 @@ microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
+mti	MIPS Technologies, Inc.
 mundoreader	Mundo Reader S.L.
 murata	Murata Manufacturing Co., Ltd.
 mxicy	Macronix International Co., Ltd.
-- 
2.1.0.rc2.206.gedb03e5
