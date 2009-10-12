Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 18:16:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45220 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492947AbZJLQQf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 18:16:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9CGHqFS021307;
	Mon, 12 Oct 2009 18:17:52 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9CGHpJm021305;
	Mon, 12 Oct 2009 18:17:51 +0200
Date:	Mon, 12 Oct 2009 18:17:51 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Gandham, Raghu" <raghu@mips.com>
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	linux-mips@linux-mips.org, "Dearman, Chris" <chris@mips.com>
Subject: Re: [PATCH 15/15] Do not rely on the initial state of TC/VPE
	bindings when doing cross VPE writes
Message-ID: <20091012161751.GB21183@linux-mips.org>
References: <20090702023938.23268.65453.stgit@linux-raghu> <20090702024331.23268.98671.stgit@linux-raghu> <4A4C314B.2070907@paralogos.com> <94BD67F8AF3ED34FA362C662BA1F12C503BED88E@MTVEXCHANGE.mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94BD67F8AF3ED34FA362C662BA1F12C503BED88E@MTVEXCHANGE.mips.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 02, 2009 at 02:46:33PM -0700, Gandham, Raghu wrote:

> > From: Kevin D. Kissell [mailto:kevink@paralogos.com]
> > Sent: Wednesday, July 01, 2009 9:02 PM
> > To: Gandham, Raghu
> > Cc: linux-mips@linux-mips.org; Dearman, Chris
> > Subject: Re: [PATCH 15/15] Do not rely on the initial state of TC/VPE
> > bindings when doing cross VPE writes
> > 
> > Note that, regardless of the reset state, smtc_configure_tlb() should
> > have at least temporarily bound TC 1 to VPE1, which may be why this
> > never seemed to be a problem on the 34K.  If one wants to support
> > designs with more than 2 VPEs, then this is probably one of the things
> > that needs to be fixed.  That having been said, rather than adding a
> > usually-redundant write_vpe_c0_vpeconf0() in that clause, wouldn't it
> be
> > cleaner to just move the MVP setting from the top of the loop to the
> > point in the loop just after the TCs have been bound to the VPE in
> > question, i.e.,
> > 
> >  454                 if (slop) {
> >  455                         if (tc != 0) {
> >  456                                 smtc_tc_setup(vpe,tc, cpu);
> >  457                                 cpu++;
> >  458                         }
> >  459                         printk(" %d", tc);
> >  460                         tc++;
> >  461                         slop--;
> >  462                 }
> > 
> >                         write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() |
> > VPECONF0_MVP);
> > 
> >  463                 if (vpe != 0) {
> >  464                         /*
> >  465                          * Clear any stale software interrupts
> from
> > VPE's Cause
> >  466                          */
> > 
> > This should definitely be OK for a 34K, because it's being executed by
> > TC0 in VPE0 and the reset state of VPE0 has MVP set.  If it weren't,
> > smtc_configure_tlb() would have failed.
> > 
> >           Regards,
> > 
> >           Kevin K.
> 
> 
> I will resend this patch with your suggestion.

Ping?  Don't think I ever received that, if you sent it.

  Ralf
