Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 08:26:53 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.116]:30450 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225073AbTEIH0v>; Fri, 9 May 2003 08:26:51 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout01.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb 13 2003))
 with ESMTP id <0HEL00MDGZBX1R@mtaout01.icomcast.net> for
 linux-mips@linux-mips.org; Fri, 09 May 2003 03:26:21 -0400 (EDT)
Date: Fri, 09 May 2003 03:29:10 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: Problem of cross-mipsel-compiler GLIBC-2.3.X
In-reply-to: <1052464867.2485.3.camel@ghostwheel.sfbay.redhat.com>
To: linux-mips@linux-mips.org
Reply-to: kumba@gentoo.org
Message-id: <3EBB58C6.3070604@gentoo.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
References: <3EB0B329.9030603@ict.ac.cn>
 <16048.55936.346808.522687@cuddles.redhat.com> <3EB0DDC6.5080108@ict.ac.cn>
 <16048.57054.224964.883062@cuddles.redhat.com>
 <20030501085018.GA1885@greglaptop.attbi.com>
 <000a01c315cf$8171ac70$d017a8c0@pc208>
 <1052464867.2485.3.camel@ghostwheel.sfbay.redhat.com>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Oddly enough, I followed these basic steps and wound up with a working 
cross-compiler from sparc64 -> mipseb (Sun Blade 100 to mips 
big-endian).  Gcc nor glibc gave me any issues.....However, when I tried 
the same exact steps on i686, glibc complained about libgcc not being 
available, among other things.  It's got me baffled, but I'm not exactly 
complaining.  Currently, it's gcc-3.2.3 (propolice patched) + 
glibc-2.3.2 + binutils-2.13.90.0.20, which it'll get rebuilt for the new 
binutils 2.14.

--Kumba



Eric Christopher wrote:
> On Thu, 2003-05-08 at 19:05, smills_ho wrote:
> 
>>Dear All,
>>    I want to make a cross-compilered glibc-2.3.x and I get the source from
>>ftp.gun.org. GCC version is 3.2.3, binutils is 2.13.2.1. The step is as
>>following:
>>
>>1. Try to build binutils
>>2. Try to make static GCC
>>3. Try to make glibc -----> Then it is failed
>>
>>Is there anybody know what's going on or somebody had successfully to build
>>the crossed glibc-2.3.x?
> 
> 
> A host cross host compiler for linux systems is a little more involved
> than this :)
> 
> However, I don't know where you went wrong since you really didn't
> provide much in the way of information as to what you did or where it
> failed.
> 
> -eric
> 
