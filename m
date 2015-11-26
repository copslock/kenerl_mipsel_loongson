Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 11:02:02 +0100 (CET)
Received: from mxout51.expurgate.net ([194.37.255.51]:52408 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012747AbbKZKBg3ozTI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2015 11:01:36 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1tMp-0005Gk-5w; Thu, 26 Nov 2015 11:01:31 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1tMo-0002bp-7y; Thu, 26 Nov 2015 11:01:30 +0100
Received: from mschille.tdtnet.local (10.1.3.20) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Thu, 26 Nov 2015
 11:01:29 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <ralf@linux-mips.org>, <blogic@openwrt.org>, <hauke@hauke-m.de>,
        <jogo@openwrt.org>, <daniel.schwierzeck@gmail.com>,
        Martin Schiller <mschiller@tdt.de>
Subject: [PATCH v3 3/5] pinctrl/lantiq: update devicetree binding in dts file
Date:   Thu, 26 Nov 2015 11:00:08 +0100
Message-ID: <1448532010-30930-3-git-send-email-mschiller@tdt.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
References: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.1.3.20]
X-EsetResult: clean, is OK
X-EsetId: 37303A29F17133606C7561
X-C2ProcessedOrg: 0a9847a8-efc2-4cb2-92f2-0898183e658d
Content-Transfer-Encoding: 8BIT
X-purgate-relay-fid: relay-5443cb
X-purgate-sourceid: 1a1tMo-0002bp-7y
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448532091-00007EF9-D65CFDA4/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-230693
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschiller@tdt.de
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

This patch updates the compatible string in the easy50712.dts file to the new
"lantiq,danube-pinctrl".

Signed-off-by: Martin Schiller <mschiller@tdt.de>
---
Changes in v3:
None

Changes in v2:
-changed "lantiq,pinctrl-danube" to "lantiq,danube-pinctrl"

 arch/mips/boot/dts/lantiq/easy50712.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/lantiq/easy50712.dts b/arch/mips/boot/dts/lantiq/easy50712.dts
index 143b8a3..b599625 100644
--- a/arch/mips/boot/dts/lantiq/easy50712.dts
+++ b/arch/mips/boot/dts/lantiq/easy50712.dts
@@ -52,7 +52,7 @@
 		};
 
 		gpio: pinmux@E100B10 {
-			compatible = "lantiq,pinctrl-xway";
+			compatible = "lantiq,danube-pinctrl";
 			pinctrl-names = "default";
 			pinctrl-0 = <&state_default>;
 
-- 
2.1.4
