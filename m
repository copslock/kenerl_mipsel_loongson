Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:20:44 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36610 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014857AbcAWUR6GRX3d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:58 +0100
Received: by mail-lb0-f178.google.com with SMTP id oh2so56904528lbb.3
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGr5dtaqkhhYfCMBiBHWvWrd2CCn6reMCzvrHxLLgxw=;
        b=ZXYz0fIPM+WXZ304OAFiIgBindZRrSPLPlsEyhXIuLEPlhvdiRNFzmwsuWaYQ2f/WK
         x2FL/YxD0+vKIdCU1Z/1frmTasNQkacACWjDBxvAN+74mZTTGcV+Uipt+DiAaLOgk/VA
         UKuwteiBgMtP0f9mNIsjxrFQKP4eGxqVaCcGXe+57LXK+lb1obSNv/mfaZrWJPI6EqM5
         WjUTdlh+6iDA9ntk/8ci6kHJCampJtof3gDeexRIwi1kaqenTMy/FJvled/ikGqD9DsN
         CJmqBRN3aSAH2eoiaWK/ay+s0wuhmsz0xFmSLa7EdZY4A4NulTSlI/OtAMiquKZuYOOO
         F4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGr5dtaqkhhYfCMBiBHWvWrd2CCn6reMCzvrHxLLgxw=;
        b=cPDjfhS+RABpM52eBizecxoIk3QhpDxMZRXQxRJKvNB3wLG2qaSPIOVELlXTTwHGsX
         +sKZKa+2RCFXayW5J8+KART1fOskxHfDZL4yso6D8JsNC+XKl19w5hhp6YoLPjKromJv
         trvoUeelbkJdecR5PACzR33sTexWd5vuuiIyYETr5kepbzsXVKYPk36e/kk6Iq2616RR
         MiiVDIlHaf+6/zVWxyZ0Igohd1nUr94yr1stQ18W75DQ8C/+vCjodIY8y76hfUZ6ANRt
         i40u4gAqmvz/8epRaKi5tZ80QGAcAGvdk31Qzf6V+99PlFyld9E7ZbvP9Wbv/pirDneL
         We6Q==
X-Gm-Message-State: AG10YORevp0aHvjCk5oCpf4LYMp9nA5ceC718GljIvUPZfkpibmXvb8eeq3ZUofwZKGcKQ==
X-Received: by 10.112.162.231 with SMTP id yd7mr3552737lbb.40.1453580272791;
        Sat, 23 Jan 2016 12:17:52 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:52 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, devicetree@vger.kernel.org
Subject: [RFC v3 10/14] devicetree: add Dragino vendor id
Date:   Sat, 23 Jan 2016 23:17:27 +0300
Message-Id: <1453580251-2341-11-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51336
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
