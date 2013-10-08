Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 14:29:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39204 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827313Ab3JHM3HwMv7i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 14:29:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r98CT6Ka029104;
        Tue, 8 Oct 2013 14:29:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r98CT5FO029103;
        Tue, 8 Oct 2013 14:29:05 +0200
Date:   Tue, 8 Oct 2013 14:29:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     thomas.langer@lantiq.com
Cc:     markos.chandras@imgtec.com, linux-mips@linux-mips.org,
        Leonid.Yegoshin@imgtec.com
Subject: Re: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
Message-ID: <20131008122905.GJ1615@linux-mips.org>
References: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
 <593AEF6C47F46446852B067021A273D6D990182F@MUCSE039.lantiq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593AEF6C47F46446852B067021A273D6D990182F@MUCSE039.lantiq.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Oct 08, 2013 at 11:48:54AM +0000, thomas.langer@lantiq.com wrote:

> >  void __noreturn nmi_exception_handler(struct pt_regs *regs)
> >  {
> > +	char str[100];
> > +
> >  	raw_notifier_call_chain(&nmi_chain, 0, regs);
> >  	bust_spinlocks(1);
> > -	printk("NMI taken!!!!\n");
> > -	die("NMI", regs);
> > +	snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
> > +		 smp_processor_id(), regs->cp0_epc);
> > +	regs->cp0_epc = read_c0_errorepc();
> 
> If this is a YAMON specific fix, why is it done in a common file?

The installation of an NMI handler is platform specific - this handler
however in all its simplicity is generic - or at least trying to.

The NMI on MIPS is notoriously hard to use.  The vectors is pointing to
the boot ROM so firmware first gets its grubby hands on a fresh NMI and
on most systems it'll do the firmware equivalent of a panic or reset
the system outright.  If that's still working - it's about the worst
tested functionality of firmware ...

  Ralf
