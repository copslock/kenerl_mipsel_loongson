Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 20:44:12 +0100 (CET)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:39531 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013557AbaKLTnwucWiP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 20:43:52 +0100
Received: by mail-ie0-f202.google.com with SMTP id tr6so2098879ieb.5
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 11:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cd1MpAfh2htv9h3tfuWKuNCraOUyG4eDsgicJLIonqk=;
        b=APlHwZ1MnhYwFqVd9++sSAk63Snsy8O8OWkuYVl0wnw0L1NRFiRL32tfpITsY/yIw7
         LrUgz8lK6hem+gmv17D03AFmKbiZ+StfRqn4f6XAwxILpJYH111UdGWzWQ9AKNuO4k8t
         feG3KsFEXqvdUTONtZ9gZgjrOg06cQcTVizwoyhUAtvcTqIwJKIonUwe/9uN9psNSePG
         97RTupfIE0EcN0synrWab6xxAPbVo6gXgNr7KI0LMSbG/2FQRbn3snr5lQVNId+IjWmy
         aCr4cwg0GhmflFoLrBi8d8TXCDkVJgLGqmdWF+8U45Q4j8+nPPk5Cqa+InjjO+rkXL5c
         B5ow==
X-Gm-Message-State: ALoCoQmhj40da1SbHWLcoRyN7q3oZBfhrb+JQXKMZrpR+qAQLUuboGRVmcZA1SV1SOnMAXLGVJVq
X-Received: by 10.50.3.97 with SMTP id b1mr27136299igb.4.1415821426765;
        Wed, 12 Nov 2014 11:43:46 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id r6si931599yhg.1.2014.11.12.11.43.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 11:43:46 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id mx0hRWrO.1; Wed, 12 Nov 2014 11:43:46 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 0C0E4220BC1; Wed, 12 Nov 2014 11:43:45 -0800 (PST)
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
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/4] of: Add vendor prefix for MIPS Technologies, Inc.
Date:   Wed, 12 Nov 2014 11:43:36 -0800
Message-Id: <1415821419-26974-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
References: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44071
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
I'll update the users of the "mips" prefix to use "mti" instead once
this lands.

No changes from v2/v3/v4.
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
