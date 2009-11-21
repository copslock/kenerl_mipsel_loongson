Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 15:58:10 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:54610 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492779AbZKUO6C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Nov 2009 15:58:02 +0100
Received: from relay1.suse.de (mail2.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id 5204B86A2E;
	Sat, 21 Nov 2009 15:58:00 +0100 (CET)
Date:	Sat, 21 Nov 2009 06:47:41 -0800
From:	Greg KH <gregkh@suse.de>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, devel@driverdev.osuosl.org,
	Teddy Wang <teddy.wang@siliconmotion.com.cn>,
	linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com
Subject: Re: [PATCH v1] drivers/staging/sm7xx: add a new framebuffer driver
Message-ID: <20091121144741.GA27712@suse.de>
References: <d4c54841c8a77dabd8af854d0839f1c1c549bdee.1258805519.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c54841c8a77dabd8af854d0839f1c1c549bdee.1258805519.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Sat, Nov 21, 2009 at 08:19:59PM +0800, Wu Zhangjin wrote:
> (Hi, Ralf or greg k-h, This driver is the last necessary driver for the 2.6.33
>  support to the YeeLoong2F netbook, Could you please queue it for 2.6.33? And
>  BTW: Teddy in the CC list is from Silicon Motion Techonology Corp, We will
>  work together to make this driver stable and clean enough for upstream.)

I'll be glad to take this through my staging tree to Linus for .33, but
I also need a "TODO" file in the directory that states what is left to
be done on the driver in order to get it merged into the proper place in
the kernel, and a list of who to send patches to for these things.

thanks,

greg k-h
