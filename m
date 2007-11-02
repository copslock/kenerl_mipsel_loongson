Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 12:20:33 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:59537 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030372AbXKBMUb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Nov 2007 12:20:31 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA2CK1O5013812;
	Fri, 2 Nov 2007 12:20:01 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA2CK1Xl013811;
	Fri, 2 Nov 2007 12:20:01 GMT
Date:	Fri, 2 Nov 2007 12:20:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] JAZZ: disable PIT; cleanup R4030 clockevent
Message-ID: <20071102122001.GC22829@linux-mips.org>
References: <20071101125236.GA16577@alpha.franken.de> <20071101150741.GA8570@linux-mips.org> <20071101160210.GA20366@linux-mips.org> <20071102101713.GA9110@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071102101713.GA9110@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 02, 2007 at 11:17:13AM +0100, Thomas Bogendoerfer wrote:

> On Thu, Nov 01, 2007 at 04:02:10PM +0000, Ralf Baechle wrote:
> > all over the kernel.  I hope this should bring the i2853 to life for you.
> 
> it does now, even pit clockevent works now (if you apply the patch
> below).

Applied, thanks,

One thing I'm still wondering about, does the kernel actually go tickless
for you?

  Ralf
