Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 19:54:39 +0100 (BST)
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:15573 "EHLO
	rwcrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20023980AbXESSyh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 19:54:37 +0100
Received: from [192.168.1.4] (c-76-106-119-205.hsd1.md.comcast.net[76.106.119.205])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20070519185353m1400ck8ate>; Sat, 19 May 2007 18:53:53 +0000
Message-ID: <464F47C0.9080303@gentoo.org>
Date:	Sat, 19 May 2007 14:53:52 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	kernel coder <lhrkernelcoder@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: system call implementation for 64 bit
References: <f69849430705190456n4ae74be9m3be0b57ef7f54a5b@mail.gmail.com>
In-Reply-To: <f69849430705190456n4ae74be9m3be0b57ef7f54a5b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

kernel coder wrote:
> hi,
> 
> I'm trying to implement a system call for x86_64. Mine processor is
> dual core opetron.There is very little material on web for
> implementing system calls for x86_64 processor for 2.6 series kernel.I
> tried to implement a new system call by observing the existing
> implementation but to no success.Following are files names and changes
> made.
> 

I have a chunk of code to consider:


if (x86_64 != mips) {
	__go_away(now);
}


It's really quite an intuitive piece of code.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
