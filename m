Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2012 23:07:56 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903605Ab2GRVHr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2012 23:07:47 +0200
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B1FC88A;
        Wed, 18 Jul 2012 21:07:39 +0000 (UTC)
Date:   Wed, 18 Jul 2012 14:07:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
Message-Id: <20120718140738.ca6f8f5a.akpm@linux-foundation.org>
In-Reply-To: <CAMuHMdWW=sAff-iw0EiHaejr34Z4u_X7w3nHf6Tfo-c2f=Qijg@mail.gmail.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
        <20120620152759.2caceb8c.yuasa@linux-mips.org>
        <20120620161249.GB29196@linux-mips.org>
        <4FE4B13E.10709@caviumnetworks.com>
        <CAMuHMdXSGgH+M_2+xuzY2t_sGZto24=atv3Kaj+R-dWAUPzW7w@mail.gmail.com>
        <CAMuHMdWW=sAff-iw0EiHaejr34Z4u_X7w3nHf6Tfo-c2f=Qijg@mail.gmail.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 33940
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 18 Jul 2012 10:35:46 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, Jul 16, 2012 at 9:27 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Jun 22, 2012 at 7:54 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> >> On 06/20/2012 09:12 AM, Ralf Baechle wrote:
> >>>
> >>> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
> >>>
> >>>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
> >>>
> >>>
> >>> Thanks, fix applied.
> >>>
> >>
> >> Where was it applied?
> >>
> >> It doesn't show up in linux-next for 20120622, which is where it is needed.
> >
> > It's also desperately needed in mainline for 3.5.
> >
> > Ralf?
> 
> Andrew? This prevents any green MIPS builds.
> 

The patch is already in linux-next via Ralf's tree.

Perhaps he nodded off - I'll send it at Linus right now.
