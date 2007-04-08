Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 14:56:05 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:47295 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022685AbXDHN4D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2007 14:56:03 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HaXp7-0007RO-00; Sun, 08 Apr 2007 15:52:53 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 0156AC223B; Sun,  8 Apr 2007 15:52:44 +0200 (CEST)
Date:	Sun, 8 Apr 2007 15:52:44 +0200
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
Message-ID: <20070408135244.GA8016@alpha.franken.de>
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com> <20070408131228.GA7819@alpha.franken.de> <4618ED95.6040304@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4618ED95.6040304@ru.mvista.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Apr 08, 2007 at 05:26:45PM +0400, Sergei Shtylyov wrote:
>    If you read the comment to insert_resource() you'll see that it works 
> contrarywise, i. e. the inserted resource is made parent of the conflicting 
> ones. I.e. it should't work as you're intending it to.

why don't you think I haven't testet this ?

00000000-03bfffff : PCIT IO
  00000000-0000001f : dma1
  00000020-00000021 : pic1
  00000040-0000005f : timer
  00000060-0000006f : keyboard
  00000080-0000008f : dma page reg
  000000a0-000000a1 : pic2
  000000c0-000000df : dma2
  000002f8-000002ff : serial
  000003c0-000003df : cirrusfb
  000003f8-000003ff : serial
  00000c80-00000c83 : EISA device @@@0000
  00000cf8-00000cfb : PCI config addr
  00000cfc-00000cff : PCI config data
  00001000-000010ff : Madge Smart 16/4 EISA Ringnode
  00001400-000014ff : Madge Smart 16/4 EISA Ringnode
  00001800-000018ff : Madge Smart 16/4 EISA Ringnode
  00001c00-00001cff : Madge Smart 16/4 EISA Ringnode

that's exactly what I wrote.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
