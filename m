Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 10:50:45 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:42939 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8224953AbUHWJul>; Mon, 23 Aug 2004 10:50:41 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20040823095034014007mmove>
          (Authid: kumba12345);
          Mon, 23 Aug 2004 09:50:34 +0000
Message-ID: <4129BECB.7000508@gentoo.org>
Date: Mon, 23 Aug 2004 05:54:19 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20040820120223Z8225206-1530+8785@linux-mips.org> <Pine.LNX.4.58L.0408231124040.19572@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0408231124040.19572@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

> On Fri, 20 Aug 2004 ralf@linux-mips.org wrote:
> 
> 
>>Log message:
>>	Undo change from rev 1.37; some userspace software is expecting
>>	PAGE_SIZE, PAGE_SHIFT and PAGE_MASK to be accessible through
>>	<asm/page.h>.  Sigh ...
> 
> 
>  Fix that software then, instead of breaking good one (hint -- what is the
> "right" value of PAGE_SHIFT and why it doesn't work for that system over
> there?).  With these macros exported it's hard to guess whether the page
> size can be hardcoded or it should get determined at the run time.  And 
> with glibc you get a compilation error due to PAGE_SHIFT being undefined.  
> Please revert the braindamage.
> 
>  What software is the offender, BTW?
> 
>   Maciej

procps is probably the trigger of this.  Me and some other Gentoo/MIPS 
devs/users got into a bit of a heated discussion w/ the procps 
maintainer, who didn't quite like the fact that A) We don't use 
"sanitized" kernel headers B) PAGE_SIZE was hidden on MIPS and C) 
"properly sanitized" headers would provide PAGE_SIZE.  We opted instead 
for a patch to procps that used sysconf(_SC_PAGESIZE) to fetch the 
value, and I guess this just didn't rub the right way w/ the maintainer. 
  Got me.

I can post the discussions for those interested (or just looking for 
amusement), and anyone curious enough can look at proc/procps.h in the 
procps tree for a rather amusing (IMHO) comment on MIPS at the top of 
the source.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
