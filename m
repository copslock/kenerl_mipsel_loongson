Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 09:29:16 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:26244 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225460AbTIXI3L> convert rfc822-to-8bit;
	Wed, 24 Sep 2003 09:29:11 +0100
Received: (qmail 16026 invoked from network); 24 Sep 2003 08:13:21 -0000
Received: from unknown (HELO xing) (159.226.39.104)
  by mail.ict.ac.cn with SMTP; 24 Sep 2003 08:13:21 -0000
From: "Guangxing Zhang" <guangxing@ict.ac.cn>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>,
 angela <jhyang@ict.ac.cn>
Subject: help, question on pci communication!
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Wed, 24 Sep 2003 16:29:32 +0800
Message-Id: <20030924082911Z8225460-1272+6248@linux-mips.org>
Return-Path: <guangxing@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guangxing@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi, Fuxin and everyone see this mail,
    In linux world ,newbies always like to ask and the veterans will always be enthusiastic.:)~~
    Now there is a "ask", of course i am a newbie. 
    Follow is the  architecture  which we are working on.
    Now i want to transfer the data from the "sb1250" to mcp750 through the PCI bus with the help of 21555 bridge.
I want to implement it in kernel module.Although knowing "use the force ,read source",but i really do not know
how and where to begin.
    Is there any advice on it ? How to implement the communication through PCI (or PCI-to-PCI bridge) in kernel 
moudle?
    Any help will be appreciated!Thank in advance!
  
                      -------------
	                  |  MCP 750  |  (Power PC)
                      -------------
                            |
　	    -------------------------------------------CPCI
                         |
             ---------------|--------------------------------    
             |      --------|-----                         |
             |      |Intel 21555 |(PCI-TO-PCI Bridge)      |
             |      --------------                         |
             |        |                					   |	
             |      --------(PCI bus)					   |
			 |          |                                  |
			 |       --------                              |
			 |		 |SB1250|(CPU)                         |
			 |       --------                              |
             ----------------------------------------------           
　　　　　　　　Guangxing Zhang
　　　　　　　　guangxing@ict.ac.cn
			    2003-09-24 16:03:04
　　　　　　　　　　
