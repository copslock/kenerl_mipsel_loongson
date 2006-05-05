Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 11:39:26 +0100 (BST)
Received: from bes.recconet.de ([212.227.59.164]:41697 "EHLO bes.recconet.de")
	by ftp.linux-mips.org with ESMTP id S8133404AbWEEKjQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2006 11:39:16 +0100
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bes.recconet.de (8.13.1/8.13.1/Recconet-2005031001) with ESMTP id k45AdCIS029748;
	Fri, 5 May 2006 12:39:13 +0200
Received: from seneca.recco.de (seneca.recco.de [172.16.135.97])
	by trinity.recco.de (8.13.1/8.13.1/Reccoware-2005061101) with ESMTP id k45AcJin007094;
	Fri, 5 May 2006 12:38:19 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by seneca.recco.de (8.13.6/8.13.4/Seneca.Reccoware-2005061801) with ESMTP id k45AdCr0002720;
	Fri, 5 May 2006 12:39:12 +0200
Subject: Re: Au1200 MMC/SD problem
From:	Wolfgang Ocker <weo@reccoware.de>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060503145927.GD24185@cosmic.amd.com>
References: <1146548770.1597.43.camel@seneca.recco.de>
	 <20060502144314.GI22167@cosmic.amd.com>
	 <1146592926.11188.12.camel@seneca.recco.de>
	 <20060503145927.GD24185@cosmic.amd.com>
Content-Type: text/plain
Organization: Reccoware Systems
Date:	Fri, 05 May 2006 12:39:11 +0200
Message-Id: <1146825551.15761.8.camel@seneca.recco.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Return-Path: <weo@reccoware.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weo@reccoware.de
Precedence: bulk
X-list: linux-mips

On Wed, 2006-05-03 at 08:59 -0600, Jordan Crouse wrote:
> > The last one. In au1xmmc_irq() the status register is read with the
> > SD_STATUS_RAT bit set.
> 
> Ok - so the card is timing out.  That could be a series of problems, some
> of which could be hardware, some of which could be software.  Since you are
> using a db1200, I'll rule out hardware for the moment, unless you have a
> modified board.

Today I tested a third SD card from SanDisk, 128MB, same problem and log
output (time out in command 9).

> Do MMC cards work?  Try one - that will give us another data point.

Today I received a SanDisk 64 MB MMC card, it doesn't work either. Here
the log output:

au1xx(0): DEBUG: set_ios (power=0, clock=0Hz, vdd=0, mode=1)
au1xxx-mmc: MMC Controller 0 set up at B0600000 (mode=dma)
au1xx(0): DEBUG: set_ios (power=1, clock=0Hz, vdd=23, mode=1)
au1xx(0): DEBUG: set_ios (power=2, clock=450000Hz, vdd=23, mode=1)
au1xx(0): DEBUG: set_ios (power=2, clock=450000Hz, vdd=23, mode=1)
MMC: starting cmd 00 arg 00000000 flags 00000040
MMC: req done (00): 0: 00000000 00000000 00000000 00000000
au1xx(0): DEBUG: set_ios (power=2, clock=450000Hz, vdd=23, mode=1)
MMC: starting cmd 37 arg 00000000 flags 00000015
au1xx(0): DEBUG: au1xmmc_irq(), SD_STATUS_RAT set
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 37 arg 00000000 flags 00000015
au1xx(0): DEBUG: au1xmmc_irq(), SD_STATUS_RAT set
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 37 arg 00000000 flags 00000015
au1xx(0): DEBUG: au1xmmc_irq(), SD_STATUS_RAT set
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 37 arg 00000000 flags 00000015
au1xx(0): DEBUG: au1xmmc_irq(), SD_STATUS_RAT set
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: mmc_setup(), send_app_op_cond, ocr = 1000fc00, err = 1
MMC: mmc_setup(), no SD card found (1)
MMC: starting cmd 01 arg 00000000 flags 00000061
au1xx(0): DEBUG: au1xmmc_irq(), SD_STATUS_RAT set
MMC: req done (01): 1: 00000000 00000000 00000000 00000000
MMC: mmc_rescan(): no card found!
au1xx(0): DEBUG: set_ios (power=0, clock=0Hz, vdd=0, mode=1)


Thanks,
Wolfgang
