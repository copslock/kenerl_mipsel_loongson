Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Apr 2004 08:52:52 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:48620 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225914AbUDLHwv>; Mon, 12 Apr 2004 08:52:51 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2004041207524201300ff693e>
          (Authid: kumba12345);
          Mon, 12 Apr 2004 07:52:42 +0000
Message-ID: <407A4B01.5010701@gentoo.org>
Date: Mon, 12 Apr 2004 03:53:37 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Raq2 & 2.6.4 : Strange output fro msomewhere
References: <000301c42053$2ae67fe0$e60a0a0a@guendalin>
In-Reply-To: <000301c42053$2ae67fe0$e60a0a0a@guendalin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Massimo Cetra wrote:

> Hi!
> 
> (i'm new here).
> I have managed to compile CVS kernels for 2.6.4 and 2.4.25 trees on my
> Raq2... And they work great.
> 
> Now...
> Under heavy load (generating kernel_headers debian package), i saw the
> following:
> 
> -cobalt:/proc# uptime
> Unknown HZ value! (79) Assume 100.
>  06:54:27 up 14 min,  2 users,  load average: 1.77, 1.37, 0.69
> cobalt:/proc# sar 2 2
> Linux 2.6.4 (cobalt)    04/12/04
> 
> 06:54:32          CPU     %user     %nice   %system     %idle
> 06:54:34          all     18.31      0.00     81.69      0.00
> 06:54:36          all     16.67      0.00     83.33      0.00
> Average:          all     17.60      0.00     82.40      0.00
> cobalt:/proc# uname -a
> Linux cobalt 2.6.4 #2 Mon Apr 12 05:50:49 CEST 2004 mips unknown
> cobalt:/proc#
> 
> 
> What is : "Unknown HZ value! (79) Assume 100." ????????????????????????
> 
> Thanks..

What does dmesg say your bogomips are?  There's a patch that fixes a 
small calculation error.  Without it, bogomips reports in at ~2,500, 
instead of 250.  Call it a guess, but if you missed that patch, that 
might be your bug.  Otherwise, I'm not too sure.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
