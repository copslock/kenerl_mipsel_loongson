Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 16:12:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36095 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012600AbbEOOM2GMJNu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 16:12:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FECSqt002462;
        Fri, 15 May 2015 16:12:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FECS3w002461;
        Fri, 15 May 2015 16:12:28 +0200
Date:   Fri, 15 May 2015 16:12:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] MIPS: BCM47XX: Fix regression in reading WiFi SoC SPROM
Message-ID: <20150515141228.GA2322@linux-mips.org>
References: <1431589370-30147-1-git-send-email-zajec5@gmail.com>
 <5554625C.4070403@imgtec.com>
 <CACna6ryk3AYUeh738nPmcOh1BLcn+VzaZ6p4hYJSZppWr=Ts2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6ryk3AYUeh738nPmcOh1BLcn+VzaZ6p4hYJSZppWr=Ts2A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47404
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

On Thu, May 14, 2015 at 11:18:57AM +0200, Rafał Miłecki wrote:

> On 14 May 2015 at 10:52, Markos Chandras <Markos.Chandras@imgtec.com> wrote:
> > On 05/14/2015 08:42 AM, Rafał Miłecki wrote:
> >> In the recent SPROM commit:
> >> MIPS: BCM47xx: Read board info for all bcma buses
> >> a proper handling of "fallback" argument has been dropped. Restore it.
> >>
> >> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> >> ---
> > if the "MIPS: BCM47xx: Read board info for all bcma buses" is not
> > upstream yet (I can't see it) it might make sense to fold this fix into
> > it and repost it as v2.
> 
> It's not upstream in Linus's tree, but it was already pushed by Ralf
> to his tree:
> http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=c6d94e9354139e8a0ef3bd3286b2a5ac30f8f6aa
> 
> I'll just let Ralf decide if he wants to rebase.

I've folded this patch into the original commit.  I put the original
and now the combined patch into my 4.2 queue so it won't go to Linus
for another few weeks anyway.  If this should go upstream for 4.1,
please lemme know.

  Ralf
