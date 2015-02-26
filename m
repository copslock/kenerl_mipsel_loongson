Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 00:05:31 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38257 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007473AbbBZXF3EoGhG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 00:05:29 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 177BFB3F;
        Thu, 26 Feb 2015 23:05:23 +0000 (UTC)
Date:   Thu, 26 Feb 2015 15:05:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Hector Marco Gisbert <hecmargi@upv.es>,
        LKML <linux-kernel@vger.kernel.org>,
        ismael Ripoll <iripoll@upv.es>, linuxppc-dev@lists.ozlabs.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-Id: <20150226150522.1d0c035e631d4ea3aae924ec@linux-foundation.org>
In-Reply-To: <20150226230052.GN8656@n2100.arm.linux.org.uk>
References: <54EB735F.5030207@upv.es>
        <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
        <20150223205436.15133mg1kpyojyik@webmail.upv.es>
        <20150224073906.GA16422@gmail.com>
        <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
        <20150226230052.GN8656@n2100.arm.linux.org.uk>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Thu, 26 Feb 2015 23:00:52 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Feb 26, 2015 at 02:38:15PM -0800, Andrew Morton wrote:
> > diff -puN arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/Kconfig
> > --- a/arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> > +++ a/arch/arm64/Kconfig
> > @@ -1,4 +1,4 @@
> > -config ARM64
> > +qconfig ARM64
> 
> Is this a typo?

yup.  But the coffee's nice and strong.
