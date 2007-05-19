Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 20:01:49 +0100 (BST)
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:45448 "EHLO
	rwcrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20024074AbXESTBr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 20:01:47 +0100
Received: from [192.168.1.4] (c-76-106-119-205.hsd1.md.comcast.net[76.106.119.205])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20070519190134m13007ui6oe>; Sat, 19 May 2007 19:01:40 +0000
Message-ID: <464F498D.4070205@gentoo.org>
Date:	Sat, 19 May 2007 15:01:33 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	post@pfrst.de
CC:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: R1000 status
References: <49027.193.253.35.188.1179557496.squirrel@eppesuigoccas.homedns.org> <Pine.LNX.4.58.0705190928580.182@Indigo2.Peter>
In-Reply-To: <Pine.LNX.4.58.0705190928580.182@Indigo2.Peter>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

peter fuerst wrote:
> 
> Hello,
> 
> yes, the GCC-patches should do the trick. And without a significant
> performance decrease, as i was told in the latest success-report (see
> http://sgi.sedlacek.biz/).
> 
> kind regards

Interesting, I'm curious to see this guy's patches to see what he does different 
for the IP32 R10K stuff.  Whether it's the same thing I did (mod IP28 patches 
and build w/ gcc cache barriers on load and store ops), or if he went an extra 
step and added code to protect the scsi and networking drivers.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
