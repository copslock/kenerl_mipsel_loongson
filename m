Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 18:47:08 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:64504 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225351AbUA3SrH>;
	Fri, 30 Jan 2004 18:47:07 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0UIl5w02667;
	Fri, 30 Jan 2004 10:47:05 -0800
Date: Fri, 30 Jan 2004 10:47:05 -0800
From: Jun Sun <jsun@mvista.com>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: readdir() problems
Message-ID: <20040130104705.F31937@mvista.com>
References: <Law10-F54DrroFpJasS000386db@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Law10-F54DrroFpJasS000386db@hotmail.com>; from juszczec@hotmail.com on Fri, Jan 30, 2004 at 03:02:09AM +0000
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jan 30, 2004 at 03:02:09AM +0000, Mark and Janice Juszczec wrote:
> 
> Hi folks
> 
> I'm running on a Helio pda, r3912 chip, little endian.  I've used crosstool 
> to create a cross compiler with
> 
> gcc 3.2.3
> glibc 2.2.3
> 

I don't think it is a known problem.

FWIW, I just tested your program on r5500, LE machine with gcc 3.3.1/glibc 2.3.2.
It runs fine.

There is a remote chance something may be wrong with your kenel, but more
likely probably something is wrong with glibc or your userland environment.

Jun
