Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 16:38:45 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:10523 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224773AbVCHQia>; Tue, 8 Mar 2005 16:38:30 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j28Gb1uB009273;
	Tue, 8 Mar 2005 16:37:01 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j28Gb0oF009272;
	Tue, 8 Mar 2005 16:37:00 GMT
Date:	Tue, 8 Mar 2005 16:37:00 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
Message-ID: <20050308163700.GA2099@linux-mips.org>
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net> <422D0D64.2080402@gentoo.org> <422D2801.2060903@jg555.com> <422D3AC9.4020601@gentoo.org> <422D4A49.9020504@gmx.net> <422D55B6.4010300@jg555.com> <20050308132408.GB9811@linux-mips.org> <422DD318.9020804@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422DD318.9020804@jg555.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 08, 2005 at 08:30:16AM -0800, Jim Gifford wrote:

> Ralf and other Linux-MIPS readers,
>    I checked the linux-libc-headers for those files, and they are not 
> there. I'm tried fighting this battle with netfilter before and they 
> won't budge from the fact that they build iptables from the headers in 
> /usr/src/linux, if you use my make KERNEL_DIR=/usr, the problem doesn't 
> exist it's only when we build from the raw kernel headers. So what 
> method is the proper method, building from the raw headers or santized 
> ones like linux-libc?

The sucky but official policy Linus has given out is that userland should
not include kernel headers.  Which means anything else is ok.

  Ralf
