Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 23:54:49 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:4287 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S8133593AbWGMWyb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 23:54:31 +0100
Received: from [192.168.1.105] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 842F8E404D
	for <linux-mips@linux-mips.org>; Thu, 13 Jul 2006 16:07:47 -0700 (PDT)
Subject: BSP: for an AU1500 board.
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 13 Jul 2006 15:59:07 -0700
Message-Id: <1152831547.7681.14.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I m working with an AU-1500 MIPS processor on the EncoreM3 board and my
task is to write board support packages for the same.  I am very much a
newbie to linux and embedded systems.

I m not entirely sure of the sequence in which i should start doing
things, but here is a rough roadmap: 

1) To create a config file appropriate to the board using menuconfig
2) Map the VIA southbridge
3) Adding IRQ Mappings
4) Integration and Debugging

First I decided to 'do' the configuration file, but I still havent got a
birdseye picture of how I should proceed.  Any pointers?

Also, when does the config file come into play during the bootup
process, and where will I find the addresses of different devices say on
the PCI bus (memory adds) that will need to be mapped at boottime?

Thanks,
Ashlesha.
