Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Mar 2008 00:29:01 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:53670 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28643159AbYCHA26 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Mar 2008 00:28:58 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JXmvq-0005Wi-00; Sat, 08 Mar 2008 01:28:58 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 19DE2E31BE; Sat,  8 Mar 2008 01:28:54 +0100 (CET)
Date:	Sat, 8 Mar 2008 01:28:54 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cobalt build error
Message-ID: <20080308002854.GA10446@alpha.franken.de>
References: <20080307153256.GA8851@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080307153256.GA8851@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Mar 07, 2008 at 03:32:56PM +0000, Ralf Baechle wrote:
> Maybe some Cobalt hacker can sort out these issues in the latest kernel.
> I could try to fix the build but don't have any Cobalt kit for testing ...

the patch below fixes the compile breakage, but is untested ...

Thomas.


Fix breakage introduced by commit b037b08e59633d939d79f1df9c43c6625f8db904

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 drivers/input/misc/cobalt_btns.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/cobalt_btns.c b/drivers/input/misc/cobalt_btns.c
index 4833b1a..b554047 100644
--- a/drivers/input/misc/cobalt_btns.c
+++ b/drivers/input/misc/cobalt_btns.c
@@ -97,16 +97,15 @@ static int __devinit cobalt_buttons_probe(struct platform_device *pdev)
 	input->name = "Cobalt buttons";
 	input->phys = "cobalt/input0";
 	input->id.bustype = BUS_HOST;
-	input->cdev.dev = &pdev->dev;
 
-	input->keycode = pdev->keymap;
-	input->keycodemax = ARRAY_SIZE(pdev->keymap);
+	input->keycode = bdev->keymap;
+	input->keycodemax = ARRAY_SIZE(bdev->keymap);
 	input->keycodesize = sizeof(unsigned short);
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 	__set_bit(EV_KEY, input->evbit);
-	for (i = 0; i < ARRAY_SIZE(buttons_map); i++)
-		__set_bit(input->keycode[i], input->keybit);
+	for (i = 0; i < ARRAY_SIZE(cobalt_map); i++)
+		__set_bit(cobalt_map[i], input->keybit);
 	__clear_bit(KEY_RESERVED, input->keybit);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
