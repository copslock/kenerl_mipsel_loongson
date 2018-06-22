Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 15:42:47 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:34663 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990474AbeFVNmkM7jK3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 15:42:40 +0200
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWMKi-0005yy-OV; Fri, 22 Jun 2018 15:42:36 +0200
Date:   Fri, 22 Jun 2018 15:42:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] time: Make sure jiffies_to_msecs() preserves non-zero
 time periods
In-Reply-To: <CAMuHMdW9FUMQ568GTJG_p9J8jFbVLOR6hPhsxsaMTttQjp=Wzw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806221539380.2402@nanos.tec.linutronix.de>
References: <20180622075421.16001-1-geert@linux-m68k.org> <alpine.DEB.2.21.1806221446230.2402@nanos.tec.linutronix.de> <CAMuHMdW9FUMQ568GTJG_p9J8jFbVLOR6hPhsxsaMTttQjp=Wzw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-787096374-1529674956=:2402"
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-787096374-1529674956=:2402
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 22 Jun 2018, Geert Uytterhoeven wrote:
> On Fri, Jun 22, 2018 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 22 Jun 2018, Geert Uytterhoeven wrote:
> > > For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> > > of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> > > time period.
> > >
> > > However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
> > > 1200, as used on alpha and DECstation), jiffies_to_msecs() may return
> > > zero for small non-zero time periods.  This may break code that relies
> > > on receiving back a non-zero value.
> > >
> > > jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> > > not support values of HZ larger than 12287, thus rejecting any
> > > problematic huge values of HZ.
> >
> > Sorry, I'm not understanding that sentence at all.
> 
> Sorry for being unclear.
> 
> 1 jiffy can only be less than 1µs if HZ > 1000000.
> But include/linux/jiffies.h checks if HZ >= 12288, and does #error otherwise.
> In addition, there's a "BUILD_BUG_ON(HZ > USEC_PER_SEC)" in time.c

Hmm, ok. Care to reword?

> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > This lacks a stable tag, right?
> 
> Up to the maintainer to add, isn't it?

Yes and no. At least a hint that this has been broken by commit X or has
been broken forever would be appreciated.

Thanks,

	tglx
--8323329-787096374-1529674956=:2402--
