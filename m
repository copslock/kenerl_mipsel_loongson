Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 00:43:44 +0000 (GMT)
Received: from p508B6845.dip.t-dialin.net ([IPv6:::ffff:80.139.104.69]:34242
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225199AbTCMAnn>; Thu, 13 Mar 2003 00:43:43 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2D0hcn07412;
	Thu, 13 Mar 2003 01:43:38 +0100
Date: Thu, 13 Mar 2003 01:43:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Ranjan Parthasarathy <ranjanp@efi.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Disabling lwl and lwr instruction generation
Message-ID: <20030313014338.C29568@linux-mips.org>
References: <D9F6B9DABA4CAE4B92850252C52383AB0796823C@ex-eng-corp.efi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <D9F6B9DABA4CAE4B92850252C52383AB0796823C@ex-eng-corp.efi.com>; from ranjanp@efi.com on Wed, Mar 12, 2003 at 10:05:20AM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 12, 2003 at 10:05:20AM -0800, Ranjan Parthasarathy wrote:

> Is there a way to tell gcc to not generate the lwl, lwr instructions?

Gcc will only ever generate these instructions when __attribute__((unaligned))
is used.

  Ralf
