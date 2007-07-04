Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2007 12:00:55 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:994 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021819AbXGDLAx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jul 2007 12:00:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l64B0pu7026712;
	Wed, 4 Jul 2007 13:00:52 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l64B0nq4026711;
	Wed, 4 Jul 2007 12:00:49 +0100
Date:	Wed, 4 Jul 2007 12:00:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	mlachwani@mvista.com, jeff@garzik.org
Subject: Re: [PATCH] rbtx4938: Fix secondary PCIC and glue internal NICs
Message-ID: <20070704110049.GA23103@linux-mips.org>
References: <20070629.223501.93206611.anemo@mba.ocn.ne.jp> <20070702.224306.59464033.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070702.224306.59464033.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 02, 2007 at 10:43:06PM +0900, Atsushi Nemoto wrote:

> On Fri, 29 Jun 2007 22:35:01 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > * Use platform_device to provide ethernet addresses for internal NICs.
> 
> Oops, a calculation of checksum was wrong --- revised.

Queued for 2.6.23.

  Ralf
