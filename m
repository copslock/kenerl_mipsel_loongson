Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 20:39:22 +0100 (CET)
Received: from kroah.org ([198.145.64.141]:39577 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1494077AbZKSTjQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Nov 2009 20:39:16 +0100
Received: from localhost (c-98-246-45-209.hsd1.or.comcast.net [98.246.45.209])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 852D348A9E;
	Thu, 19 Nov 2009 11:39:10 -0800 (PST)
Date:	Thu, 19 Nov 2009 11:38:31 -0800
From:	Greg KH <greg@kroah.com>
To:	Wu <wuzhangjin@gmail.com>
Cc:	Greg Kroah-Hartman <gregkh@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>, devel@driverdev.osuosl.org,
	linux-mips@linux-mips.org,
	Teddy Wang <teddy.wang@siliconmotion.com.cn>, huhb@lemote.com,
	yanh@lemote.com
Subject: Re: [PATCH -next] drivers/staging/sm7xx: add a new framebuffer
 driver
Message-ID: <20091119193831.GB29091@kroah.com>
References: <1257673141-1646-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257673141-1646-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Sun, Nov 08, 2009 at 05:39:01PM +0800, Wu wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Yeeloong(2f) netbook has a sm712 video card, need this driver, but it is
> not ready to upstream yet, so, go to drivers/staing at first.
> 
> This source code is originally from Silicon Motion Technology Corp, and
> maintained in http://dev.lemote.com/code/linux_loongson
> 
> Thanks Simon for testing it on a little-endian x86 platform.
> 
> Thanks Olivier Croset <olivier.croset@actis-computer.com> for reporting
> the problem about __BIG_ENDIAN compiling problem and send a relative
> patch.
> 
> The suspend/resume and blank support are contributed by Jason from
> Silicon Motion Technology.
> 
> (Hi, Ralf, Could you please merge it into your linux-mips? So, we can
>  get a complete lemote-2f support with the last patchset.)

Ralf, want to take this through your tree or mine?

I don't care either way.

thanks,

greg k-h
