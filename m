Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Oct 2017 01:09:14 +0200 (CEST)
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:57367 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990406AbdJTXJHBUvKe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Oct 2017 01:09:07 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C7EA5100E86C0;
        Fri, 20 Oct 2017 23:09:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hen96_891c140cbdc5c
X-Filterd-Recvd-Size: 2528
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Oct 2017 23:09:02 +0000 (UTC)
Message-ID: <1508540940.30181.9.camel@perches.com>
Subject: Re: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
From:   Joe Perches <joe@perches.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org,
        Dragan Cecavac <dragan.cecavac@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 20 Oct 2017 16:09:00 -0700
In-Reply-To: <alpine.DEB.2.00.1710202245400.3886@tp.orcam.me.uk>
References: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
         <1508512648.30181.1.camel@perches.com>
         <alpine.DEB.2.00.1710202148280.3886@tp.orcam.me.uk>
         <1508533736.30181.7.camel@perches.com>
         <alpine.DEB.2.00.1710202245400.3886@tp.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Fri, 2017-10-20 at 22:46 +0100, Maciej W. Rozycki wrote:
> On Fri, 20 Oct 2017, Joe Perches wrote:
> 
> > > > That's somewhat unpleasant code as it formats a fmt string
> > > > and the compiler can not verify fmt and args.
> > > > 
> > > > Perhaps something like the below is preferable:
> > > 
> > >  Hmm, what problem exactly are you trying to solve with code that has 
> > > worked just fine for 16 years now?
> > 
> > The compiler cannot verify fmt and args.
> 
>  You have stated that already.  Why is that a problem?

Jeeze, perhaps you don't like the word perhaps.

There is no absolute defect here.

There are unnecessary pushes to stack that are
unwound by the compiler.

Stylistically, format/argument mismatches can
cause errors.  It's
generally bad form and error
prone to use non constant strings as
formats.

Note it's not signed and is a simple suggestion.
If you don't like it, don't do anything with it.
