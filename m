Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 06:53:53 +0200 (CEST)
Received: from [93.93.128.226] ([93.93.128.226]:41180 "EHLO
	bhuna.collabora.co.uk" rhost-flags-FAIL-FAIL-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492044AbZJIExq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 06:53:46 +0200
Received: from mycelium.queued.net (wireless.queued.net [66.92.71.179])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7D8ED600205;
	Fri,  9 Oct 2009 05:53:22 +0100 (BST)
Date:	Fri, 9 Oct 2009 00:53:18 -0400
From:	Andres Salomon <dilinger@collabora.co.uk>
To:	wuzhangjin@gmail.com
Cc:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, loongson-dev@googlegroups.com
Subject: Re: [PATCH] CS5535: Remove the X86 platform dependence of
 SND_CS5535AUDIO
Message-ID: <20091009005318.7174938c@mycelium.queued.net>
In-Reply-To: <1255060287.16819.1.camel@falcon>
References: <1255059842-12160-1-git-send-email-wuzhangjin@gmail.com>
	<1255060287.16819.1.camel@falcon>
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <dilinger@collabora.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dilinger@collabora.co.uk
Precedence: bulk
X-list: linux-mips

On Fri, 09 Oct 2009 11:51:27 +0800
Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> On Fri, 2009-10-09 at 11:44 +0800, Wu Zhangjin wrote:
> > There is no platform dependence of SND_CS5535AUDIO before 2.6.31,
> > Not sure who have touched this part, but SND_CS5535AUDIO is at least
> > available on Loongson family machines, so, Remove the platform
> > dependence directly.
> > 
> > Reported-by: rixed@happyleptic.org
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  sound/pci/Kconfig |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> > index fb5ee3c..75c602b 100644
> > --- a/sound/pci/Kconfig
> > +++ b/sound/pci/Kconfig
> > @@ -259,7 +259,6 @@ config SND_CS5530
> >  
> >  config SND_CS5535AUDIO
> >  	tristate "CS5535/CS5536 Audio"
> > -	depends on X86 && !X86_64
> 
> or use this?
> 
> 	depends on (X86 && !X86_64) || MIPS
> 
> Regards,
> 	Wu Zhangjin
> 


I'd say just remove the arch dependency (and make sure it builds and
doesn't obviously explode w/ x86-64). There's no need for it, afaict.
It's been there since at least 2005 (git commit 230b5c1a).
