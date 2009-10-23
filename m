Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 17:59:07 +0200 (CEST)
Received: from smtp121.mail.ukl.yahoo.com ([77.238.184.52]:37535 "HELO
	smtp121.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1491969AbZJWGvR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 08:51:17 +0200
Received: (qmail 17765 invoked from network); 23 Oct 2009 06:51:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:To:Subject:From:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=krtHxUVp9/S7UiXzxNiJ1HMauG/WR6h4bfgEeh6t+Iamhlu/HAbH69uBYl1LR/5ad7ms2dTF8OsQdECR4BcXmFpXy3OBkdzs7bICnasKcLSx0QweQyFm4f3AmY67vRUaRb/loOiHOvty9hjjmaFAh3IBVxLxARKb7JZNqkr0MOU=  ;
Received: from 61-59-128-157.static.seed.net.tw (lindner_marek@61.59.128.157 with plain)
        by smtp121.mail.ukl.yahoo.com with SMTP; 23 Oct 2009 06:51:11 +0000 GMT
X-Yahoo-SMTP: tW.h3tiswBBMXO2coYcbPigGD5Lt6zY_.Zc-
X-YMail-OSG: uOrFAjkVM1nMGuF6XNR1CZdIlGoBlaiEp87DwbReJaF9kZKUSLjgHQXg9lPfbIeXITxaYxJtsyRHwEIeAxCB.HwFOMfgjs7M8GH21DRVYLxpjxc7tqd.y8iSSrVlTek3k64DfLsMBExXZrlEq4TMdPemw4zyETiFjLFZX22_ZFFP2OYB2TerqMuNyudDuwqBmsAYqRcMphcdEFUPUQQ1zCwjTU16YZVmtG1B1heJ0d1yVvlWzV_p81TxXURorI9A
X-Yahoo-Newman-Property: ymail-3
To:	linux-mips@linux-mips.org
Subject: PCI error on iwconfig wlan0 up
From:	Marek Lindner <lindner_marek@yahoo.de>
Date:	Fri, 23 Oct 2009 14:48:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200910231448.30202.lindner_marek@yahoo.de>
Return-Path: <lindner_marek@yahoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24468
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindner_marek@yahoo.de
Precedence: bulk
X-list: linux-mips


Hi,

I'm running an Ubiquiti wifi card (SR71 -12) on Ubiquiti's router station 
using the latest compat-wireless driver. Unfortunately, the driver crashes as 
soon as I try to enable the card (iwconfig wlan0 up). 

It seems to be a problem related to the wifi driver but we are not sure what 
the PCI error is trying to tell us, hence it is a bit hard to fix. As it is a 
mips based device (MIPS 24Kc V7.4) you might be able to help us decipher the 
error message.

The kernel backtrace looks like this:
PCI error 1 at PCI addr 0x10009a10                                               
Data bus error, epc == 83c45b5c, ra == 83c45b54                                  
Oops[#1]:                                                                        
Cpu 0                                                                            
$ 0   : 00000000 00000000 deadc0de 00000000                                      
$ 4   : b0008048 02000020 00000002 00000223                                      
$ 8   : 00005848 83a4c750 00000000 00000000                                      
$12   : 00000001 00000000 4acf889b 00000000                                      
$16   : 83c0290c 00000223 83bb0000 0000014f                                      
$20   : 83a4c1e0 83bb00e4 00000004 83bb0004                                      
$24   : 00000010 83c0290c                                                        
$28   : 83f00000 83f01ce0 00000002 83c45b54                                      
Hi    : 0000000a                                                                 
Lo    : 17980000                                                                 
epc   : 83c45b5c ath9k_hw_reset+0xd64/0x1cbc [ath9k_hw]                          
    Not tainted                                                                  
ra    : 83c45b54 ath9k_hw_reset+0xd5c/0x1cbc [ath9k_hw]                          
Status: 1000f403    KERNEL EXL IE                                                
Cause : 1080001c                                                                 
PrId  : 00019374 (MIPS 24Kc)                                                     
Modules linked in: ath9k ath9k_hw pppoe pppox ppp_async ppp_generic slhc ath 
mac80211 cfg80211 crc_ccitt arc4 aes_generic deflate ecb cbc button_hotplug 
gpio_buttons input_polldev input_core leds_gpio [last unloaded: ath9k_hw]                                                                                                                                
Process ifconfig (pid: 687, threadinfo=83f00000, task=8389d200, tls=00000000)                                                                                                    
Stack : 7fb66ff8 801f13b4 83804c00 00000000 00000000 83f01e20 83c156b0 00000001                                                                                                  
        00000000 20000000 83bb00e4 83a4c934 83bb0000 83c156b0 83a4c1e0 
83a4c9d0                                                                                                  
        83f01d72 83f01d74 83f01d70 83c03550 00000000 00000015 802d4720 fffffffe                                                                                                  
        83a4c1e0 ffffff82 83a96ac0 00001043 83a96800 00000000 83bcc50c 83a96800                                                                                                  
        80094d4c 80094d4c 802d83b0 83a28c60 00000000 00008964 83a96800 
83bdfae8                                                                                                  
        ...                                                                                                                                                                      
Call Trace:                                                                                                                                                                      
[<83c45b5c>] ath9k_hw_reset+0xd64/0x1cbc [ath9k_hw]                                                                                                                              
[<83c03550>] ath_descdma_setup+0x2c8/0x19c4 [ath9k]                                                                                                                              
[<83bcc50c>] ieee80211_if_change_type+0xa74/0xfa4 [mac80211]


Thanks for you help,
Marek
