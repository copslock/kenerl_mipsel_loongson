Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 17:33:32 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:47592 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225225AbULPRd1>; Thu, 16 Dec 2004 17:33:27 +0000
Received: from gw.junsun.net (c-24-6-106-170.client.comcast.net[24.6.106.170])
          by comcast.net (sccrmhc12) with ESMTP
          id <2004121617330801200iipqre>; Thu, 16 Dec 2004 17:33:08 +0000
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id iBGHX6Gd003262;
	Thu, 16 Dec 2004 09:33:07 -0800
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id iBGHX6fV003261;
	Thu, 16 Dec 2004 09:33:06 -0800
Date: Thu, 16 Dec 2004 09:33:06 -0800
From: Jun Sun <jsun@junsun.net>
To: zhan rongkai <zhanrk@gmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: About task->used_math and TIF_USEDFPU
Message-ID: <20041216173306.GA3230@gw.junsun.net>
References: <73e6204504121600066a2ce0b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e6204504121600066a2ce0b1@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Thu, Dec 16, 2004 at 04:06:12PM +0800, zhan rongkai wrote:
> hi all,
> 
> I am a little confused about the task_struct member 'used_math', and
> thread_info flag TIF_USEDFPU.
> 
> What are their meaning, and what is the difference between them?
> 

used_math is used to indicate whether a process has ever used FPU since
it is created (which typically is true due to the glibc using FPU at the
beginning of each program).

TIF_USEDFPU indicates whether a _running_ process has used FPU since
it is context-switched on.

Jun
