Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2008 22:51:28 +0100 (BST)
Received: from mail30f.wh2.ocn.ne.jp ([220.111.41.203]:52573 "HELO
	mail30f.wh2.ocn.ne.jp") by ftp.linux-mips.org with SMTP
	id S36923990AbYIDVv0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Sep 2008 22:51:26 +0100
Received: from vs30b.wh2.ocn.ne.jp (220.111.41.233)
	by mail30f.wh2.ocn.ne.jp (RS ver 1.0.95vs) with SMTP id 1-0177415067;
	Fri,  5 Sep 2008 06:51:20 +0900 (JST)
From:	Bruno Randolf <br1@einfach.org>
Subject: [PATCH] au1000: fix gpio output
To:	florian@openwrt.org, linux-mips@linux-mips.org
Date:	Thu, 04 Sep 2008 23:51:06 +0200
Message-ID: <20080904215105.4089.97714.stgit@void>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-SF-Loop: 1
Return-Path: <br1@einfach.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@einfach.org
Precedence: bulk
X-list: linux-mips

when setting the output state of one GPIO pin we have to keep the state of the
other pins, hence use binary OR. also gpio_direction_output() wants to set an
initial value, so add that too.

this fixes a problem with the USB power switch on mtx-1 boards.

Signed-off-by: Bruno Randolf <br1@einfach.org>
---

 arch/mips/au1000/common/gpio.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/au1000/common/gpio.c b/arch/mips/au1000/common/gpio.c
index b485d94..1f05843 100644
--- a/arch/mips/au1000/common/gpio.c
+++ b/arch/mips/au1000/common/gpio.c
@@ -61,7 +61,8 @@ static int au1xxx_gpio2_direction_input(unsigned gpio)
 static int au1xxx_gpio2_direction_output(unsigned gpio, int value)
 {
 	gpio -= AU1XXX_GPIO_BASE;
-	gpio2->dir = (0x01 << gpio) | (value << gpio);
+	gpio2->dir |= 0x01 << gpio;
+	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | (value << gpio);
 	return 0;
 }
 
@@ -90,6 +91,7 @@ static int au1xxx_gpio1_direction_input(unsigned gpio)
 static int au1xxx_gpio1_direction_output(unsigned gpio, int value)
 {
 	gpio1->trioutclr = (0x01 & gpio);
+	au1xxx_gpio1_write(gpio, value);
 	return 0;
 }
 
