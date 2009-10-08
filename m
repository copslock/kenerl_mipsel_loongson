Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 12:36:27 +0200 (CEST)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60785 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492592AbZJHKgV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 12:36:21 +0200
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id 9A912F07C2; Thu,  8 Oct 2009 12:36:20 +0200 (CEST)
Date:	Thu, 8 Oct 2009 12:36:14 +0200
From:	Pavel Machek <pavel@ucw.cz>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
Message-ID: <20091008103614.GA27323@elf.ucw.cz>
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com> <20091008092903.GA27054@elf.ucw.cz> <1254998019.14496.21.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254998019.14496.21.camel@falcon>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Thu 2009-10-08 18:33:39, Wu Zhangjin wrote:
> Hi,
> 
> On Thu, 2009-10-08 at 11:29 +0200, Pavel Machek wrote:
> > On Thu 2009-10-08 16:57:32, Wu Zhangjin wrote:
> > > When CONFIG_FLAGMEM enabled, STD/Hiberation will fail on YeeLoong
> > > laptop, This patch fix it:
> > > 
> > > if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
> > > return TRUE, but in reality, if the memory is not continuous, it should
> > > be false. for example:
> > > 
> > > $ cat /proc/iomem | grep "System RAM"
> > > 00000000-0fffffff : System RAM
> > > 90000000-bfffffff : System RAM
> > > 
> > > as we can see, it is not continuous, so, some of the memory is not valid
> > > but regarded as valid by pfn_valid(), and at last make STD/Hibernate
> > > fail when shrinking a too large number of invalid memory.
> > > 
> > > Here, we fix it via checking pfn is in the "System RAM" or not, if yes,
> > > return TRUE.
> > 
> > "return FALSE"?
> > 
> > > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > Looks mostly ok, small comments below. 
> > 
> > > @@ -168,13 +168,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> > >  
> > >  #ifdef CONFIG_FLATMEM
> > >  
> > > -#define pfn_valid(pfn)							\
> > > -({									\
> > > -	unsigned long __pfn = (pfn);					\
> > > -	/* avoid <linux/bootmem.h> include hell */			\
> > > -	extern unsigned long min_low_pfn;				\
> > > -									\
> > > -	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> > > +#define pfn_valid(pfn)				\
> > > +({						\
> > > +	extern int is_pfn_valid(unsigned long); \
> > > +	is_pfn_valid(pfn);			\
> > >  })
> > 
> > "extern int pfn_valid here"
> > 
> > ...and get away without the ugly macro?
> > 
> 
> Perhaps need to move the whole "#ifdef CONFIG_FLATMEM" to #ifndef
> ASSEMBLY, otherwise,
> 
> "arch/mips/include/asm/page.h:170: Error: unrecognized opcode `extern
> int pfn_valid(unsigned long)'". 

I guess so. pfn_valid() will not work from assembly, anywa, so...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
