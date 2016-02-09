Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:17:04 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36704 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012054AbcBIIOjCxmL5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:39 +0100
Received: by mail-lf0-f68.google.com with SMTP id h198so5993297lfh.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SP25XY9xbN7Ww65yCfYokIL9Mx2poZ/8O5Ikpo2BczQ=;
        b=IzjIyKKj2IL0LRFA4pFG0/Gd30lhSC2Gx7rRYIE33CxbPZtdOBgQkwRwzdiX1ZlLOc
         HKgqtkOnJvn/O14uMmWr1yfAtUXlFXcXwDyU9sXkJJ7jfQQO0KctNntyGaPmk2wql173
         B/jLmplm3DL91DIKXLfgtTlQeStsI0pnRxuSaWOn8Y8lkTeAHmG5gTuJv6iNGePPgT3v
         rCYMGXKliB1Z2AVhpxyCZQNl5qfVH8Z+5oWa0BYNKekU+q9tq5SBVn6lXOgPy0DhvZZQ
         OsvD+375yYKw8CzkmXtNa2pcJeRtFIz+/1dmrwHmLd8XVbfatX0Z+l7bOeNINXgMO8f3
         D4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SP25XY9xbN7Ww65yCfYokIL9Mx2poZ/8O5Ikpo2BczQ=;
        b=GlL6O28+oBcS6KqFcwZ2DSYqWXrtuFIsVRxuPswGhRoRZYgbdqr7FFM9ZRitw2DTan
         HfzTYCJ5IiT/8ipire37l7sQAjJX6drPMis352Peo22QLZViXtB3lg/IJL3dJllEwyZ7
         /JTd/WjiXndCURp0R1eMWGuQORNOoc4APRZy9EIYiohGi5BTDz/BsJuVbNBZi0PZu1cI
         Eu55Ijfi2PnUWRDUvqPUy6j8HoPKcQ3CGEojQLojq8hpjCgVmM69yPgk0/8QYacyyqcM
         Lta4rWbLXXzJXAiDON+C2HqPCTrnZoa+KpsZU09Ui2EFXyqqkcqzjwYvEmByZpsCoT4y
         +sEg==
X-Gm-Message-State: AG10YOS7xuxckwvNd7eodGTzse51VXypnT14FoeKWPuYfvtBpQS0OTGKj8KbKVMlBjhHcg==
X-Received: by 10.25.7.201 with SMTP id 192mr10841870lfh.107.1455005673773;
        Tue, 09 Feb 2016 00:14:33 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:33 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org
Subject: [RFC v5 09/15] devicetree: add Dragino vendor id
Date:   Tue,  9 Feb 2016 11:13:55 +0300
Message-Id: <1455005641-7079-10-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51885
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
