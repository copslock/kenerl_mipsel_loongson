Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 11:01:21 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55709 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491966Ab0EFJBR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 May 2010 11:01:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4691BtP001378;
        Thu, 6 May 2010 10:01:12 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o46919pr001368;
        Thu, 6 May 2010 10:01:09 +0100
Date:   Thu, 6 May 2010 10:01:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable by
 ctc1
Message-ID: <20100506090108.GA28066@linux-mips.org>
References: <E1O9VoP-0001Zl-Qw@localhost>
 <4BE122D1.3000609@paralogos.com>
 <20100505091159.GA4016@linux-mips.org>
 <4BE19214.4010209@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE19214.4010209@paralogos.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 05, 2010 at 08:43:16AM -0700, Kevin D. Kissell wrote:

> > That's commit ID 72402ec9efdb2ea7e0ec6223cf20e7301a57da02 and the patch
> > was comitted during the CVS days which only records the comitter but not
> > the author.  The actual author is Atsushi Nemoto.
> >   
> Well,. I certainly understood that you were simply the guy who did the
> commit.  Didn't mean to make it sound like an accusation, but it was
> marginally easier to type your name and date than to find, cut, and
> paste the commit ID.  Sorry if it came off wrong.  It would be cool if
> Atsushi remembered the reasoning behind the change, but empirical proof
> that undoing it doesn't create a subtle problem for current SMP kernels
> would be better still.

Oh, I didn't take it for an accusation but it's interesting if not useful
to get the original author involved.  In the dark past I accepted many
patches that were sent to me directly with none of the usual lists on cc.
In addition there are the limitations of what was recorded by CVS.  Some
history information is only available in my mail folders so occasionally I
have to dig deep.

  Ralf
