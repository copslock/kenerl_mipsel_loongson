Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 19:08:13 +0200 (CEST)
Received: from [81.2.74.9] ([81.2.74.9]:50271 "EHLO h5.dl5rb.org.uk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903770Ab2FMRIJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jun 2012 19:08:09 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5DH875l029751;
        Wed, 13 Jun 2012 18:08:07 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5DH86l4029749;
        Wed, 13 Jun 2012 18:08:06 +0100
Date:   Wed, 13 Jun 2012 18:08:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 5/5] MIPS: Move cache setup to setup_arch().
Message-ID: <20120613170806.GC14657@linux-mips.org>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
 <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com>
 <CACoURw4+N8Nk-N81kryXHOg9O_=ntvqv9prOLAZW6KKEYQ9v+A@mail.gmail.com>
 <4FD61B22.3040407@gmail.com>
 <4FD61F35.1080103@gmail.com>
 <CACoURw6oCNKHh7o9N_kE6uryfpu57sQqA-p2fq6hKnsikO5KgA@mail.gmail.com>
 <CACoURw6S+Z9urgYQzqkTZ0WR4kcaxMnSLm=D6m_6pWJnvDtUpA@mail.gmail.com>
 <4FD8BFFE.3040400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FD8BFFE.3040400@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33631
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jun 13, 2012 at 09:29:50AM -0700, David Daney wrote:

> On 06/13/2012 08:44 AM, Shane McDonald wrote:
> >On Mon, Jun 11, 2012 at 12:32 PM, Shane McDonald
> ><mcdonald.shane@gmail.com>  wrote:
> >>There is a line:
> >>
> >>__setup("cca=", cca_setup);
> >>
> >>that seems to be used to call cca_setup().  I don't know how
> >>the __setup() works, so I'm a little lost on the solution myself.
> >>
> >>Note that, besides the cca_setup(), there is also a routine
> >>setcoherentio() that is defined the same way as cca_setup().
> >>I suspect that suffers from the same problem as cca_setup().
> >
> >I've been doing a little learning on how the __setup() macro works.
> >A proposed solution I have is to change from using the __setup()
> >macro to using early_param() to mark the call to cca_setup().
> 
> This is the exact change I was going to suggest.
> 
> >Functions marked with __setup() are executed late in the boot
> >process, whereas those marked with early_param() occur
> >very early in the process.  I have tried this out,
> >and it solves my problem, but I'm looking for feedback on
> >whether this is the correct solution.
> >
> >Unless I get any different feedback, I'll send out a patch with
> >my change later today.
> 
> Assuming that such a patch passes checkpatch.pl and is otherwise
> clean, you could add:

Sounds fine to me too, as long as the it's still being called early enough.
The value is being used for all TLB mappings so it should be ready
latest when the TLB mappings or pagetable entries are computed.

  Ralf
