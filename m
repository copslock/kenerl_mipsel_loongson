Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:39:27 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32991 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007933AbcCQDe73pCop (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:59 +0100
Received: by mail-lf0-f65.google.com with SMTP id l83so2209237lfd.0
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yMXtEMjJ2ONvw7l8dZqFR6aUsYfA4Om+XoQS8pavJpk=;
        b=CK/Y4Q7YAp7EoNzw5Mz+P/4B+ZI/yCDhhNK22YmPK1M3tV9WkhEN1F7S06b/HXq9Pc
         UDjo8nosMc2ZOzU/cg9QoB2H0BeXuHI3qJqhuTqPkDTgimhxH1k9sCV8h1gjYig3uvJu
         cU2ykJJMQGnQGn+MBaDXcnxWY/Hgu/8ON6fh1+vEqgnVyBN/FyBkNbAB0UvWu3q/u/L3
         WckvrtQLl/aKjYwAFjR9FIMdh4U8dgby84MF3epcbG6CapH95CEv1nsATM7tIKR+TW8M
         50CRx6tUF8ZrWxkxYt8X+SKfrajF3Eh5sK8v9Hi5ZoICIVhRtbIkKAR1RpKlCfFHFoiK
         INeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yMXtEMjJ2ONvw7l8dZqFR6aUsYfA4Om+XoQS8pavJpk=;
        b=dwcmd1lB4D0NTKMoYntYTlqYbZufxVWYkIZOJ8521g8mjNgQ6NAqfDmU40Dw4yrm06
         DcyAx2h6wJTcdnzCrPDI2uPBmhg4GjapA+ru/C5t5/8fMdaf8F2QZfFcBq4qsDyeTsP4
         0N4LCZAapeV4jlMsqQo0nHXxfXi8/Ubh4bNRQvaYYrIJ9NzehEoZGs2n7ZvjampriCkt
         eEsrX95dQG2Dsrmb943vmGdH3UvR3GdP9jYij2GYiG+cKeYaf3L+9mu3DrHPrWTXN0Hy
         DAPzCthCCCA0vA/pEBJ56cL5Ruwmek2D8Ym3yXTTZxOpjmehb1I1WC8uZWv5SFlRUzQJ
         zfwA==
X-Gm-Message-State: AD7BkJKT10wAJoEl6OuwOrkk77v6+UBehxdgCDoRJGoFrMMurPB5jxcX2BUSpEUIcRrAnw==
X-Received: by 10.25.157.79 with SMTP id g76mr2887439lfe.93.1458185694238;
        Wed, 16 Mar 2016 20:34:54 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:53 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Daan Pape <daan@dptechnics.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 17/18] devicetree: add DPTechnics vendor id
Date:   Thu, 17 Mar 2016 06:34:24 +0300
Message-Id: <1458185665-4521-18-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52631
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

Please see https://www.dptechnics.com/contact for details.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Daan Pape <daan@dptechnics.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f14451b..eb7cc2df 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -68,6 +68,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
 ebv	EBV Elektronik
-- 
2.7.0
