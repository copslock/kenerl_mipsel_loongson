Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2005 14:37:55 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:27058 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225395AbVBXOhj>; Thu, 24 Feb 2005 14:37:39 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc11) with ESMTP
          id <2005022414372801100stlu3e>; Thu, 24 Feb 2005 14:37:29 +0000
Message-ID: <421DE686.6040003@gentoo.org>
Date:	Thu, 24 Feb 2005 09:36:54 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
References: <421BCF34.90308@jg555.com> <421BD616.4030101@avtrex.com> <Pine.LNX.4.61L.0502231300200.11922@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0502231300200.11922@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> 
>  The culprit is elsewhere.  The glibc's syscall number translator script 
> doesn't work with asm-mips/unistd.h as of Linux 2.6 (you could have 
> probably used 2.4 headers instead; I'm not sure if that is compatible with 
> "--enable-kernel=2.6.0", though).  A correct fix has been prepared and 
> proposed by Richard Sandiford and is available here: 
> "http://sourceware.org/ml/libc-alpha/2004-11/msg00097.html".  I would 
> expect this patch to have been applied before 2.3.4, but apparently this 
> hasn't happened.  That's regrettable and I fear it's the result of glibc 
> being somewhat inadequately maintained for MIPS/Linux these days, sigh...
> 
>  I'm not sure what the maintenance plan is for the 2.3 branch of glibc, 
> but if 2.3.5 is ever going to happen, the Richard's patch is one of the 
> must-have additions.
> 
>   Maciej

The debian patch I referenced is what we require for glibc to generate a 
proper syscalls.h for 2.4 kernels.  Unknown on the 2.6 kernel front how that 
patch affects things.  I'll have to see if this patch affects/changes anything 
for either headers version.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
