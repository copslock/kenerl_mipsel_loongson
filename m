Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2003 12:56:24 +0000 (GMT)
Received: from p508B625A.dip.t-dialin.net ([IPv6:::ffff:80.139.98.90]:20936
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225248AbTAQM4X>; Fri, 17 Jan 2003 12:56:23 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0HCuJg08504;
	Fri, 17 Jan 2003 13:56:19 +0100
Date: Fri, 17 Jan 2003 13:56:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Getting Time Difference
Message-ID: <20030117135619.A8301@linux-mips.org>
References: <ECEPLLMMNGHMFBLHCLMAGEGDDIAA.yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ECEPLLMMNGHMFBLHCLMAGEGDDIAA.yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Thu, Jan 16, 2003 at 06:48:09PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 16, 2003 at 06:48:09PM +0200, Gilad Benjamini wrote:

> I am porting code from a x86 platform.
> That code uses rdtsc and cpu_khz to compute
> the time difference between two events. Jiffies aren't good enough in this 
> case.
> 
> Looking through header files I can find a few MIPS replacements.
> What is the "right" one to use ?
> 
> What is the best way to change the code so it can compile
> and run on both platforms ?

Try do_gettimeofday().

  Ralf
