Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 10:38:27 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:56316 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225309AbUA2Ki1>; Thu, 29 Jan 2004 10:38:27 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc12) with SMTP
          id <20040129103821012002d3h6e>
          (Authid: kumba12345);
          Thu, 29 Jan 2004 10:38:21 +0000
Message-ID: <4018E322.9030801@gentoo.org>
Date: Thu, 29 Jan 2004 05:40:34 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: linux 2.4 and Indy
References: <20040129102215.GC17760@ballina>
In-Reply-To: <20040129102215.GC17760@ballina>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jorik Jonker wrote:
> Hi,
> 
> I'm having big trouble getting linux 2.4.* to work on my SGI Indy. I want to
> use my indycam, and thus compile a kernel with support for that. The problem
> is that all the kernels I built do boot, but freeze some moments after
> starting the init process. The only kernels that do not have this problem are 
> 2.4.16 and 2.4.17, but they do not have proper VINO support (they lack the
> i2c algo-sgi part).
> Is there some patch flying around to fix this, or do I just have bad luck?

Check out a cvs tree no later than 12/11/2003, a change in CVS after 
that date seems to have nuked r4k kernels.  It is believed the change in 
question is:

http://www.linux-mips.org/archives/linux-cvs/2003-12/msg00031.html

I've not yet been able to find a 'clean' way to remove the changes to 
those specific files in that commit while keeping all the changes made 
afterwards intact to test this idea.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
