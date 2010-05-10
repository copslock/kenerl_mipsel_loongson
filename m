Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2010 22:41:59 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52891 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492404Ab0EJUl4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 May 2010 22:41:56 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4AKfr0F017086;
        Mon, 10 May 2010 21:41:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4AKfnH5017082;
        Mon, 10 May 2010 21:41:50 +0100
Date:   Mon, 10 May 2010 21:41:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: nofpu and nodsp only affect CPU0
Message-ID: <20100510204148.GA959@linux-mips.org>
References: <0b6db1ee1efbe0daa1320b59ab5093ba5af377b8@localhost.localdomain>
 <20100510201959.GB28820@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100510201959.GB28820@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 10, 2010 at 09:19:59PM +0100, Ralf Baechle wrote:

> > The "nofpu" and "nodsp" kernel command line options currently do not
> > affect CPUs that are brought online later in the boot process or
> > hotplugged at runtime.  It is desirable to apply the nofpu/nodsp options
> > to all CPUs in the system, so that surprising results are not seen when
> > a process migrates from one CPU to another.
> 
> I like this patch; this solution is also cleaner than iterating over the
> cpu data array.  However as it constitutes a change in established kernel
> behaviour I prefer to queue this patch for 2.6.35 rather than applying it
> immediately.

I've moved definitions of mips_fpu_disabled, fpu_disable, mips_dsp_disabled
and dsp_disable from setup.c to cpu-probe.c to allow mips_fpu_disabled and
mips_dsp_disabled to become static.

  Ralf
