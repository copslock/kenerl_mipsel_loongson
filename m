Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 00:22:09 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:46836 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225272AbUAOAWI>;
	Thu, 15 Jan 2004 00:22:08 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i0F0M6kp025134;
	Wed, 14 Jan 2004 16:22:06 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i0F0M19u016727;
	Wed, 14 Jan 2004 16:22:01 -0800 (PST)
Date: Wed, 14 Jan 2004 16:22:01 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: Jun Sun <jsun@mvista.com>
cc: Daniel Jacobowitz <dan@debian.org>, <linux-mips@linux-mips.org>
Subject: Re: ptrace induced instruction cache bug?
In-Reply-To: <20040114160729.D13471@mvista.com>
Message-ID: <Pine.LNX.4.44.0401141619110.1969-100000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

> There are too many things related to cache are wrong in 2.4.17.  For
> example,
> 
> . flush_page_indexed() is not right for multi-way cache
> . when you map user pages into kernel, you are sufferring potential cache
>   aliasing problem (BTW, we still suffer from this right now to a less degree)
> . flush_page_to_ram() has a broken semantic, because it is not clear whether
>   the area mapped into user virt spaces should be flushed or not
> ...
> 
> In short, it is not worth your time to fix old bugs.  Last time I
> checked malta was working fine around 2.4.21.  It shouldn't be too hard
> to get it working again in the latest 2.4 branch.
	Is this the 2.4.21 from ftp.kernel.org, or do I need to get 
specific patches to get it to work? I looked at the cvs tree but it's 
currently a 2.6 release. Should I just check out the linux_2_4_branch 
version from linux-mips.org?

	nathan

-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)
