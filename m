Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 00:33:01 +0000 (GMT)
Received: from p508B5B9C.dip.t-dialin.net ([IPv6:::ffff:80.139.91.156]:53305
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224936AbUAVAdA>; Thu, 22 Jan 2004 00:33:00 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0M0Wxex015914
	for <linux-mips@linux-mips.org>; Thu, 22 Jan 2004 01:32:59 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0M0WxfZ015913
	for linux-mips@linux-mips.org; Thu, 22 Jan 2004 01:32:59 +0100
Resent-Message-Id: <200401220032.i0M0WxfZ015913@fluff.linux-mips.net>
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0M0SSex015814
	for <nlarson@Crossroads.com>; Thu, 22 Jan 2004 01:28:28 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0M0SRcf015813
	for nlarson@Crossroads.com; Thu, 22 Jan 2004 01:28:27 +0100
Date: Thu, 22 Jan 2004 01:28:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Nils Larson <nlarson@Crossroads.com>
Subject: Re: How to add more memory?
Message-ID: <20040122002827.GA10415@linux-mips.org>
References: <CFD808D1D39ACB47ABFF586D484CC52EADE212@hqmailnode1.commstor.crossroads.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFD808D1D39ACB47ABFF586D484CC52EADE212@hqmailnode1.commstor.crossroads.com>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 22 Jan 2004 01:32:59 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 21, 2004 at 03:58:24PM -0600, Nils Larson wrote:

> We currently have a mips platform running Linux with 256MB of
> RAM starting at 0x8000_0000. We would like to add an additional
> 1GB of RAM, maybe starting at 0x4000_0000, that would be used
> for user apps (user virtual memory). The memory map is:
> 0x8000_0000 - 256MB RAM
> 0xA000_0000 - uncached version of the same 256MB
> 0xB000_0000 - PCI memory windows.
> This is a diskless setup booting from a ramdisk.
> So, the (sort of newbie) questions are:
> 1. How do we tell Linux to use the new memory?
> 2. Is this feasible?
> 3. Is there a better way to add more memory?
> We need more space for user data.

I wrote the highmem code for Linux/MIPS.  It's currently limited
to processor configurations that don't suffer from virtual aliases but
that limitation can be removed; depending of your application and hardware
that may be anywhere from trivial to hard.   What is your processor?

  Ralf
