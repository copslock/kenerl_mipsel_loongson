Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 00:54:30 +0100 (CET)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:34805 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491753Ab1CBXy2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 00:54:28 +0100
Received: from [10.150.1.116] (lentinj.plus.com [80.229.158.163])
        by chipmunk.wormnet.eu (Postfix) with ESMTPSA id 08B028262D
        for <linux-mips@linux-mips.org>; Wed,  2 Mar 2011 23:54:22 +0000 (GMT)
Date:   Wed, 2 Mar 2011 23:54:21 +0000 (GMT)
From:   Jamie Lentin <jm@lentin.co.uk>
X-X-Sender: lentinj@gonzo
To:     linux-mips@linux-mips.org
Subject: BCM47xx: Serial port swapping
Message-ID: <alpine.DEB.2.02.1103022314160.3579@gonzo>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.96.5 at chipmunk
X-Virus-Status: Clean
Return-Path: <jm@lentin.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jm@lentin.co.uk
Precedence: bulk
X-list: linux-mips

Hi,

I am running Debian on a Netgear WGT634U with a ~mainline 2.6.37 kernel. 
Upon upgrading from .32 I noticed this patch:-

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 87a3055..c95f90b 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -169,12 +169,28 @@ static int bcm47xx_get_invariants(struct ssb_bus 
*bus,
  void __init plat_mem_setup(void)
  {
  	int err;
+	char buf[100];
+	struct ssb_mipscore *mcore;

  	err = ssb_bus_ssbbus_register(&ssb_bcm47xx, SSB_ENUM_BASE,
  				      bcm47xx_get_invariants);
  	if (err)
  		panic("Failed to initialize SSB bus (err %d)\n", err);

+	mcore = &ssb_bcm47xx.mipscore;
+	if (nvram_getenv("kernel_args", buf, sizeof(buf)) >= 0) {
+		if (strstr(buf, "console=ttyS1")) {
+			struct ssb_serial_port port;
+
+			printk(KERN_DEBUG "Swapping serial ports!\n");
+			/* swap serial ports */
+			memcpy(&port, &mcore->serial_ports[0], sizeof(port));
+			memcpy(&mcore->serial_ports[0], &mcore->serial_ports[1],
+			       sizeof(port));
+			memcpy(&mcore->serial_ports[1], &port, sizeof(port));
+		}

A WGT634U only has the header on the second serial port, this is where 
CFE outputs it's console by default, and where I have my serial cable 
attached.

If I specify console=ttyS1, then the above kicks in and the serial port I 
am attached to becomes ttyS0 early in the boot process, and I loose 
console output. If I specify console=ttyS0, the above doesn't do anything 
so the kernel continues to use the unattached serial port. Either way I 
cannot get any console output without some hacking.

Currently I have removed the block, specified "console=ttyS1" in the 
commandline, and this gives me working console all the way through boot. 
I'm happy to test/supply any further patches, solutions I can think of 
are:-

* Remove it entirely: I think this code has it's origins in OpenWRT 
code that swapped ports so the userland didn't have to use ttyS1 for a 
bunch of devices, ttyS0 for another. It's certainly not required to get 
console output on my device, not tested any other variants of this 
platform.

* Invert the strstr logic, so that the swap happens if I don't specify 
ttyS1 as my console. Then regardless of whether I use ttyS0 or ttyS1, I 
get a console.

* Have a more explict "swap_serial_ports" kernel parameter

Cheers,

-- 
Jamie Lentin
