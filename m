Received:  by oss.sgi.com id <S553825AbRAJPpo>;
	Wed, 10 Jan 2001 07:45:44 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:59891 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553822AbRAJPpg>; Wed, 10 Jan 2001 07:45:36 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S868130AbRAJPej>; Wed, 10 Jan 2001 13:34:39 -0200
Date:	Wed, 10 Jan 2001 13:34:39 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	carlson@sibyte.com, linux-mips@oss.sgi.com
Subject: Re: _clear_page semantics
Message-ID: <20010110133438.A2103@bacchus.dhis.org>
References: <01010917590106.07691@plugh.sibyte.com> <3A5C1868.A6B54E57@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5C1868.A6B54E57@mips.com>; from carstenl@mips.com on Wed, Jan 10, 2001 at 09:08:08AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 10, 2001 at 09:08:08AM +0100, Carsten Langgaard wrote:

> You are absolutely right, it is implementation dependent.
> I just tend to use the mips32 implementation for my R4000s as well, and here as
> Ralf mention it is performance improving.
> Actually we have included a CPU option flag (MIPS_CPU_CACHE_CDEX), what tells us
> if the CPU has the Create_Dirty_Exclusive CACHE operation available.
> So we should probably use it, now it is here :-)

Homework for somebody with some time at his hands - we have a large number
of unrolled loops for all sorts of cache variations in r4xx0.c.  Benchmark
if they actually improve performance.  I wouldn't wonder if due to a large
number of pipeline stalls in one of those routines the whole unrolling
business doesn't buy us anything.

  Ralf
