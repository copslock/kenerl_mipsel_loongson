Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 08:35:37 +0000 (GMT)
Received: from coyote.holtmann.net ([217.160.111.169]:27012 "EHLO
	mail.holtmann.net") by ftp.linux-mips.org with ESMTP
	id S20037889AbXBOIfc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 08:35:32 +0000
Received: from [192.168.5.242] (p5487F978.dip.t-dialin.net [84.135.249.120])
	by mail.holtmann.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l1F8agZ3009536;
	Thu, 15 Feb 2007 09:36:42 +0100
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned
	implementations.
From:	Marcel Holtmann <marcel@holtmann.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070214203903.8d013170.akpm@linux-foundation.org>
References: <20050830104056.GA4710@linux-mips.org>
	 <20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	 <20060306170552.0aab29c5.akpm@osdl.org>
	 <20070214214226.GA17899@linux-mips.org>
	 <20070214203903.8d013170.akpm@linux-foundation.org>
Content-Type: text/plain
Date:	Thu, 15 Feb 2007 09:35:16 +0100
Message-Id: <1171528516.28302.30.camel@violet>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.91 
Content-Transfer-Encoding: 7bit
Return-Path: <marcel@holtmann.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcel@holtmann.org
Precedence: bulk
X-list: linux-mips

Hi Andrew,

> > +#define get_unaligned(ptr)						\
> > +({									\
> > +	const struct {							\
> > +		union {							\
> > +			const int __un_foo[0];				\
> > +			const __typeof__(*(ptr)) __un;			\
> > +		} __un __attribute__ ((packed));			\
> > +	} * const __gu_p = (void *) (ptr);				\
> > +									\
> > +	__gu_p->__un.__un;						\
> >  })
> 
> Can someone please tell us how this magic works?  (And it does appear to
> work).
> 
> It seems to assuming that the compiler will assume that members of packed
> structures can have arbitrary alignment, even if that alignment is obvious.
> 
> Which makes sense, but I'd like to see chapter-and-verse from the spec or
> from the gcc docs so we can rely upon it working on all architectures and
> compilers from now until ever more.

I am far away from having any knowledge about the GCC internals and the
reason why this code works, but I've been told the generic way of
handling unaligned access is this:

#define get_unaligned(ptr)                      \
({                                              \
        struct __attribute__((packed)) {        \
                typeof(*(ptr)) __v;             \
        } *__p = (void *) (ptr);                \
        __p->__v;                               \
})

#define put_unaligned(val, ptr)                 \
do {                                            \
        struct __attribute__((packed)) {        \
                typeof(*(ptr)) __v;             \
        } *__p = (void *) (ptr);                \
        __p->__v = (val);                       \
} while(0)

Actually I am using this code in the Bluetooth userspace library for
over two years now without any complaints.

Regards

Marcel
