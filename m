Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 12:59:55 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:44965 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20024718AbXIDL7q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 12:59:46 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id D34A4B95C7;
	Tue,  4 Sep 2007 13:55:28 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ISX0B-0001UN-Th; Tue, 04 Sep 2007 12:55:28 +0100
Date:	Tue, 4 Sep 2007 12:55:27 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	yshi <yang.shi@windriver.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
Message-ID: <20070904115527.GA848@networkno.de>
References: <46DD1CD1.5040306@windriver.com> <006901c7eeda$d8049a50$10eca8c0@grendel> <1188901951.4106.16.camel@yshi.CORP> <006f01c7eee5$bbe77c60$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006f01c7eee5$bbe77c60$10eca8c0@grendel>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> > ??? 2007-09-04?????? 12:03 +0200???Kevin D. Kissell?????????
> > > The 4KEc is a MIPS32 Release 2 processor, for which the implementation
> > > of the Cause.TI bit (bit 30) is required.  You may have a defective board
> > > or a bad FPGA bitfile.  Please work with your support contacts at MIPS
> > > to verify that this is not the case.  It may also be that there's something more
> > > subtle going on in the interrupt processing, such that the Cause.TI bit is being
> > > cleared before it can be sampled by the code you've changed.  But while the
> > > patch below presumably solves the symptoms of your problem, I really
> > > don't think that a kernel hack based on detecting CoreFPA3 is an appropriate
> > > solution.  I work every day with Malta/CoreFPGA3 bitfiles and have not
> > > seen Cause.TI fail to function in any of the Release 2 core bitfiles I've used.
> >
> > My board's core is Release 1 core. So Cause.TI bit always is zero. Maybe
> > I need update this patch to reflect this, i.e add #ifdef to distinguish
> > Release 1 and Release 2. Thanks.
> 
> In that case, your core is a 4Kc and not a 4KEc.

Not quite true, early revisions of the 4KEc were only release 1. This
seems to be a bug in arch/mips/cpu-probe.c:

static inline void cpu_probe_mips(struct cpuinfo_mips *c)
{
        decode_configs(c);
        switch (c->processor_id & 0xff00) {
        case PRID_IMP_4KC:
                c->cputype = CPU_4KC;
                break;
        case PRID_IMP_4KEC:
                c->cputype = CPU_4KEC;
                break;
        case PRID_IMP_4KECR2:
                c->cputype = CPU_4KEC;
                break;
	...

The type for PRID_IMP_4KEC should be CPU_4KC.


Thiemo
