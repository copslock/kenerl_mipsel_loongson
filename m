Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 00:51:17 +0000 (GMT)
Received: from [IPv6:::ffff:65.160.120.251] ([IPv6:::ffff:65.160.120.251]:49930
	"EHLO mail.matriplex.com") by linux-mips.org with ESMTP
	id <S8225199AbTCMAvQ>; Thu, 13 Mar 2003 00:51:16 +0000
Received: from mail.matriplex.com (mail.matriplex.com [65.160.120.251])
	by mail.matriplex.com (8.9.2/8.9.2) with ESMTP id QAA00886;
	Wed, 12 Mar 2003 16:50:53 -0800 (PST)
	(envelope-from rh@matriplex.com)
Date: Wed, 12 Mar 2003 16:50:53 -0800 (PST)
From: Richard Hodges <rh@matriplex.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Ranjan Parthasarathy <ranjanp@efi.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Disabling lwl and lwr instruction generation
In-Reply-To: <20030313014338.C29568@linux-mips.org>
Message-ID: <Pine.BSF.4.50.0303121647400.95890-100000@mail.matriplex.com>
References: <D9F6B9DABA4CAE4B92850252C52383AB0796823C@ex-eng-corp.efi.com>
 <20030313014338.C29568@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rh@matriplex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rh@matriplex.com
Precedence: bulk
X-list: linux-mips

On Thu, 13 Mar 2003, Ralf Baechle wrote:

> On Wed, Mar 12, 2003 at 10:05:20AM -0800, Ranjan Parthasarathy wrote:
>
> > Is there a way to tell gcc to not generate the lwl, lwr instructions?
>
> Gcc will only ever generate these instructions when __attribute__((unaligned))
> is used.

I got lwl and lwr from a memcpy() with two void pointers...

I quickly changed those to the (aligned) structure pointers instead, and
then memcpy() changed to ordinary word loads and stores.

So, is somebody starting a toolchain for that new Chinese CPU? :-)

-Richard
