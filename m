Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Oct 2009 16:02:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51847 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492953AbZJCOCv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Oct 2009 16:02:51 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n93E3q3N032212;
	Sat, 3 Oct 2009 16:03:53 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n93E3noB032210;
	Sat, 3 Oct 2009 16:03:49 +0200
Date:	Sat, 3 Oct 2009 16:03:49 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Wolfram Sang <w.sang@pengutronix.de>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
Message-ID: <20091003140349.GA11381@linux-mips.org>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com> <20091002105903.GC3179@pengutronix.de> <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com> <20091002125423.GD3179@pengutronix.de> <f861ec6f0910020732p2ff76990q1e7a2bca16e52e64@mail.gmail.com> <20091003102221.GB24206@pengutronix.de> <f861ec6f0910030449q635360ct12d6c47cfb24670d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f0910030449q635360ct12d6c47cfb24670d@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 03, 2009 at 01:49:42PM +0200, Manuel Lauss wrote:

> On Sat, Oct 3, 2009 at 12:22 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> >> > Yeah, I saw that you want to remove it, still I don't know why :) Is it feature
> >> > incomplete and updating is impossible? Is the concept outdated? Could you
> >> > enlighten me on that?
> >>
> >> I started out with the intention to fix its styling issues, add carddetect irq
> >> support, etc.  In the end it was easier to write a quick-and-dirty standalone
> >> full-features socket driver for the DB1200 and extend it to support the
> >> other DB/PB boards. While I was at it I modified my driver for the xxs1500,
> >> that's all.
> >
> > Okay, that explains.
> >
> >>
> >> The only *technical* reason I have is a personal dislike for how the current
> >> one works: it forces every conceivable board to add dozens of cpp macros
> >> for mem/io ranges and gets registered by board-independent code.
> >> Hardly convincing, I know.
> >
> > Well, you have the (to me) pretty convincing technical argument that your
> > drivers provide more features and less crashes which is a clear benefit for
> > users. If we remove the generic au1000-part, then it might even be in the same
> > amount in LoC. Okay, we lose a bit of maintainability if a bug is found in a
> > section which was shared among the former users of generic, as it has to be
> > updated for each of the three drivers, but well... Are there any plans to
> > convert pb1x00 as well?
> 
> The new db1xxx_ss.c already supports all boards pb1x00 is supposed to,
> except for the PB1000 (the very first Alchemy devboard), which has a
> rather awkward carddetect irq scheme, so I kept the au1000_pb1x00.c
> for it.  Unfortunately I don't have this board to test on, and *if* there are
> any linux users with this board, they choose to remain silent (the driver
> hasn't built for it in years, so go figure).  I'd rather get rid of
> PB1000 support
> altogether...
> 
> 
> > Maybe I find time to look a bit more into it, but I can't test anything, of
> > course, so the more additional comments/test-reports the better.
> 
> Thanks.  As I mentioned, the db1xxx_ss part works on my Db1200/Db1300
> boards; I don't have any others to test on.

Deending on the urgency you assign to these patches I can keep them in
my queue for 2.6.33 and push them upstream for linux-next.

  Ralf
