Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 13:26:08 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:34574 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225746AbVCHNZx>; Tue, 8 Mar 2005 13:25:53 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j28DO9qY012898;
	Tue, 8 Mar 2005 13:24:09 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j28DO8ZM012897;
	Tue, 8 Mar 2005 13:24:08 GMT
Date:	Tue, 8 Mar 2005 13:24:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	freshy98 <freshy98@gmx.net>, Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
Message-ID: <20050308132408.GB9811@linux-mips.org>
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net> <422D0D64.2080402@gentoo.org> <422D2801.2060903@jg555.com> <422D3AC9.4020601@gentoo.org> <422D4A49.9020504@gmx.net> <422D55B6.4010300@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422D55B6.4010300@jg555.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 07, 2005 at 11:35:18PM -0800, Jim Gifford wrote:

> File - What to remove or comment out
> /usr/src/linux/include/asm/cpu-features.h - #include 
> <cpu-feature-overrides.h>
> /usr/src/linux/include/asm/addrspace.h -  #include <spaces.h>
> 
> But it still fails, because it looks at the headers in /usr/include and 
> the ones is /usr/src/linux/include, which is what the problem is. Namely 
> socket.h
> 
> What I noticed is some of the mips architectures includes have these 
> files and some do not.

These headers are search along a search path until found.  Typically that
path consists of two directories such as mach-ip22 followed by mach-generic
as last.  This allows eleminating duplicated header files.

A bad side effect - users frequently forget adding files such as
cpu-features-override.h which contain a detailed description of the CPU
properties on a particular platform.  Without a platform specific file
the kernel will basically fallback to generic code that is slow but
supports almost every CPU in the universe.

  Ralf
