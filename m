Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 00:20:02 +0100 (CET)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:52936 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012203AbaJ2XUANbT3v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 00:20:00 +0100
Received: by mail-ob0-f202.google.com with SMTP id wm4so613555obc.5
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2014 16:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f4Hm3eUYS9XTBVDID6+syxLL6qAukC9Hx41P8Z/kVaM=;
        b=bnnQV/gJCmCgXCH/Rz4Zl61apb75UY+C2IquFt6WqhhMUI5Uu3cMjIKkRrCE0m98dq
         YGUXGeJw61PDKEFPkxSpMlXsb7IMEV8LwxDhHxMw08ZsPTdqq6izVig5rcVqqKaxu+K+
         bFowXpoRj7J7kDRtO6rEhF5UBzONRmACTgfkVMzYsMYIAkh5pkwfLwTFaVusoDQU2iWB
         FCIjd6HFE7PedtILwbiis0RTc3ZcworUm9Om6qEE6q1MMiAxrlIrGAdHCE7MUePeg5ax
         mDrmCdp9eQUBgraPn1AKviSWLr7lpIIukMLcOrQE9Xp0vRfdIFJuhO+YxBkxYy/y8pBi
         mgkA==
X-Gm-Message-State: ALoCoQnqUOgv9SUt8Ck0CZ3ig9TzSie2hXMFz914Y4oV9vR1eKhBu9XCeg59DE/eBBWchNDL4OKF
X-Received: by 10.42.52.1 with SMTP id h1mr10457224icg.23.1414624793774;
        Wed, 29 Oct 2014 16:19:53 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si347928yho.7.2014.10.29.16.19.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 16:19:53 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 2ESSSMJc.1; Wed, 29 Oct 2014 16:19:53 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 261BD220775; Wed, 29 Oct 2014 16:19:52 -0700 (PDT)
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
Subject: [PATCH V4 1/4] of: Add vendor prefix for MIPS Technologies, Inc.
Date:   Wed, 29 Oct 2014 16:19:47 -0700
Message-Id: <1414624790-15690-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1414624790-15690-1-git-send-email-abrestic@chromium.org>
References: <1414624790-15690-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43731
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

No changes from v2/v3.
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
