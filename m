Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 16:43:53 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:65488 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20025315AbZC2Pnq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 16:43:46 +0100
Received: (qmail 24622 invoked from network); 29 Mar 2009 17:43:12 +0200
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 29 Mar 2009 17:43:12 +0200
Date:	Sun, 29 Mar 2009 17:43:47 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Alchemy: platform updates
Message-ID: <20090329174347.0ebccf00@scarran.roarinelk.net>
In-Reply-To: <49CF71BE.2070109@ru.mvista.com>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
	<49CF5CE6.1070003@ru.mvista.com>
	<20090329143802.0a09baca@scarran.roarinelk.net>
	<49CF71BE.2070109@ru.mvista.com>
Organization: Private
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Sergei,

On Sun, 29 Mar 2009 17:03:58 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Please elaborate.  Shall I check for a config symbol or if bootloader
> > has enabled the peripherals?  The latter is IMO stupid since the
> > bootloader should only load an OS and not preemptively enable every
> > device which might some day be used just because the running OS doesn't
> > know what it wants...
> >   
> 
>    It should check what the board code (or bootloader) has enabled. I 
> remember the board code writes some config registers...

I'd rather duplicate simple, known-working code than go around looking
whether some other part of the boards software system has set enable
bits. (Think of a linux bootloader akin to the simplicity of a QNX IPL
which doesn't enable anything but the debug port, if at all)

In short, consider these patches withdrawn.

Thanks!
	Manuel Lauss
