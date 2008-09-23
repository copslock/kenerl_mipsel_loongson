Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 18:48:55 +0100 (BST)
Received: from mail30g.wh2.ocn.ne.jp ([220.111.41.239]:25761 "HELO
	mail30g.wh2.ocn.ne.jp") by ftp.linux-mips.org with SMTP
	id S28595016AbYIWRsp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Sep 2008 18:48:45 +0100
Received: from vs30a.wh2.ocn.ne.jp (220.111.41.231)
	by mail30g.wh2.ocn.ne.jp (RS ver 1.0.95vs) with SMTP id 0-0707642116;
	Wed, 24 Sep 2008 02:48:39 +0900 (JST)
From:	Bruno Randolf <br1@einfach.org>
Subject: [PATCH] au1000: fix gpio direction
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Date:	Tue, 23 Sep 2008 19:48:36 +0200
Message-ID: <20080923174828.8694.12510.stgit@void>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-SF-Loop: 1
Return-Path: <br1@einfach.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@einfach.org
Precedence: bulk
X-list: linux-mips

when setting the direction of one GPIO pin we have to keep the state of the
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
 
