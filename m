Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 08:27:10 +0100 (WEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43538 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021820AbZFBH1E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2009 08:27:04 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n527QlcZ004940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2009 00:26:48 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n527QlTb004598;
	Tue, 2 Jun 2009 00:26:47 -0700
Date:	Tue, 2 Jun 2009 00:26:16 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/9] kernel: export sound/core/pcm_timer.c gcd
 implementation
Message-Id: <20090602002616.d5707d6b.akpm@linux-foundation.org>
In-Reply-To: <200906020919.25162.florian@openwrt.org>
References: <200906011357.09966.florian@openwrt.org>
	<20090601215034.7352ddca.akpm@linux-foundation.org>
	<200906020919.25162.florian@openwrt.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 2 Jun 2009 09:19:22 +0200 Florian Fainelli <florian@openwrt.org> wrote:

> Le Tuesday 02 June 2009 06:50:34 Andrew Morton, vous avez __crit__:
> > On Mon, 1 Jun 2009 13:57:09 +0200 Florian Fainelli <florian@openwrt.org> 
> wrote:
> > > This patch exports the gcd implementation from
> > > sound/core/pcm_timer.c into include/linux/kernel.h.
> > > AR7 uses it in its clock routines.
> > >
> > > ...
> > >
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > index 883cd44..878a27a 100644
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -147,6 +147,22 @@ extern int _cond_resched(void);
> > >  		(__x < 0) ? -__x : __x;		\
> > >  	})
> > >
> > > +/* Greatest common divisor */
> > > +static inline unsigned long gcd(unsigned long a, unsigned long b)
> > > +{
> > > +        unsigned long r;
> > > +        if (a < b) {
> > > +                r = a;
> > > +                a = b;
> > > +                b = r;
> > > +        }
> > > +        while ((r = a % b) != 0) {
> > > +                a = b;
> > > +                b = r;
> > > +        }
> > > +        return b;
> > > +}
> >
> > a) the name's a bit sucky.   Is there some convention for this name?
> 
> We might want something better like greatest_common_divisor which is a bit 
> more self-explanatory ?

Well, if gcd() is a commonly used name then let's use that.  I don't
personally recall seeing it used but that doesn't mean much.

> >
> > b) It looks too large to be inlined.  lib/gdc.c?
> 
> And its users select it in order not to increase the size of kernel.h, sounds 
> good.
> 
> >
> > b) there's an implementation of gcd() in
> >    net/netfilter/ipvs/ip_vs_wrr.c.  I expect that this patch broke the
> >    build.
> 
> I did forget about this. That gcd implementation only treats the a > b case.
> 
> What do you prefer, each user keeps its gcd implementation locally or we make 
> a lib/gcd.c for it ?

I think lib/gcd.c would be better.  Then migrate current code over to
use that.

The problem with offering a generic version is types: will it work
correctly and sensibly for all combinations of signed/unsigned
char/short/int/long/longlong?  All but the last, I expect.  In which
case that'll be good enough for now.
