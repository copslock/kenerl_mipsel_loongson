Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 20:01:02 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:62878 "EHLO
	rwcrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20024072AbXESTBB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 20:01:01 +0100
Received: from [192.168.1.4] (c-76-106-119-205.hsd1.md.comcast.net[76.106.119.205])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20070519190016m1100rhvrqe>; Sat, 19 May 2007 19:00:17 +0000
Message-ID: <464F493F.7090405@gentoo.org>
Date:	Sat, 19 May 2007 15:00:15 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
CC:	linux-mips@linux-mips.org
Subject: Re: R1000 status
References: <49027.193.253.35.188.1179557496.squirrel@eppesuigoccas.homedns.org>
In-Reply-To: <49027.193.253.35.188.1179557496.squirrel@eppesuigoccas.homedns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Giuseppe Sacco wrote:
> Hi all,
> reading many web pages I think to understand that R10000 is supported on
> IP22 systems and is unsupported on IP32 systems because of its cache.
> 
> The page http://www.linux-mips.org/wiki/Silicon_Graphics display a
> different result: R10000 on SIGG O2 is supported.
> 
> Is there any news or a list of known problems?

R10000 on IP22 actually refers to the IP28 system, Indigo2 R10000 Impact.  And 
it does work if you use the latest patches, but YMMV.

R10000 on IP32 is a different story.  I used to maintain a patch that was 
essentially the IP28 patch minus IP28-specific bits to the kernel, and built 
with an R10K-equipped gcc toolchain, produced a kernel that would run for a 
decent amount of time, however, using the scsi disk or the network module could 
lock the machine up.  You also got a gazillion CRIME CPU errors on the main console.

I'll have to rebuild the patch again and see how it handles nowadays, but I 
believe that, regardless, enhancements need to be made to aic7xxx to protect 
against the non-cache cohenecy of the machine, and something equivalent to the 
meth module (network) as well.  That, or someone implements the "Juice" 
capability of the system.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
