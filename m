Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2003 19:51:15 +0100 (BST)
Received: from sj-core-1.cisco.com ([IPv6:::ffff:171.71.177.237]:14481 "EHLO
	sj-core-1.cisco.com") by linux-mips.org with ESMTP
	id <S8225196AbTETSvD>; Tue, 20 May 2003 19:51:03 +0100
Received: from mira-sjc5-e.cisco.com (IDENT:mirapoint@mira-sjc5-e.cisco.com [171.71.163.15])
	by sj-core-1.cisco.com (8.12.9/8.12.6) with ESMTP id h4KIoseS029085;
	Tue, 20 May 2003 11:50:54 -0700 (PDT)
Received: from wjhun-lnx2.cisco.com (wjhun-lnx2.cisco.com [128.107.165.34])
	by mira-sjc5-e.cisco.com (Mirapoint Messaging Server MOS 3.3.3-GR)
	with ESMTP id AEI23749;
	Tue, 20 May 2003 11:50:53 -0700 (PDT)
Received: from wjhun by wjhun-lnx2.cisco.com with local (Exim 3.36 #1 (Debian))
	id 19IBwa-0004bq-00; Tue, 20 May 2003 11:34:36 -0700
Date: Tue, 20 May 2003 11:34:36 -0700
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org
Subject: Re: lwl-lwr
Message-ID: <20030520183436.GJ726@cisco.com>
References: <1053455551.996c4860yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053455551.996c4860yaelgilad@myrealbox.com>
User-Agent: Mutt/1.5.3i
From: Will Jhun <wjhun@cisco.com>
Return-Path: <wjhun@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wjhun@cisco.com
Precedence: bulk
X-list: linux-mips

Some free or "MIPS-like" CPUs don't implement it because of a patent
problem. I've seen at least one implementation on opencores.org that has
this (missing) feature.

Probably if the compiler were to emit lwl and lwr code via
__attribute__((packed)), these instructions would have to be emulated by
the kernel on such a CPU. I imagine this would be quite a bit worse than
just doing two normal loads and extracting the desired word.

Will

On Tue, May 20, 2003 at 06:32:31PM +0000, Gilad Benjamini wrote:
> Hi,
> About two months ago there was a discussion
> here about disabling lwl-lwr.
> 
> Can someone shed some light on why the discussion
> emerged ?
> 
> Is this a performance issue, a processor which 
> doesn't support it, or something else ?
> 
> If this is a performance issue, I'll be happy
> to hear more details.
> 
> TIA
> 
> 
> 
