Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 04:42:28 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:39302 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20027700AbXBOEmW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2007 04:42:22 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1F4d5hB029303
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 20:39:05 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l1F4d3pD019904;
	Wed, 14 Feb 2007 20:39:04 -0800
Date:	Wed, 14 Feb 2007 20:39:03 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned
 implementations.
Message-Id: <20070214203903.8d013170.akpm@linux-foundation.org>
In-Reply-To: <20070214214226.GA17899@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org>
	<20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
	<20070214214226.GA17899@linux-mips.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Feb 2007 21:42:26 +0000 Ralf Baechle <ralf@linux-mips.org> wrote:

> Time for a little bit of dead horse flogging.
> 
> On Mon, Mar 06, 2006 at 05:05:52PM -0800, Andrew Morton wrote:
> 
> > > --- a/include/asm-generic/unaligned.h
> > > +++ b/include/asm-generic/unaligned.h
> > > @@ -78,7 +78,7 @@ static inline void __ustw(__u16 val, __u
> > >  
> > >  #define __get_unaligned(ptr, size) ({		\
> > >  	const void *__gu_p = ptr;		\
> > > -	__typeof__(*(ptr)) val;			\
> > > +	__u64 val;				\
> > >  	switch (size) {				\
> > >  	case 1:					\
> > >  		val = *(const __u8 *)__gu_p;	\
> > > @@ -95,7 +95,7 @@ static inline void __ustw(__u16 val, __u
> > >  	default:				\
> > >  		bad_unaligned_access_length();	\
> > >  	};					\
> > > -	val;					\
> > > +	(__typeof__(*(ptr)))val;		\
> > >  })
> > >  
> > >  #define __put_unaligned(val, ptr, size)		\
> > 
> > I worry about what impact that change might have on code generation. 
> > Hopefully none, if gcc is good enough.
> > 
> > But I cannot think of a better fix.
> 
> It does inflate the code but back then we agreed to go for Atsushi's patch
> because it was fairly obviously correct.  This patch obviously is less
> obvious but generates fairly decent, works for arbitrary data types and
> cuts down the size of unaligned.h from 122 lines to 44 so it must be good.
> 
> ...
>
> +#define get_unaligned(ptr)						\
> +({									\
> +	const struct {							\
> +		union {							\
> +			const int __un_foo[0];				\
> +			const __typeof__(*(ptr)) __un;			\
> +		} __un __attribute__ ((packed));			\
> +	} * const __gu_p = (void *) (ptr);				\
> +									\
> +	__gu_p->__un.__un;						\
>  })

Can someone please tell us how this magic works?  (And it does appear to
work).

It seems to assuming that the compiler will assume that members of packed
structures can have arbitrary alignment, even if that alignment is obvious.

Which makes sense, but I'd like to see chapter-and-verse from the spec or
from the gcc docs so we can rely upon it working on all architectures and
compilers from now until ever more.

IOW: your changlogging sucks ;)
