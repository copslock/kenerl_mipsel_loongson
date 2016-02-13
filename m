Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 22:59:08 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36162 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012243AbcBMV6caztii (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:32 +0100
Received: by mail-lf0-f68.google.com with SMTP id h198so5750334lfh.3;
        Sat, 13 Feb 2016 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvnxd0bHNwBcvZ25QiSkF/qr5IjIzGKVbYSRIwcQoRI=;
        b=jGZEuH95+SGjMafQ3LrOrjB+q8PBnzG49V456reLbX95x/laRGKlW87ol8vW/etiw4
         gKPIK55F4purlsP/ikk3ND6Y6Tjkx1P2i/f3B+luAQtIvxiEnzXBf0nP7DjDE/5u43e+
         vm+l/ab7O/NOPrZn9B60+961JCm11OSKAfipQp8TqqDpsvGLW3v+ygDfTKn6sEbm402n
         4awU/yImp5nbhJGTNI/aLCbGpabG+bDWH+CVpmDMQWJVnBrhc/sJ5CLYQS8fFKwDVzme
         xUpjQAAqOjI4ZlfclBulE5M1zmU1rNrsWwVMDGIybnrqGz3gdaNYnOKlXue+Oh3yjPv9
         9wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvnxd0bHNwBcvZ25QiSkF/qr5IjIzGKVbYSRIwcQoRI=;
        b=d3vJvQZy4sIojBdhZ9I6lMJzmZXtPT4yEDuwlibSiOk8d+zfuOjz0KZI6UKdeE+IG6
         2bgJBQ4DqHMq+/PFkgpJnJwhsMqNH5nMPjQgANaA5K2AsA5m3Tohc56SWtuHuJV+ncXF
         yPU8eR8FJAmH730lg0Os/GZUApJqlwt89o1ZfcxLJqFPX/ebyci9Lv4wsgcP41Hcxqt9
         wveIaqwe9m8hu2ykygS7uwqjq71WlUgMBNGNlCrQl5gHe3LCLGzU6nxM96IoLJ3GHAqa
         Ol6SEjowRo8KmCNmJ7045lD5bpbTS0Fpiq9YHOsxfoqkQSTLUglFziw83GA+IwfiMwo2
         7uhg==
X-Gm-Message-State: AG10YOQ7wQU9nZtqZUo/7cN+ApLa7nUxNT1x5xCWpLL+7kIKjyCpcZwA3Z0yXX16fckpug==
X-Received: by 10.25.153.130 with SMTP id b124mr3633292lfe.81.1455400707268;
        Sat, 13 Feb 2016 13:58:27 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:26 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 02/10] MIPS: dts: qca: ar9132: fix typo: "ppl" -> "pll"
Date:   Sun, 14 Feb 2016 00:58:09 +0300
Message-Id: <1455400697-29898-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52034
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt | 2 +-
 arch/mips/boot/dts/qca/ar9132.dtsi                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
index ae99f22..241fb05 100644
--- a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
+++ b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
@@ -22,7 +22,7 @@ Optional properties:
 Example:
 
 	pll-controller@18050000 {
-		compatible = "qca,ar9132-ppl", "qca,ar9130-pll";
+		compatible = "qca,ar9132-pll", "qca,ar9130-pll";
 		reg = <0x18050000 0x20>;
 
 		clock-names = "ref";
diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 3ad4ba9..3c2ed9e 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -83,7 +83,7 @@
 			};
 
 			pll: pll-controller@18050000 {
-				compatible = "qca,ar9132-ppl",
+				compatible = "qca,ar9132-pll",
 						"qca,ar9130-pll";
 				reg = <0x18050000 0x20>;
 
-- 
2.7.0
