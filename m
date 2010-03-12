Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 11:14:23 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47660 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492142Ab0CLKOT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Mar 2010 11:14:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2CAEErk023110;
        Fri, 12 Mar 2010 11:14:15 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2CAEDf0023108;
        Fri, 12 Mar 2010 11:14:13 +0100
Date:   Fri, 12 Mar 2010 11:14:13 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>,
        linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: tracing: Optimize the implementation
Message-ID: <20100312101413.GA22877@linux-mips.org>
References: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
 <20100312085053.GB6364@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100312085053.GB6364@alpha.franken.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 12, 2010 at 09:50:53AM +0100, Thomas Bogendoerfer wrote:

> On Fri, Mar 12, 2010 at 02:07:37AM +0800, Wu Zhangjin wrote:
> > +/*
> > + * If the Instruction Pointer is in module space (0xc0000000), return ture;
> > + * otherwise, it is in kernel space (0x80000000), return false.
> > + */
> > +#define in_module(ip) (unlikely((ip) & 0x40000000))
> > +
> 
> looks broken for 64bit, but maybe this is a 32bit only feature...

This gem did already exist in the old code, so no regression:

	if (ip & 0x40000000) {

  Ralf
