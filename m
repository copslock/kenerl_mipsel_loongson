Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 02:05:14 +0100 (BST)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:58558 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225214AbUHEBFK>; Thu, 5 Aug 2004 02:05:10 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc11) with ESMTP
          id <20040805010503011000d9a5e>
          (Authid: kumba12345);
          Thu, 5 Aug 2004 01:05:03 +0000
Message-ID: <411188A8.9040607@gentoo.org>
Date: Wed, 04 Aug 2004 21:08:56 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
References: <20040804152936.D6269@mvista.com>
In-Reply-To: <20040804152936.D6269@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

> I am looking into porting NPTL to MIPS.  Just curious if
> anybody has tried this before.
> 
> I notice there was a discussion about the ABI extension
> for TLS (thread local storage) support.  Before that support
> becomes a reality it seems one can still use NPTL with 
> the help of additional system calls.
> 
> A rough search of latest glibc source shows there is
> zero MIPS code for nptl.  A couple of other arches
> are missing as well (such as ARM)
> 
> Jun

All I've heard about this is that some kernel changes are (still?) 
needed, then just the glibc support along w/ TLS (Maybe compiler support?).

I believe I heard reports that the glibc people were looking to 
deprecate linuxthreads within a another release or two (but don't know 
specifics or anything), so it sounds like NPTL should be something to 
get working.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
