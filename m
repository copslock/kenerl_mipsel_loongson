Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:14:46 +0100 (CET)
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35924 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011951AbcBAALFyrZeA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:05 +0100
Received: by mail-lf0-f43.google.com with SMTP id 78so37425142lfy.3
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eQYDNPPg/rcGRSrFRmIVtxE8i0LWNLD1Eg8Da0rcOk8=;
        b=iCz5atOLUJH1hY1shouhYW2lvO1maH0XREf4Azpe5mafxjqnf/r2Pc7bPMUm9tQdlv
         3dWUcTlt+Qb/94nDqtHRKNh6+7dEm+h0KJ8ksjVPCl11ibH+V92leVU5nx7f+JWwtDrw
         lua1gtEwVDgXCOtwl54C05bNAZW2lMW1g0kNXed+hGaDWnaoqhTJdAv/0z/WkmnhAjcD
         69aP07T3NEfUdIBey+fU6FLsx77JtQJCbWnKtAGHPS2Tkz1PDeoeYKagEu58efELo6na
         0dlZf2Z8o7Ms6uixAo5h6cy6TB2lujSsA/F/Hbu03T2LPtlcr3PYm3sIgGb8FLrGS/a+
         jN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eQYDNPPg/rcGRSrFRmIVtxE8i0LWNLD1Eg8Da0rcOk8=;
        b=YGRcr6/kl6wj8B1mWNc0aJIEeePcIW56JwKvcU7OfYTSa57wK4aDzITJP9O6sitB8J
         BZ80P+8b21LfoYMnxA/yUqrgBR4C4pz6MaaPBP0Jahyrh1uaMM6rhRTTPOD8mQOBTya8
         ni4nt3QgmnN+F6VXGLiT40IeMczlWg6D0tqGvO74ridrJCyy/0RqitoYVXidMnke4TSX
         ncIDd613loguk9b9zk+1hvkzXYJNumh+QfrUCR34A+1GdGsa5WsR1LXCoflUePLrU6Ql
         flPbNhfQD0OGz0Rjh6U8EMvwbSKFSkbMrrNInsh1q9SJyFsciKmakO4Nmuca1lb9R/nH
         3qdA==
X-Gm-Message-State: AG10YOQDSkGeL5CaPrFc7tS8hd/W5hdHvfdmRrAvOzYyp25Ymbp70KUat6wYf39KWilv/g==
X-Received: by 10.25.31.136 with SMTP id f130mr7509636lff.5.1454285460686;
        Sun, 31 Jan 2016 16:11:00 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:11:00 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, devicetree@vger.kernel.org
Subject: [RFC v4 13/15] devicetree: add Onion Corporation vendor id
Date:   Mon,  1 Feb 2016 03:10:38 +0300
Message-Id: <1454285440-18916-14-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51574
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
