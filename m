Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:18:14 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36710 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012382AbcBIIOnBhfO5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:43 +0100
Received: by mail-lf0-f68.google.com with SMTP id h198so5993333lfh.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jig7yg8p+dg74CEeFelmJhk9Smv2Dpe8Ff/R4EaIGoE=;
        b=LQzOjEPckeLy+wnxNIt/C4aOZdEJYMS84kotporN+96iim8Z5MVozoItuQlEdSu0BM
         qeujDuVmiKpK/Jv8xNmM1RjLUFc1xeNkoZ93ccF2wHfJ/DpxD3X39IFpjOh6a7UW1Hr0
         r1GqWu1aC/mG+AoyzxdM4lxsZ0vS2KjlQmmUZFqjkHvjSBEB1Ep091gYOiHB0KETEfhP
         jfkmuxmIS9sC5MoRxc3Aszp3i5BwtR2xScqfCiRGwLGPCrU5GjTYfc81iVFrR/rIQBl8
         s79RabO6Mj9g2vIXYKHcgL49pQqKiYxqNT7/YNNgjT4bW/fPe6VJq00l3Lm0bzajeNbX
         NhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jig7yg8p+dg74CEeFelmJhk9Smv2Dpe8Ff/R4EaIGoE=;
        b=Ygy+kRzHYDjpSm1R8QTArL2d5V14D9XJ5Ilw5mxUrpiIT0EzlayOUn4LPfNiEnZZvv
         sBv80lGsVgw3yWkkzRUKe7C42WovWPDXB0Ub8kItEzp3NKoI0Qg+kK+0elTwCr2LxnGN
         R/nXVOCy8aayelwrMIKWYUnjfDb2MT+KRw5aFhKQb2olmaYtK6Jq/Xh1TqNVO0OFvcsO
         IvjnG7ycf2wVVMw2DzpjXZX5NxRR/FsBTEUSWSXTstbG7ll/KLw3gDP+Q514z9jjlbFx
         urO+jlL4xZm3k2c3Dk+aFbAb0iIPKjkHRjmLHKDzc5sbh1glyN0RBmHF5fe7+15fMCdO
         kc5g==
X-Gm-Message-State: AG10YOS2/WrV+KuIL56CNjxr6ZH5q3jU2X60wEO2ahbkYpM8XWlirEQBkZKXl+S9DI5ZRw==
X-Received: by 10.25.81.144 with SMTP id f138mr13256446lfb.146.1455005677759;
        Tue, 09 Feb 2016 00:14:37 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:37 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Daan Pape <daan@dptechnics.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC v5 13/15] devicetree: add DPTechnics vendor id
Date:   Tue,  9 Feb 2016 11:13:59 +0300
Message-Id: <1455005641-7079-14-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51889
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
Cc: Daan Pape <daan@dptechnics.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index afb96f7..8cb96f2 100644
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
