Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 16:24:02 +0100 (BST)
Received: from smtp102.rog.mail.re2.yahoo.com ([IPv6:::ffff:206.190.36.80]:38075
	"HELO smtp102.rog.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225221AbUJFPX6>; Wed, 6 Oct 2004 16:23:58 +0100
Received: from unknown (HELO ?192.168.1.100?) (charles.eidsness@rogers.com@24.157.59.167 with plain)
  by smtp102.rog.mail.re2.yahoo.com with SMTP; 6 Oct 2004 15:23:46 -0000
Message-ID: <41640DFE.8050609@ieee.org>
Date: Wed, 06 Oct 2004 11:23:42 -0400
From: Charles Eidsness <charles.eidsness@ieee.org>
Reply-To: charles.eidsness@ieee.org
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: DB1x00 FLASH and Kernel 2.6.8.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <charles.eidsness@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.eidsness@ieee.org
Precedence: bulk
X-list: linux-mips

Hi All,

I had to make a minor change to the db1x00 flash's memory map definition 
file in version 2.6.8.1 of the kernel in order to get flash support to 
compile. See attached patch if interested.

Cheers,
Charles

--- linux-2.6.8.1-mips/drivers/mtd/maps/db1x00-flash.c	2004-01-30 
02:34:34.000000000 -0500
+++ linux-2.6.8.1-mips/drivers/mtd/maps/db1x00-flash.c	2004-10-06 
10:39:20.950558416 -0400
@@ -164,9 +164,9 @@
  			return 1;
  	}
  	db1xxx_mtd_map.size = window_size;
-	db1xxx_mtd_map.buswidth = flash_buswidth;
+	db1xxx_mtd_map.bankwidth = flash_buswidth;
  	db1xxx_mtd_map.phys = window_addr;
-	db1xxx_mtd_map.buswidth = flash_buswidth;
+	db1xxx_mtd_map.bankwidth = flash_buswidth;
  	return 0;
  }

@@ -189,7 +189,7 @@
  	 * specific machine settings might have been set above.
  	 */
  	printk(KERN_NOTICE "Db1xxx flash: probing %d-bit flash bus\n",
-			db1xxx_mtd_map.buswidth*8);
+			db1xxx_mtd_map.bankwidth*8);
  	db1xxx_mtd_map.virt = (unsigned long)ioremap(window_addr, window_size);
  	db1xxx_mtd = do_map_probe("cfi_probe", &db1xxx_mtd_map);
  	if (!db1xxx_mtd) return -ENXIO;
