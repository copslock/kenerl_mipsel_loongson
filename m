Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 11:35:10 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:12048 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225206AbTBELfJ>;
	Wed, 5 Feb 2003 11:35:09 +0000
Received: from localhost ([193.170.141.10]) by grey.subnet.at ; Wed, 05 Feb 2003 12:35:00 +0100
From: Bruno Randolf <br1@4g-systems.de>
To: linux-mips@linux-mips.org
Subject: which kernel tree for Au1500?
Date: Wed, 5 Feb 2003 12:34:01 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302051234.01252.br1@4g-systems.de>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <br1@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@4g-systems.de
Precedence: bulk
X-list: linux-mips

hello, 

we are developing a board based on the Au1500 SOC and we need to adapt the 
linux kernel for it. since we need something working soon, we will 
concentrate on the 2.4 version.

so i wanted to ask which kernel tree is recommended for the Au1x00 chipset. 
i've found the tree on http://linux-mips.sourceforge.net/ and the 2_4 branch 
of linux-mips.org look most promising, but they have various differences, 
most obvious the hyd1100/ directory on sf and the db1x00/ directory on 
linux-mips. another significant difference is that the sf version has power 
management support and that linux-mips supports one more PHY in au1000_eth.c.

how is kernel work for mips organized?

many thanks,
bruno
