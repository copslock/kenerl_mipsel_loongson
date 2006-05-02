Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 06:46:25 +0100 (BST)
Received: from bes.recconet.de ([212.227.59.164]:28648 "EHLO bes.recconet.de")
	by ftp.linux-mips.org with ESMTP id S8133358AbWEBFqM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 06:46:12 +0100
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bes.recconet.de (8.13.1/8.13.1/Recconet-2005031001) with ESMTP id k425kBE2008179
	for <linux-mips@linux-mips.org>; Tue, 2 May 2006 07:46:11 +0200
Received: from seneca.recco.de (seneca.recco.de [172.16.135.97])
	by trinity.recco.de (8.13.1/8.13.1/Reccoware-2005061101) with ESMTP id k425jLl2010102
	for <linux-mips@linux-mips.org>; Tue, 2 May 2006 07:45:21 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by seneca.recco.de (8.13.6/8.13.4/Seneca.Reccoware-2005061801) with ESMTP id k425kAqr023308
	for <linux-mips@linux-mips.org>; Tue, 2 May 2006 07:46:10 +0200
Subject: Au1200 MMC/SD problem
From:	Wolfgang Ocker <weo@reccoware.de>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Reccoware Systems
Date:	Tue, 02 May 2006 07:46:10 +0200
Message-Id: <1146548770.1597.43.camel@seneca.recco.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Return-Path: <weo@reccoware.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weo@reccoware.de
Precedence: bulk
X-list: linux-mips

Hello,

I'm trying to get a SD card to work on an Db1200 board. I'm using kernel
2.6.16.11 (+ the patch from Jordan Crouse):

http://www.linux-mips.org/archives/linux-mips/2005-12/msg00006.html

The card gets recognized and issues its relative address. Then command 9
(send csd) times out.

MMC: req done (37): 0: 00000120 00000000 00000000 00000000
MMC: starting cmd 29 arg 00018000 flags 00000061
MMC: req done (29): 0: 80ff8000 00000000 00000000 00000000
MMC: starting cmd0 2 arg 00000000 flags 00000067
MMC: req done (02): 0: 01504153 30313642 414a8be0 08004a00
MMC: starting cmd 03 arg 00000000 flags 00000065
MMC: req done (03): 0: e008004a 00000000 00000000 00000000
MMC: starting cmd 02 arg 00000000 flags 00000067
MMC: req done (02): 1: 00000000 00000000 00000000 00000000
MMC: req done (02): 1: 00000000 00000000 00000000 00000000
MMC: req done (02): 1: 00000000 00000000 00000000 00000000
MMC: req done (02): 1: 00000000 00000000 00000000 00000000
au1xx(0): DEBUG: set_ios (power=2, clock=450000Hz, vdd=15, mode=2)
MMC: starting cmd 09 arg e0080000 flags 00000007
MMC: req done (09): 1: 00000000 00000000 00000000 00000000
MMC: req done (09): 1: 00000000 00000000 00000000 00000000
MMC: req done (09): 1: 00000000 00000000 00000000 00000000
MMC: req done (09): 1: 00000000 00000000 00000000 00000000

I'm new to MMC/SD and I have no idea whether this is a problem with the
hardware, the software or the SD card (I tried two different SD cards.
Both work on my laptop with Linux 2.6.16 and a Winbond W83L51xD).

Any hints are highly appreciated.

Thanks,
Wolfgang
