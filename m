Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:14:07 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34362 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011945AbcBAALEPCv4A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:04 +0100
Received: by mail-lf0-f44.google.com with SMTP id j78so16236292lfb.1
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SgIoPuIaXvucGoqGWa5u/RxM6Eu/H6ZD8OMTYXnWzi4=;
        b=AHFykjZpXKy6ZXe/4peybPYVcMO01uyUPuKY8eznTLm48NOlX43U4qh0qrQq6mqbjI
         Da0YZH2pTjsY705VFZ6UUXnDkQmK3MJqGYPACsmEEmqoEZLNdxhuJwm5HeP7aMFNqOfY
         v6YqGmKsnVmqd2wZZ2FIZHlLvyo2pouv+Da+LkcqOL4rxgeA/CqjigEXgAiLR5XKLZra
         iN+F1fngmnYJkrXXZqg/603oYL8qUVhk0Uvf1++VxlUg54o6dcCQHUnAfaQp51joWM3t
         C9fZOK25NYSUJJwwCqy45mFDSsMoQ+JnWHyz79Pa/FIng2UjKODON0G6x6AFa3kYwW9l
         OFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SgIoPuIaXvucGoqGWa5u/RxM6Eu/H6ZD8OMTYXnWzi4=;
        b=G5KHjwQAmX8+C/f9zlo8uJq+hWRB2uxl6WkFlt3ArdL36vMebH8REhZnLVmyxdip2j
         p+xCJIQIPdXbf+nP5HfMsK0PPD9wZyA4MaplloNlCKNHNyRxk+GMAzfymzRLUn0ZPmmt
         eY5h0S6dmB2+6d7w+kG1Ex0jYc1WZZS5kOFsMbKL6Wgg6rxtOIxLvkID07x5/5r4XJKe
         8UJEvmQK42aDseeDxgABZd8VN/JhwiPS5suqik1TSpRcQE1Rl6CE/34diBOgMXpsYrpK
         HVn7iTQSLoHIpGCXtnO7yu494NDcjipLQ8yTduc9VcP8vogqOdTGdglVX8k3ibFZN/Fi
         8pcg==
X-Gm-Message-State: AG10YOSA2uKhfKZN93Ck6gqmpSSTOHquPXJmeAG1aTEoVSRSvSQm4dTVmxGwZUPEUJmt0g==
X-Received: by 10.25.209.80 with SMTP id i77mr7331917lfg.33.1454285458989;
        Sun, 31 Jan 2016 16:10:58 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:58 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, devicetree@vger.kernel.org
Subject: [RFC v4 11/15] devicetree: add Dragino vendor id
Date:   Mon,  1 Feb 2016 03:10:36 +0300
Message-Id: <1454285440-18916-12-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51572
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
index 72e2c5a..49d07bf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -68,6 +68,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
 ebv	EBV Elektronik
 edt	Emerging Display Technologies
-- 
2.7.0
