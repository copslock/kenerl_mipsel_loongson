Received:  by oss.sgi.com id <S553916AbRAYBiU>;
	Wed, 24 Jan 2001 17:38:20 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:5118 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553966AbRAYBiL>;
	Wed, 24 Jan 2001 17:38:11 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0P1Z6I18189;
	Wed, 24 Jan 2001 17:35:06 -0800
Message-ID: <3A6F835B.72A293A5@mvista.com>
Date:   Wed, 24 Jan 2001 17:37:31 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Pete Popov <ppopov@mvista.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
References: <3A6E132B.9000103@Lineo.COM> <3A6E1977.2B18484D@mvista.com> <3A6F36B8.4F10759B@mvista.com> <20010124163101.F863@bacchus.dhis.org> <3A6F7CB8.322668CF@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Pete Popov wrote:
> 
> Ralf Baechle wrote:
> >
> > On Wed, Jan 24, 2001 at 12:10:32PM -0800, Jun Sun wrote:
> >
> > > It is really surprising to know this.  It sounds like a CPU bug to me.  Can
> > > some MIPS "gods" clarify if such a behaviour is a bug or allowed?
> > >
> > > BTW, the CPU in EV96100 is QED RM7000, I believe.
> >
> > If you want to be strictly correct you have to execute the code that
> > disables caching of KSEG0 in uncached space like KSEG1, then flush the
> > caches before you can resume execution in KSEG0.  Otherwise you might
> > end up with dirty d-caches which when flushed will overwrite more
> > uptodate data in memory.  The window is very small but yet exists if
> > things are just right.
> 
> The EV96100 running Galileo's pmon exhibits exactly this symptom.  Pmon
> apparently sets up kseg0 to cache coherency 3;  but eventhough the
> kernel also sets it to 3, if I don't flush the caches first I end up
> with overwritten data.  A different version of pmon that I have sets
> kseg0 to 1 (writethrough). Changing that to 3 isn't a problem -- or at
> least it doesn't seem to cause any problems.
> 

I don't think it is the same problem.

Here is the simplified view of the process, if I understand Pete correctly:

1. pmon sets kseg0 to 3 (cache enabled)
2. kernel starts in KSEG0 
3. kernel sets kseg0 to 3 again (essentially keeps the same config value)
4. kernel flushes cache
  ===> Q: data corruption or not?

I think the data should be consistent.  Otherwise it looks like a CPU bug to
me.

What ralf described is something like the following:

1. pmon sets kseg0 to 3 (KSEG0 cache enabled)
2. kernel starts in KSEG0 
3. kernel sets kseg0 to 2 (disable kseg0 cache)
4. kernel flushes cache
  ===> Q: data corruption or not?  YES, data can be corrupted!

Jun
