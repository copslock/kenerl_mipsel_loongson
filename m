Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:38:53 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36417 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006865AbcCQDe50Ad0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:57 +0100
Received: by mail-lf0-f66.google.com with SMTP id h198so2226490lfh.3
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WnPE2DaCcol54GrWhzkzmimg4B0ndd2ipK+hafLCyLA=;
        b=gRu0taLuswViGKTtadI4Z6KqBWMwAtozl4mqpXxOX6vl/UWO+VLV9ON3mt5CZ597B7
         CNWb9PzrBmofGLzIEh2jNUIlZHHhApkY6Qr0/G++GayQs5HinNT4j9/t8D6v+5WD5Psg
         ia6VfOomiDrtfKd6eAoJzdaVV/9S4njUGEvx7NA/+nC+RKX5GuylZ79KveGtHK8Xa779
         Y4S2OSJ2tbYGdvtNGMsfoJmewzj/b8/GtoI1cZh5jeiZZpOZTEopQZgGT7N31KoYXvQd
         T5zSgjqmaFODXhLy0YEvI3Ls+uN5NI0b4COGKsm6MnZTONdfo/50G5X2BIsSfVQqZ8ed
         tebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WnPE2DaCcol54GrWhzkzmimg4B0ndd2ipK+hafLCyLA=;
        b=FD0guCe4OfEPegfE0vYq8PUGkDkX3TgVFgjgNkf9m009oqHbejTtv6IhFbWZHL7zoG
         zI7ZL9Y0FeN7N4vGwjvrhypEUK/9h46RVSaQPNxNJw6YvzL3zpg6AW9law+1OIRLlH9t
         GxUyg/ME5wnbsvfktNIi7NIotJQTu3Vu0i1OKJ2+CHt+iFZQbh0o/L3+HzEM9GTQ1Fef
         oFxnFHJT1pYk62lNOZufgLD0LkoDNpEnrrcjpmOILbERRrGkRKvywJHdQxUBxL2yNLXt
         TqRZHqYtqE+TlNRxee4Sf0vApOFKGzTCeNfyysd0h/JtSBiwsY3JkACrSTPlKGGvRxvc
         CcAw==
X-Gm-Message-State: AD7BkJKLeB1aeZAb20p2aUX0aDe9NwgqJM4vg2gEwge8BQ0wjCxTGVcFvNJbES0Lyb2sMA==
X-Received: by 10.25.35.87 with SMTP id j84mr2715712lfj.119.1458185692203;
        Wed, 16 Mar 2016 20:34:52 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:51 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 15/18] devicetree: add Onion Corporation vendor id
Date:   Thu, 17 Mar 2016 06:34:22 +0300
Message-Id: <1458185665-4521-16-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52629
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
index bbce325..f14451b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -167,6 +167,7 @@ nvidia	NVIDIA
 nxp	NXP Semiconductors
 okaya	Okaya Electric America, Inc.
 olimex	OLIMEX Ltd.
+onion	Onion Corporation
 onnn	ON Semiconductor Corp.
 opencores	OpenCores.org
 option	Option NV
-- 
2.7.0
