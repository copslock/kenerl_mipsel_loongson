Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Mar 2010 18:21:11 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:53194 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492039Ab0C0RVI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Mar 2010 18:21:08 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2181)
        id 5AA1E1B4014; Sat, 27 Mar 2010 17:20:59 +0000 (UTC)
Date:   Sat, 27 Mar 2010 17:20:59 +0000
From:   Zhang Le <r0bertz@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        zhangfx@lemote.com
Subject: Re: [PATCH v3 2/3] Loongson-2F: Enable fixups of binutils 2.20.1
Message-ID: <20100327172059.GC19154@woodpecker.gentoo.org>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        zhangfx@lemote.com
References: <cover.1268453720.git.wuzhangjin@gmail.com> <ecc51ee134ab84c95b6b02534544df3731bb9562.1268453720.git.wuzhangjin@gmail.com> <20100317135223.GA4554@linux-mips.org> <20100327162900.GA19154@woodpecker.gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100327162900.GA19154@woodpecker.gentoo.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 16:29 Sat 27 Mar     , Zhang Le wrote:
> On 14:52 Wed 17 Mar     , Ralf Baechle wrote:
> > On Sat, Mar 13, 2010 at 12:34:16PM +0800, Wu Zhangjin wrote:
> > 
> > > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > > index 2f2eac2..5ae342e 100644
> > > --- a/arch/mips/Makefile
> > > +++ b/arch/mips/Makefile
> > > @@ -135,7 +135,9 @@ cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
> > >  cflags-$(CONFIG_CPU_LOONGSON2E) += \
> > >  	$(call cc-option,-march=loongson2e,-march=r4600)
> > >  cflags-$(CONFIG_CPU_LOONGSON2F) += \
> > > -	$(call cc-option,-march=loongson2f,-march=r4600)
> > > +	$(call cc-option,-march=loongson2f,-march=r4600) \
> > > +	$(call as-option,-Wa$(comma)-mfix-loongson2f-nop,) \
> > > +	$(call as-option,-Wa$(comma)-mfix-loongson2f-jump,)
> > 
> > Shouldn't these options be used unconditionally?  It seems a kernel build
> > should rather fail than a possibly unreliable kernel be built - possibly
> > even without the user noticing the problem.
> 
> Zhangjin has been busy preparing for his graduation paper.
> I just talked to him. He said later batches of 2F processor is not affected by
> these two problems, according to Zhang Fuxin, manager of Lemote.
> 
> I am not sure on which model of Fuloong and Yeeloong these "good" 2F processors
> have been used. I think Fuxin should know this.
> 
> If Fuxin could told us now, we can make a new patch. In this patch, we decide
> whether to add these options or not base on the model number.
> 
> Otherwise, for now, I think we should enable these options unconditionally.

Sorry, I got Zhang Fuxin's email wrong. Now fixed.

Zhang, Le
