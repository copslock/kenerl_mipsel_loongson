Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 15:00:27 +0100 (CET)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:45490 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011346AbaJ1OAWLMdg7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 15:00:22 +0100
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1Xj7Jg-0004iG-UC; Tue, 28 Oct 2014 10:00:09 -0400
Received: from linville-x1.hq.tuxdriver.com (localhost.localdomain [127.0.0.1])
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.6) with ESMTP id s9SDn5sK027154;
        Tue, 28 Oct 2014 09:49:05 -0400
Received: (from linville@localhost)
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.8/Submit) id s9SDmxZH027150;
        Tue, 28 Oct 2014 09:48:59 -0400
Date:   Tue, 28 Oct 2014 09:48:59 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath5k-devel@venema.h4ckr.net
Subject: Re: [PATCH v2 11/13] ath5k: revert AHB bus support removing
Message-ID: <20141028134859.GB26283@tuxdriver.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-12-git-send-email-ryazanov.s.a@gmail.com>
 <20141027180436.GE28300@tuxdriver.com>
 <CAHNKnsTWvZy=-TBv-KPjCOD-vhwcxUUGv61doYUm0F77if-pqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNKnsTWvZy=-TBv-KPjCOD-vhwcxUUGv61doYUm0F77if-pqw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
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

On Tue, Oct 28, 2014 at 11:08:04AM +0400, Sergey Ryazanov wrote:
> 2014-10-27 21:04 GMT+03:00 John W. Linville <linville@tuxdriver.com>:
> > On Wed, Oct 22, 2014 at 03:03:49AM +0400, Sergey Ryazanov wrote:
> >> This reverts commit 093ec3c5337434f40d77c1af06c139da3e5ba6dc.
> >>
> >> AHB bus code has been removed, since we did not have support Atheros
> >> AR231x SoC, required for building the AHB version of ath5k. Now that
> >> support WiSoC chips added we can restore functionality back.
> >>
> >> Singed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> >> Cc: Jiri Slaby <jirislaby@gmail.com>
> >> Cc: Nick Kossifidis <mickflemm@gmail.com>
> >> Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> >> Cc: linux-wireless@vger.kernel.org
> >> Cc: ath5k-devel@lists.ath5k.org
> >
> > Acked-by: John W. Linville <linville@tuxdriver.com>
> >
> John, should I include these two patches in v3 or you already merge
> them in your tree?

I was intending to indicate to Ralf that I'm OK with him merging them
as part of the larger series in his tree.  I have not merged them.

John
-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
