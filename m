Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 13:08:42 +0200 (CEST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:64996 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133864AbWERLIf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 May 2006 13:08:35 +0200
Received: from diimka-laptop.dev.rtsoft.ru ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k4IB8Us02919;
	Thu, 18 May 2006 16:08:30 +0500
Subject: Re: [PATCH] NEC EMMA2RH support
From:	dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060518195404.663eba86.yoichi_yuasa@tripeaks.co.jp>
References: <1147946423.8223.4.camel@diimka-laptop>
	 <20060518195404.663eba86.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=KOI8-R
Organization: montavista
Date:	Thu, 18 May 2006 15:08:28 +0400
Message-Id: <1147950509.8223.10.camel@diimka-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Return-Path: <dpervushin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpervushin@ru.mvista.com
Precedence: bulk
X-list: linux-mips

On Чтв, 2006-05-18 at 19:54 +0900, Yoichi Yuasa wrote:
> Hi,
> 
> On Thu, 18 May 2006 14:00:23 +0400
> dmitry pervushin <dpervushin@ru.mvista.com> wrote:
> 
> > Index: linux-malta/arch/mips/emma2rh/markeins/int-handler.S
> > ===================================================================
> > --- /dev/null
> > +++ linux-malta/arch/mips/emma2rh/markeins/int-handler.S
> 
> You should rewrite the assembler interrupt handler to C code.
Why ?? Could you please comment the statement ? May be, I have
misunderstood the modern ways in linux kernel development, but I am
pretty sure that assembler interrupt handler will be faster than C
code. 
> 
> > Index: linux-malta/arch/mips/emma2rh/markeins/setup.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-malta/arch/mips/emma2rh/markeins/setup.c
> > @@ -0,0 +1,208 @@
> 
> <snip>
> 
> > +}
> > +
> > +early_initcall(platform_setup);
> 
> early_initcall() already haven't existed.
> You should use plat_setup().
Hmm.. agreed. Thank you.
> 
> Yoichi
> 
> 
-- 
cheers, dmitry pervushin
