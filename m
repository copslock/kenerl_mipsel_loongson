Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:36:34 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36206 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011197AbcAUWepj-CBN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:45 +0100
Received: by mail-lf0-f52.google.com with SMTP id h129so36491149lfh.3
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGr5dtaqkhhYfCMBiBHWvWrd2CCn6reMCzvrHxLLgxw=;
        b=xqfmCcLFHHsWtmIOTqri5ffFVoXq2dgl88nDq7lgtf7W4+Bo3UkhSpiHCb09XgZCj2
         krWJSgstfpIV/BHYiLw73Ab+WqIQQq6anJ4EA7rMmdUwWWVqY5b8X48HLj8ZZ3OPAtRf
         OotRju/urMd4b2iA5pKwzI0hzfVGXs6dDIPIK9LVIBMOxTEpNoun5XV/9Vh+8uN2k2Ml
         Osfxk/LenHX8Y3qM6yLd+r2x1UAzWBo/iLKkfLhVMwglGRmbIPRpXx+fvZrangmKhUOD
         gJ2F+6E98pYzkDNd1pj8eiPhoYig3vDvTdRZrCwHluQJBMWQAtBeHC0Ll1ygy6kKHCDy
         vVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGr5dtaqkhhYfCMBiBHWvWrd2CCn6reMCzvrHxLLgxw=;
        b=jD2sHjhNEOrhMBINeN7udGn0zjTJlYoOmKAG1V/L8iRUrHW9uYtpzqfAwTmdtVv9NJ
         RWkSyfDtfwkD6rI0M3KOzboc5BZdXIqiSqJxPlg+8XlpmLOrvs1T2r21QK8jfUNxG8H8
         Apr9gthuHeBOeSDGH0vZ82wmIExZpOC1EYo2LtTOUeWhQIOT1gkvfkET6brs4iKaz7rv
         yHaga7iPy42eyltsmhRPWKefaEhixB29v/cj6HuHENb9+v3H0kYQ9g59KM+W/kIh0xuV
         LmYL/yg5HQpMxRNzt2AkomNXYU2Vk57NlpBQ/50/PphKkDYGI1FA27kQ0YFXEEmZeG18
         50HA==
X-Gm-Message-State: ALoCoQmJUkB5KrGMCtW97jVLUS33echRbI8i5VALksvth0WTX9CtIFV4Zsmq7yKk+7g/jRDeLTVLwYGQVvTFkIaUMcxVk85ZDQ==
X-Received: by 10.25.39.8 with SMTP id n8mr16744167lfn.117.1453415680373;
        Thu, 21 Jan 2016 14:34:40 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:39 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, devicetree@vger.kernel.org
Subject: [RFC v2 5/7] devicetree: add Dragino vendor id
Date:   Fri, 22 Jan 2016 01:34:22 +0300
Message-Id: <1453415664-20307-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Please see http://www.dragino.com/about/about.html for details.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..64f35c9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -67,6 +67,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
 ebv	EBV Elektronik
 edt	Emerging Display Technologies
-- 
2.6.2
