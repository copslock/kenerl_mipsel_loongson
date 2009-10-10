Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2009 16:32:38 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:34472 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492783AbZJJOcc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2009 16:32:32 +0200
Received: by pxi17 with SMTP id 17so9428033pxi.21
        for <linux-mips@linux-mips.org>; Sat, 10 Oct 2009 07:32:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=93dP0Tuu8zs3P+GId/aNJrlozWcEwpCaWvbtGSztSgc=;
        b=MOU4tRWtfhftKPVaaWZ/Cm1gCSQsVMLiv/VJrzivBRpCHIskJ+ZIIM9mkc9uaxSWdc
         FR2XjKcxQzITNOOplgHEYOIMNuAfyvmOig38M4qSBlxetVtsMxYBd+5mLHl8v0vPSLnL
         ma5jH7ShhphdAWydTbz0+W1a3tRM/jQNKsaTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=U1kwPVA7HqJow1qjgdwXWL1vPithpB1VjmrBGTZQgjgzBhEL8N2GGlyutK4pLRo/C5
         nM4c+p+e8PKfKZ5qXd+NHggEwcr74qtfZeF+tk2MBFI9QA5JFrVsQFbUVkk7Up9MDNiI
         7FvlKzEvCsahiGpSkY4YHdk7Ih+slzBTB/Z9w=
Received: by 10.114.162.20 with SMTP id k20mr5485345wae.135.1255185142312;
        Sat, 10 Oct 2009 07:32:22 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm234220pxi.8.2009.10.10.07.32.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 07:32:21 -0700 (PDT)
Subject: Re: [PATCH] CS5535: Remove the X86 platform dependence of
 SND_CS5535AUDIO
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Andres Salomon <dilinger@collabora.co.uk>
Cc:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, loongson-dev@googlegroups.com
In-Reply-To: <20091009005318.7174938c@mycelium.queued.net>
References: <1255059842-12160-1-git-send-email-wuzhangjin@gmail.com>
	 <1255060287.16819.1.camel@falcon>
	 <20091009005318.7174938c@mycelium.queued.net>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 10 Oct 2009 22:32:14 +0800
Message-Id: <1255185134.6883.20.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

On Fri, 2009-10-09 at 00:53 -0400, Andres Salomon wrote:
> On Fri, 09 Oct 2009 11:51:27 +0800
> Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> 
> > On Fri, 2009-10-09 at 11:44 +0800, Wu Zhangjin wrote:
> > > There is no platform dependence of SND_CS5535AUDIO before 2.6.31,
> > > Not sure who have touched this part, but SND_CS5535AUDIO is at least
> > > available on Loongson family machines, so, Remove the platform
> > > dependence directly.
> > > 
> > > Reported-by: rixed@happyleptic.org
> > > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > > ---
> > >  sound/pci/Kconfig |    1 -
> > >  1 files changed, 0 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> > > index fb5ee3c..75c602b 100644
> > > --- a/sound/pci/Kconfig
> > > +++ b/sound/pci/Kconfig
> > > @@ -259,7 +259,6 @@ config SND_CS5530
> > >  
> > >  config SND_CS5535AUDIO
> > >  	tristate "CS5535/CS5536 Audio"
> > > -	depends on X86 && !X86_64
> > 
> > or use this?
> > 
> > 	depends on (X86 && !X86_64) || MIPS
> > 
> > Regards,
> > 	Wu Zhangjin
> > 
> 
> 
> I'd say just remove the arch dependency (and make sure it builds and
> doesn't obviously explode w/ x86-64). There's no need for it, afaict.
> It's been there since at least 2005 (git commit 230b5c1a).
> 

Just checked the SND_CS5536AUDIO(=y and =m) option with ARCH=x86_64, no
compiling warnings & errors, but I don't have such a chip in a x86-64
machine, so, did not test the kernel yet.

Regards,
	Wu Zhangjin
