Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 23:44:16 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.250]:18482 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20023328AbXIKWoB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 23:44:01 +0100
Received: by ag-out-0708.google.com with SMTP id 33so8610agc
        for <linux-mips@linux-mips.org>; Tue, 11 Sep 2007 15:43:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=MqHbI7VFs99b2MR2dJfh/LrqapYoqiATMe6BonYSCIU=;
        b=h9axZhbwpUsx84aevidJofBTTTBiJPAyYaGu+l6/I8z6NyGIgliWeGchXjp7baz8CHuzQ/GKy11yP0BOcPsAVVqTBZXNZm9JzXZQY99merQij8uHi/3N0tXxuD9j5eDNccGNQUfxA0NgHCsEOkvds612iHA2g3ydw6JnM60klaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GQrBFUccnNWvje9O6kKcqx1riIB2quU4Mr5rJc3hG3zzQpMW9VIMJAPC3pVNQONtu0ZbhM0L+hSI1+k0UTgN9QtPlgQF87iduWwOPGk2CKvvQpLd7QgaYqi1AZYeYQBAuwPgIYXWv1G3fCG7ipmEjC71c4iS13yS4XuEDJ04wRo=
Received: by 10.100.9.19 with SMTP id 19mr7320052ani.1189550622746;
        Tue, 11 Sep 2007 15:43:42 -0700 (PDT)
Received: from raver.cocorico ( [79.18.35.53])
        by mx.google.com with ESMTPS id h38sm11333418wxd.2007.09.11.15.43.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Sep 2007 15:43:41 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH][MIPS][1/7] AR7: core support
Date:	Wed, 12 Sep 2007 00:43:42 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070831.706792)
Cc:	linux-mips@linux-mips.org, florian@openwrt.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, nico@openwrt.org, ralf@linux-mips.org,
	openwrt-devel@lists.openwrt.org, akpm@linux-foundation.org
References: <200709080143.12345.technoboy85@gmail.com> <200709080218.50236.technoboy85@gmail.com> <20070909.024020.61508994.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070909.024020.61508994.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709120043.43452.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Saturday 08 September 2007 19:40:20 Atsushi Nemoto ha scritto:
> > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > index 6379003..75a46ba 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -1075,9 +1075,23 @@ void *set_except_vector(int n, void *addr)
> >  
> >  	exception_handlers[n] = handler;
> >  	if (n == 0 && cpu_has_divec) {
> > +#ifdef CONFIG_AR7
> > +		/* lui k0, 0x0000 */
> > +		*(volatile u32 *)(CAC_BASE+0x200) =
> > +				0x3c1a0000 | (handler >> 16);
> > +		/* ori k0, 0x0000 */
> > +		*(volatile u32 *)(CAC_BASE+0x204) =
> > +				0x375a0000 | (handler & 0xffff);
> > +		/* jr k0 */
> > +		*(volatile u32 *)(CAC_BASE+0x208) = 0x03400008;
> > +		/* nop */
> > +		*(volatile u32 *)(CAC_BASE+0x20C) = 0x00000000;
> > +		flush_icache_range(CAC_BASE+0x200, CAC_BASE+0x210);
> > +#else
> >  		*(volatile u32 *)(ebase + 0x200) = 0x08000000 |
> >  		                                 (0x03ffffff & (handler >> 2));
> >  		flush_icache_range(ebase + 0x200, ebase + 0x204);
> > +#endif
> >  	}
> >  	return (void *)old_handler;
> >  }
> 
> Runtime checking, something like this would be better than ifdef:
> 
> 	if ((handler ^ (ebase + 4)) & 0xfc000000)
> 		/* use jr */
> 		...
> 	} else {
> 		/* use j */
> 		...
> 	}
This will not make the code bigger? What's wrong with #ifdef?
