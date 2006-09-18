Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2006 18:06:17 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:45486 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20037833AbWIRRGL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2006 18:06:11 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 3A52546E1C; Mon, 18 Sep 2006 19:06:04 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GPMZD-0005Wx-AG; Mon, 18 Sep 2006 18:05:59 +0100
Date:	Mon, 18 Sep 2006 18:05:59 +0100
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel debugging contd.
Message-ID: <20060918170559.GD3924@networkno.de>
References: <66910A579C9312469A7DF9ADB54A8B7D390BF9@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D390BF9@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Kaz Kylheku wrote:
> Manoj Ekbote wrote:
> > If I may add, the changes made when the flush_icache_page call was
> > retired seems to cause this problem.
> > I reversed some of the changes and the kernel boots fine atleast on
> > 1480.
> > 
> > commit id : 4bbd62a93a1ab4b7d8a5b402b0c78ac265b35661
> 
> Speaking of the 1480, I'm still running a 2.6.17.7 kernel in which I
> patched back the old assembly-language IRQ handler. 
> 
> I can't boot our board with the IRQ handler rewritten in C.

Can you try if
http://people.debian.org/~ths/mips-kernels/vmlinux-bcm1480-6.32
works on your 1480? It works for me, but apparently fails on some
other boards.


Thiemo
