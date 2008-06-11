Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 19:54:24 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:2716 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20039520AbYFKSyW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 19:54:22 +0100
Received: by ug-out-1314.google.com with SMTP id 30so164372ugs.39
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2008 11:54:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=ywuunZExzVpom9xfe8qpV3W1kdM7gCA637PSAqoa9BQ=;
        b=nJueQ3pw3vRk3syPU1gLlTMQW1nupuvDk1aR1TtUaldE9rUMa3C21LSg0omlsc5J0g
         iYc4p/kLObnr1VGJe0xU94nU0c2c/VEZGpaDtBtPnggaqdaod9lhEaD1JihlXrVvgGFo
         75oxpsFiep4/xLCdeounVEi/pL2MbItrlq1no=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=V3HZbpgtCqlGaH3Uf10uI48WgJku3dIrCcRaC2g7JVcZV+w2IiZZDKvIMfP/dlkIrw
         z+SI0tafZO6rpj/nYYAOs4p9d3FYAm5V05EviWOzbELPg0kWb3FDEyEEp8gcvKQAB2KV
         eLA1zv7BwFXtknHUvQ5haI/aCovs2mrqQJnCQ=
Received: by 10.210.78.16 with SMTP id a16mr122963ebb.173.1213210460843;
        Wed, 11 Jun 2008 11:54:20 -0700 (PDT)
Received: from localhost ( [79.75.55.39])
        by mx.google.com with ESMTPS id m5sm404771gve.3.2008.06.11.11.54.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 11:54:19 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	Maxim Kuvyrkov <maxim@codesourcery.com>
Mail-Followup-To: Maxim Kuvyrkov <maxim@codesourcery.com>,"Maciej W. Rozycki" <macro@linux-mips.org>,  Ralf Baechle <ralf@linux-mips.org>,  gcc-patches@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: Changing the treatment of the MIPS HI and LO registers
References: <87tzgj4nh6.fsf@firetop.home>
	<Pine.LNX.4.55.0805272134540.18833@cliff.in.clinika.pl>
	<87abib4d9t.fsf@firetop.home>
	<Pine.LNX.4.55.0805272357020.18833@cliff.in.clinika.pl>
	<87r6bm1ebd.fsf@firetop.home>
	<Pine.LNX.4.55.0805290213140.29522@cliff.in.clinika.pl>
	<878wxtvarg.fsf@firetop.home> <8763stz2p3.fsf@firetop.home>
	<87zlpuxqfb.fsf@firetop.home> <48501C55.5060602@codesourcery.com>
Date:	Wed, 11 Jun 2008 19:54:17 +0100
In-Reply-To: <48501C55.5060602@codesourcery.com> (Maxim Kuvyrkov's message of
	"Wed\, 11 Jun 2008 22\:41\:25 +0400")
Message-ID: <87hcbzx0o6.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Maxim Kuvyrkov <maxim@codesourcery.com> writes:
> GLIBC contains the following code in stdlib/longlong.h:
> <snip>
> #if defined (__mips__) && W_TYPE_SIZE == 32
> #define umul_ppmm(w1, w0, u, v) \
>    __asm__ ("multu %2,%3"						\
> 	   : "=l" ((USItype) (w0)),					\
> 	     "=h" ((USItype) (w1))					\
> 	   : "d" ((USItype) (u)),					\
> 	     "d" ((USItype) (v)))
> #define UMUL_TIME 10
> #define UDIV_TIME 100
> #endif /* __mips__ */
> </snip>
>
> What would be a correct fix in this case?  Something like this:
> <snip>
> #define umul_ppmm(w1, w0, u, v)					\
>    ({unsigned int __attribute__((mode(DI))) __xx;		\
>      __xx = (unsigned int __attribute__((mode(DI)))) u * v;	\
>      w0 = __xx & ((1 << 32) - 1);				\
>      w1 = __xx >> 32;})
> </snip>
>
> Or is there a better way?

All being well, you should just be able to do the same as I did for
GCC's copy of longlong.h (included in the patch you responded to).

Richard
