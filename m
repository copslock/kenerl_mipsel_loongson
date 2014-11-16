Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:24:49 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33829 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013777AbaKPATzCobt2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:55 +0100
Received: by mail-pd0-f169.google.com with SMTP id fp1so1608236pdb.28
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcOzhnG6/VQECJRP63eKRYuACrluw9J+wLrauiEEN6w=;
        b=JW07UWQc9yL4DYEImGjERgkHWZjf4uSgcVEDrsvBYuspeUo0owxrANAcmwnqSrV8RK
         jL5leLHteXCjxzfYWTCkqkV5r6tFZgzWddZpI7it52KflMuVavCynyHIzflcR4CUbz8f
         yfxQxZ8rjuKeHd5iQmMK/Cv/uk6BJGTFf6s+CXB8CPH+tDszJ+gxxzN6NhiI2yxzuoB5
         Ja8I5lY068KQNkSvKAVfzuYoldUpl7smkwgetNodLORwO8zCR27Zn+UCS8ZjBcX3YaIA
         BzxGLqOqSfw7Iai2XQo0Nn4abI0azOOtkkWMWRAgxHmvFMY5Q3DTYWELr0lsO45dLDtm
         hRKQ==
X-Received: by 10.70.43.176 with SMTP id x16mr19610277pdl.31.1416097189420;
        Sat, 15 Nov 2014 16:19:49 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:48 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 19/22] Documentation: DT: Add "mti" vendor prefix
Date:   Sat, 15 Nov 2014 16:17:43 -0800
Message-Id: <1416097066-20452-20-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

We have a bunch of platforms using "mti,cpu-interrupt-controller" but
the "mti" prefix isn't documented.  Fix this.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 723999d..b2114de 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -96,6 +96,7 @@ mitsubishi	Mitsubishi Electric Corporation
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
+mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
 mundoreader	Mundo Reader S.L.
 murata	Murata Manufacturing Co., Ltd.
 mxicy	Macronix International Co., Ltd.
-- 
2.1.1
