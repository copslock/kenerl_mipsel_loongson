Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 02:39:51 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:63784 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494107AbZKEBjo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 02:39:44 +0100
Received: by pzk32 with SMTP id 32so5261508pzk.21
        for <multiple recipients>; Wed, 04 Nov 2009 17:39:36 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=wvSmpEiaTIreMjbEUwm7NUZlRX1dZ5Jh7xnbvgHcoaM=;
        b=SHblNLUXXyQfFmFXvBycpwAXbReJQOvLVa3JyRrL2jhrClasq7bEhzfmOKXFKQmzdV
         BpvJwo7drDzCmRyErb6USqpwljvOxE0k5mgePSAAUGmylbEd/PCyDyKwCC55HHeOzV3q
         7X+eh98d+Il3EZJbZwK5URqS4e4Y9RKsVVnQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=rxiAZKtTD6LxFrsjtCifOuAOsT4SXlRvrVoFzpAr0NPbTgHe5L4MLWThEdHd8gy7WD
         NhCi//8v36UVOP5qQRP2j8hxUMvw/+B90IL4qNrcHCH8qQtLcT+DywKILO4nv2smUUwk
         g4AP7FTW/xWDI4u+/lLIblUWfMgIShp9Xw+Ws=
Received: by 10.114.7.9 with SMTP id 9mr3599056wag.71.1257385175839;
        Wed, 04 Nov 2009 17:39:35 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm913353pzk.5.2009.11.04.17.39.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 17:39:35 -0800 (PST)
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <20091104201520.GA26504@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com>
	 <m3iqdqtwgk.fsf@anduin.mandriva.com>
	 <1257332652.8716.5.camel@falcon.domain.org>
	 <20091104111957.GA13549@linux-mips.org>
	 <1257348226.16033.4.camel@falcon.domain.org>
	 <20091104201520.GA26504@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Thu, 05 Nov 2009 09:39:36 +0800
Message-ID: <1257385176.16033.17.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-04 at 21:15 +0100, Ralf Baechle wrote:
> On Wed, Nov 04, 2009 at 11:23:46PM +0800, Wu Zhangjin wrote:
> 
> > > We have other systems where 32-bit kernel support is just remarkably ugly.
> > > We've dropped 32-bit support for the SGI IP32 aka O2 - nobody seems to even
> > > have really noticed that.  The Sibyte systems would be good candidates to do
> > > the same as accesses to outside the 32-bit address space are needed very
> > > frequently.
> > > 
> > 
> > So, we really remove the 32bit support?
> > 
> > 1312 config CPU_LOONGSON2
> > 1313         bool
> > 1314         select CPU_SUPPORTS_32BIT_KERNEL  --> remove it?
> > 1315         select CPU_SUPPORTS_64BIT_KERNEL
> > 1316         select CPU_SUPPORTS_HIGHMEM
> > 
> > If you all agree, I will send a new patch to remove the above line and
> > resend the corresponding patches without 32bit support, and removed the
> > relative CONFIG_64BIT lines in the patches too.
> 
> If you need highmem with 32-bit (and with Loongson systems I assume that
> virtually all systems will have enough RAM to require that) then you're
> almost certainly better off going 64-bit.  Highmem takes a performance toll
> which for some workloads can be very significant.  And while highmem won't
> go away any time soon it's nothing kernel performance is being tuned for,
> so it's only going to get worse into the future so I'd not waste time on
> highmem unless I have to.
> 

What I have mentioned: "perhaps some guys need the 32bit version" here
means, perhaps some embedded systems without enough memory and enough
storage space may need the 32bit version, they not need highmem and
also, the 32bit version will save some storage space for them. and I
have used the 32bit version on my box and notebook(of course, only for
experiments), no obvious problems.

Reserve the 32bit version as an choice and select 64bit by default in
the default config file?

Regards,
	Wu Zhangjin
