Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 00:50:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56033 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022193AbXFZXu2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Jun 2007 00:50:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5QNoJGl027311;
	Wed, 27 Jun 2007 01:50:19 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5QNoH4j027310;
	Wed, 27 Jun 2007 01:50:18 +0200
Date:	Wed, 27 Jun 2007 01:50:17 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make ioremap() work on TX39/49 special unmapped segment
Message-ID: <20070626235017.GA24949@linux-mips.org>
References: <20070626.011401.103777892.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070626.011401.103777892.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 26, 2007 at 01:14:01AM +0900, Atsushi Nemoto wrote:

> TX39XX and TX49XX have "reserved" segment in CKSEG3 area.
> 0xff000000-0xff3fffff on TX49XX and 0xff000000-0xfffeffff on TX39XX
> are reserved (unmapped, uncached).  Controllers on these SoCs are
> placed in this segment.
> 
> This patch add plat_ioremap() and plat_iounmap() to override default
> behavior and implement these hooks for TX39/TX49.

Queued.  Thanks!

  Ralf
