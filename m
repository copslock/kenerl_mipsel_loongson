Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2014 19:45:28 +0200 (CEST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:46587 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006810AbaJBRp0johog (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Oct 2014 19:45:26 +0200
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1XZkRB-0002sI-5l; Thu, 02 Oct 2014 13:45:09 -0400
Received: from linville-x1.hq.tuxdriver.com (localhost.localdomain [127.0.0.1])
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.6) with ESMTP id s92HbmrG019941;
        Thu, 2 Oct 2014 13:37:48 -0400
Received: (from linville@localhost)
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.8/Submit) id s92Hbkm4019940;
        Thu, 2 Oct 2014 13:37:46 -0400
Date:   Thu, 2 Oct 2014 13:37:46 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath5k-devel@venema.h4ckr.net
Subject: Re: [PATCH 15/16] ath5k: update dependencies
Message-ID: <20141002173746.GB12208@tuxdriver.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
 <1411929195-23775-16-git-send-email-ryazanov.s.a@gmail.com>
 <20140930172044.GE11919@tuxdriver.com>
 <CAHNKnsSNO3-mzcKcGdnxEndbq6y_Pr0Gqrv2dMVCZZssgqMnWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNKnsSNO3-mzcKcGdnxEndbq6y_Pr0Gqrv2dMVCZZssgqMnWA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42931
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

On Wed, Oct 01, 2014 at 06:41:34PM +0400, Sergey Ryazanov wrote:
> 2014-09-30 21:20 GMT+04:00 John W. Linville <linville@tuxdriver.com>:
> > This patch does not seem to apply to wireless-next.  What tree is it
> > based upon?
> >
> > John
> >
> Its based on linux-mips. I thought that ath5k was not changed in
> recent time and did not  rebase patch on top of wireless-next.
> 
> John, could you delay patch merging? There is an idea to rename ar231x
> in ath25, to be consistent with ath79 for AR71xx/AR9xxx.

OK

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
