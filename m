Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:17:38 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32890 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012127AbcBIIOk45hq5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:40 +0100
Received: by mail-lf0-f68.google.com with SMTP id e36so5995456lfi.0
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hA0fZfN5cwiQc9TCOtXencMSl+shHW6KMJaQFWMMSxU=;
        b=QwY1KoRSQfQPZfOr7ObX1lb1KXRS/mvtawvORzOghd+XIF1+UHOl6ViXSpGqHKFo9q
         CG/U8AwXBgmV5C636QPP+Mp9YLflZCjAtfkBUH2p282t5wv5xtvIs4KD+uwp/OcaTOGD
         1BxHaIi/rubu0Rtg0PTcNewYYGhthRyRU15UZy1mj96yw8Fhd6JLa2eTuSKVs7kurYqQ
         WDCkEvVLnjIDitOIAU5YDhA3B+QXelhFPdYwpTqA2nl6r1MpjNThEZcBXtsYo0CAE/Xp
         K6MqE0TMIuBN+YBI+n7NyD96JFAc/yX9HL4QXReJ8aHwegLOD1WmDoD66TpxtfY3pezx
         W1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hA0fZfN5cwiQc9TCOtXencMSl+shHW6KMJaQFWMMSxU=;
        b=ZcIjbPs4ZPaZhfbHcXjNZWHkRCxXEgAZnYPWwBLI7nzVJsInSV2UIXqzAQFimENwnQ
         E5YHAactJvIj6n/MXZO0uxyILq+0+X+lrm7woGlOO3Pa+UFtuEHZOHL0UpTecoggUYhV
         r56xhmFx6bQKTOK6Q0KKEyNmo7m/r2bSsEATCirCIpTsJ4uRFu6U1qYJMUJT2rY5rF8s
         +wyrBKWfT8ESyjdaHjwaBSmMi6hKuDE0I6SB/jKFUYYqIPJbPet3uDRACCx33ytiPedA
         YZi8odV2tRdxiuTjfdI/RAXq3U0WTbmfZXcZfmrEWfQsWQVY8JNAwUC3GZLJxIShxaNr
         Fyeg==
X-Gm-Message-State: AG10YOQyvjsvI97PH15aT8aGzEJL3SQ7/Fl0mla6NgHcpf2UX4wdtcs5wsZtA+ovv0yEyg==
X-Received: by 10.25.159.210 with SMTP id i201mr13743499lfe.106.1455005675700;
        Tue, 09 Feb 2016 00:14:35 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:35 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org
Subject: [RFC v5 11/15] devicetree: add Onion Corporation vendor id
Date:   Tue,  9 Feb 2016 11:13:57 +0300
Message-Id: <1455005641-7079-12-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51887
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

Please see https://onion.io/contact for details.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 49d07bf..afb96f7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -166,6 +166,7 @@ nvidia	NVIDIA
 nxp	NXP Semiconductors
 okaya	Okaya Electric America, Inc.
 olimex	OLIMEX Ltd.
+onion	Onion Corporation
 onnn	ON Semiconductor Corp.
 opencores	OpenCores.org
 option	Option NV
-- 
2.7.0
