Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 12:45:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55823 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823114Ab3F1Kp4r86YS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 12:45:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5SAjpBa010015;
        Fri, 28 Jun 2013 12:45:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5SAjnlr010014;
        Fri, 28 Jun 2013 12:45:49 +0200
Date:   Fri, 28 Jun 2013 12:45:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maxim Uvarov <muvarov@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Wladislav Wiebe <wladislav.kw@gmail.com>,
        david.daney@cavium.com, davem@davemloft.net,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: Octeon: fix for held reboot_mutex lock at
 task exit time
Message-ID: <20130628104548.GL10727@linux-mips.org>
References: <519DDF8D.70700@gmail.com>
 <519E4C3C.7010400@gmail.com>
 <CAJGZr0KRAJty5+hY77e8s50NmK5jLq8zNQ_r6fz9LOVpPo_WCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJGZr0KRAJty5+hY77e8s50NmK5jLq8zNQ_r6fz9LOVpPo_WCA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37199
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

Sorry for the late reply - this ended up in the moderator queue for the
mailing list and I rarely look at it - it's tens of thousands of emails!
  
On Thu, May 23, 2013 at 11:58:34PM +0400, Maxim Uvarov wrote:

> >> diff --git a/arch/mips/cavium-octeon/**setup.c b/arch/mips/cavium-octeon/
> >> **setup.c
> >> index b0baa29..04ce396 100644
> >> --- a/arch/mips/cavium-octeon/**setup.c
> >> +++ b/arch/mips/cavium-octeon/**setup.c
> >> @@ -457,6 +457,10 @@ static void octeon_halt(void)
> >>         }
> >>
> >>         octeon_kill_core(NULL);
> >> +
> >> +       /* We stop here */
> >> +       while (1)
> >> +               ;
> >>
> >
> > I want to put a WAIT here so we don't burn so much power.
> >
> > I will send a patch to do that instead.
> >
> >
> what about adding wait for other mips boards where is while (1) is used?

Many platforms have their own variants of eternal loops, some using
just "while (1);", others trying to save power using the WAIT instruction.
I was planing to work through all of them and come up with a common
defaut implementation.

  Ralf
