Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:38:18 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32980 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007177AbcCQDezU3s5p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:55 +0100
Received: by mail-lf0-f65.google.com with SMTP id l83so2209155lfd.0
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZEEgAUaip1ad7ArFsfYJpMPuecDoJLIqeNBMjOJZak=;
        b=KmXDhNCFviXU03WoOYklfnsK9BUBmw+sFbFnX9vi86VP0xhAqDYAoTPkDGowElEfrz
         yahKreUaFr8agJtJAW0kaBvvM9c9+mGO26gyD9Jw+OuFnF3UH5Qq9WKsBhKBrlHenzOy
         IWRH3RSnr71D3t8nnZsOaVrhXyy+HkrcJ7cEDq2smNJk3v3VVZILbV7FBzgOfBTMjg1e
         XNfPDt7B2tE2HzYyRwD9HWG496yJJ4tGQg3xAMBJuEz76Zbxq8bphyBqJ1ptLighdsi0
         6kL4y+8NZzr2aCjVpDweHEYh5XzpzkMSEE3UIhwR7MuXRa+XwaXCaMJeD5bqVS0WqXE6
         RxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZEEgAUaip1ad7ArFsfYJpMPuecDoJLIqeNBMjOJZak=;
        b=cXTfe5iKONrw5ylocfNWkXr2736hlfaupIfoWfZ7VA9AaevP0sMjIUxxRg+rbUuCd6
         AJyWOBIFVbSD2105CUqh+v/YxuOGB+E11CeMMJtl40RtEysrpCk0LgJeEhIDdNPLPJTG
         PO2e2IeLDldT/Fij5tPaT+xv/PXrKWTIK4yDzWhp4ejsHVrX7n1BeGRQNb4A2C79h8nv
         w7kf5n0ybgk2R8Q+4hG8ZOEYoImMm+95TfGa8U9H0l/5gOYgt8urVUEJUiwKqjVKTWm8
         9Ppc0GELwjRkna8xMgLqtr2sTnnRYkC/pPpu+JErsQTrwcz26Bn+FFr4+ufE6NGeudTc
         XuAg==
X-Gm-Message-State: AD7BkJIhbCxbMZu8zlQXZrTvvH4g3VIK+5OuF7dFfSWQ7lB/TYa0bD6Xs6MT+YzyaxP0TA==
X-Received: by 10.25.27.200 with SMTP id b191mr2895394lfb.8.1458185690069;
        Wed, 16 Mar 2016 20:34:50 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:49 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 13/18] devicetree: add Dragino vendor id
Date:   Thu, 17 Mar 2016 06:34:20 +0300
Message-Id: <1458185665-4521-14-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52627
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
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index dd72e05..bbce325 100644
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
