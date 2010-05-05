Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 11:12:44 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34112 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491862Ab0EEJMU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 May 2010 11:12:20 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o459CFf9019261;
        Wed, 5 May 2010 10:12:16 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o459C04d019250;
        Wed, 5 May 2010 10:12:00 +0100
Date:   Wed, 5 May 2010 10:11:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable by
 ctc1
Message-ID: <20100505091159.GA4016@linux-mips.org>
References: <E1O9VoP-0001Zl-Qw@localhost>
 <4BE122D1.3000609@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE122D1.3000609@paralogos.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 05, 2010 at 12:48:33AM -0700, Kevin D. Kissell wrote:

> I'm glad to hear that the patch is functional.  It was pretty clear that
> it would solve your problem, but I was concerned that the inability to
> write the Cause bits was done as a way around some other problem. 
> Someone went to a certain amount of trouble to not accept them as
> inputs, in violation of spec.  I just looked back, and the bug was
> introduced as part of a patch of Ralf's from April 2005 entitled "Fix
> Preemption and SMP problems in the FP emulator".  It's unlikely that
> overriding CTC semantics actually fixed any underlying problems, but it
> may have masked symptoms of problems that we can only hope have been
> fixed in the mean time. Anyone run this patch on an FPUless SMP?   Oh,
> for a 34Kf with a bunch of TCs! ;o)

That's commit ID 72402ec9efdb2ea7e0ec6223cf20e7301a57da02 and the patch
was comitted during the CVS days which only records the comitter but not
the author.  The actual author is Atsushi Nemoto.

  Ralf
