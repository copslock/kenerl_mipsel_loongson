Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 09:01:31 +0000 (GMT)
Received: from p508B7B53.dip.t-dialin.net ([IPv6:::ffff:80.139.123.83]:44924
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224772AbUCYJBb>; Thu, 25 Mar 2004 09:01:31 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2P91ToM028216;
	Thu, 25 Mar 2004 10:01:30 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2P91Tk7028215;
	Thu, 25 Mar 2004 10:01:29 +0100
Date: Thu, 25 Mar 2004 10:01:28 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: xavier prabhu <xavier_prabhu@linuxmail.org>
Cc: linux-mips@linux-mips.org
Subject: Re: __up and __down not found in 2.25 kernel
Message-ID: <20040325090128.GA27145@linux-mips.org>
References: <20040325083629.8255C39834A@ws5-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325083629.8255C39834A@ws5-1.us4.outblaze.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 25, 2004 at 04:36:29PM +0800, xavier prabhu wrote:

> I'm using a module which is developed for 2.22 kernel.
> This module uses __up and __down semaphore functions. 
> While I insmod this module with 2.25 kernel,
> I get the following error message
> "insmod: unresolved symbol __up
> insmod: unresolved symbol __down"
> 
> I checked the semaphore.c. It doesn't define these two functions.
> Is there any way to work around this issue.

Sounds like you're using some broken tree - get the sources from cvs.

  Ralf
