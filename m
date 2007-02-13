Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 11:51:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57770 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039157AbXBMLur (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 11:50:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1DBnYde005887;
	Tue, 13 Feb 2007 11:49:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1D1hjV1031216;
	Tue, 13 Feb 2007 01:43:45 GMT
Date:	Tue, 13 Feb 2007 01:43:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, fbuihuu@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Message-ID: <20070213014345.GA30988@linux-mips.org>
References: <20070209210014.GA26939@linux-mips.org> <cda58cb80702120101k770e059end43579394206b9d2@mail.gmail.com> <20070212140459.GA9679@linux-mips.org> <20070213.002545.03977174.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070213.002545.03977174.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 13, 2007 at 12:25:45AM +0900, Atsushi Nemoto wrote:

> On Mon, 12 Feb 2007 14:04:59 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > How about this instead ?
> > 
> > Won't work for a pointer to some const thing.
> 
> And recent commit 4ed3a77f38c023658784804cb39a7ce18063dc88 reverts
> commit 3218357c94af92478ef39163163a81e654385320.
> 
> Round and round and round and ...

Well, I reverted that the old state of a warning is definately preferable
until we found a proper solution.

  Ralf
