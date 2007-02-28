Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 19:42:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3469 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039416AbXB1Tm6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 19:42:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SJgqeb022247;
	Wed, 28 Feb 2007 19:42:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SJgptN022246;
	Wed, 28 Feb 2007 19:42:51 GMT
Date:	Wed, 28 Feb 2007 19:42:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <tigerand@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070228194251.GC16562@linux-mips.org>
References: <45E465C1.50408@pmc-sierra.com> <20070227184555.GA32425@onstor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070227184555.GA32425@onstor.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 27, 2007 at 10:46:01AM -0800, Andrew Sharp wrote:

> Experience. ~:^)  You never know when a little extra room for expansion
> might come in handy.  For example, let's say next year you release a
> quad-core SOC (hint-hint), and a line of eval boards.  You would have
> room to put them in the file next to your other boards.  But just a
> suggestion.

Since mips_machtype and mips_machgroup are mostly used to identify systems
within Linux changing would not be the most terrible thing on earth.
There is no requirement for these numbers to be contiguous either.

  Ralf
