Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:32:47 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61325 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011198AbaJUE3ABO7Hi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:29:00 +0200
Received: by mail-pa0-f41.google.com with SMTP id eu11so540470pac.0
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcOzhnG6/VQECJRP63eKRYuACrluw9J+wLrauiEEN6w=;
        b=gS0WZz4ACxPADVoUGn2yvv1ux7JZRNgfZLI11Kk6bt8Xu8k46xM/RUOb/E8LU17pVK
         +fXOlm0m1Fw3j6G4YC0yQ5ooOy81VOmF2+8g9dCyDKj1Kh1SsEHO1WNF7uk7YnalQvEQ
         5OW0MUy01A/ulGKxPyOEBBzSQ2KuQD8Z9ujgW//oJC/79BRKUvKut29f9+GYRF/MBylF
         ubeQvpaGrt3MMPXc7UmSjOM0FhN37oSnTVRsEhthdTQ6ra61c2ZL7ij//EJVuu7n+NQ/
         ePcpvMD540PHVEH1wcmfSOVM0cbEYFln4DuPzwzonwkkO/HMBkWygx7z4kuwvFYsmkTz
         Oaaw==
X-Received: by 10.68.134.230 with SMTP id pn6mr32271469pbb.88.1413865733726;
        Mon, 20 Oct 2014 21:28:53 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:53 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 14/17] Documentation: DT: Add "mti" vendor prefix
Date:   Mon, 20 Oct 2014 21:28:04 -0700
Message-Id: <1413865687-15255-15-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43412
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
