Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 22:29:40 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:34226 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225388AbTLIW3j>; Tue, 9 Dec 2003 22:29:39 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc13) with SMTP
          id <2003120922293201500boimge>
          (Authid: kumba12345);
          Tue, 9 Dec 2003 22:29:32 +0000
Message-ID: <3FD64CE1.8030907@gentoo.org>
Date: Tue, 09 Dec 2003 17:29:53 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
References: <ML-3.4.1071007431.886.canavan@morannon.nonet>
In-Reply-To: <ML-3.4.1071007431.886.canavan@morannon.nonet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Rainer Canavan wrote:

> I haven't tried my Qube2 yet, since that one's already wrapped up and
> ready for Karsten Merker to pick up - he's going to send it to the 
> Tulip Expert, so those problems may go away soon, hopefully. As to 
> kernel versions starting about 2.4.17, I've never had the tulip driver
> running reliably on my Qube2, but always got at least 2.4.18 and later 
> working properly on my nasRaq (there was some patching involved at times, 
> if I recall correctly).

Are these patches lying around someplace by chance?  I've used the 
patches on Paul Martin's site (which enables detection of the cobalt's 
"modified" tulip), as well as a patch from Karsten which fixed serial 
console and also enabled the tulip driver.  Both of those patches don't 
seem to fix the tulip's issue of halting though, so either I have broken 
hardware, or I've done something unique in my setup that triggers the issue.

I'd like to get ahold of any patches that I haven't tried yet in an 
attempt to either nail the problem or isolate the cause.

btw, anyone ever gotten tulip-diag to compile on mips?


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
