Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 15:12:18 +0100 (BST)
Received: from cygnus.izmiran.rssi.ru ([IPv6:::ffff:193.232.24.21]:4013 "EHLO
	cygnus.izmiran.rssi.ru") by linux-mips.org with ESMTP
	id <S8225417AbVEFOMD>; Fri, 6 May 2005 15:12:03 +0100
Received: from [127.0.0.1] (IDENT:10003@localhost [127.0.0.1])
	by cygnus.izmiran.rssi.ru (8.12.4/8.12.4) with ESMTP id j46EBjcs017862
	for <linux-mips@linux-mips.org>; Fri, 6 May 2005 18:11:52 +0400
Date:	Fri, 6 May 2005 17:12:59 +0300
From:	"Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: "Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
Organization: Home
X-Priority: 3 (Normal)
Message-ID: <135147936.20050506171259@izmiran.rssi.ru>
To:	linux-mips@linux-mips.org
Subject: Re[2]: dbau1200 ethernet driver?
In-Reply-To: <E1DU2wJ-0006H6-Bd@real.realitydiluted.com>
References: <261758805.20050506155322@izmiran.rssi.ru>
 <E1DU2wJ-0006H6-Bd@real.realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Content-Transfer-Encoding: 8bit
Return-Path: <jerry@izmiran.rssi.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@izmiran.rssi.ru
Precedence: bulk
X-list: linux-mips

>[In reply to "dbau1200 ethernet driver?" from sjhill@realitydiluted.com <sjhill@realitydiluted.com> to Ruslan V.Pisarev <jerry@izmiran.rssi.ru>  06/05/2005 16:32]

>>  There is a smc91c111 network chip on board, so my question is - what
>> driver is suitable with him? Is it "MIPS AU1000 Ethernet support"
>> which fails to compile with "error: `NUM_ETH_INTERFACES' undeclared"
>> (and it must be?) or something different? It seems that I have enabled
>> all other options for ethernet functionality.
src> Without having access to a source tree currently, how about you grep
src> through the 'arch/mips/au1000' directory and friends for the string
src> NUM_ETH_INTERFACES. I think you will find that each board-specific
src> setup file is responsible for defining it. Either that, or look in
src> 'include/asm-mips'. In the future, make sure you grep through all of
src> the source to find other possible uses or examples.

Well, problem is something more complicated... At least for me :)

NUM_ETH_INTERFACES is defined /include/asm-mips/mach-au1x00/au1000.h
for all machines (au1000 au1100 au1500 au1550) except au1200. I dont
think that someone forgot to add NUM_ETH_INTERFACES for au1200. And
even what it means? All these machines have "on-board" ethernet
controller in processor core, so I think there's no external chip on
development board. au1200 haven't internal controller and has
dedicated chip on board...

 Furtermore, I found now, that Linux 2.4.26 distributed by AMD has an
additional option CONFIG_AU1XXX_SMC91111 in config for DBAu1200 which
controls compiling drivers/net/smc91111.c.
 In 2.6 this file disappeared but we have drivers/net/smc91x.c which
configures in some arm, ppc, and superh architectures. MIPS knows
nothing about him. Is it the right file? I suppose it is, but...

 Am I first who put 2.6 kernel on this board and see that is there no
drivers for it ? :)




   ()_()
--( °,° )---[21398845]-[jerry¤wicomtechnologies.com]-
  (") (")                 -<The Bat! 3.0.1.33>- -<06/05/2005 16:38>-
