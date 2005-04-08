Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 17:21:30 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:56351 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225421AbVDHQVO>; Fri, 8 Apr 2005 17:21:14 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j38GL8x0000401
	for <linux-mips@linux-mips.org>; Fri, 8 Apr 2005 17:21:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j38GL8UM000400
	for linux-mips@linux-mips.org; Fri, 8 Apr 2005 17:21:08 +0100
Resent-Message-Id: <200504081621.j38GL8UM000400@dea.linux-mips.net>
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.org (8.13.1/8.13.1) with ESMTP id j38GDwwi032529;
	Fri, 8 Apr 2005 17:13:58 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j38GDw0R032528;
	Fri, 8 Apr 2005 17:13:58 +0100
Date:	Fri, 8 Apr 2005 17:13:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
Message-ID: <20050408161357.GB19166@linux-mips.org>
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4256991C.4020601@timesys.com>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Fri, 8 Apr 2005 17:21:08 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 08, 2005 at 10:45:48AM -0400, Greg Weeks wrote:

> >This is the malta branch with the tlb patch from Ralf applied. The LTP 
> >test:

Credits for this patch go to Maciej who actually went through the pain
of debugging this problem that did show it's ugly head long, long after
the affected revision has been obsoleted by newer revisions.

> >-bash-2.05b# shmem_test_06
> 
> This test does some mucking with shmat at fixed addresses that might not 
> be correct for mips. I still wouldn't expect to see a machine check when 
> it goes to free the shared memory areas. I'm going to try it on a 24K 
> malta as soon as I get yamon on it and can get it booted.

I've been able to reproduce it on on two 4Kc boards of different revisions
so this seems to be something else.  It does not hit 5Kc and 24K.

  Ralf
