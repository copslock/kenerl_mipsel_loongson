Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2014 19:36:28 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34218 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007500AbaL1Sg13hM4I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Dec 2014 19:36:27 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2501B81E5E; Sun, 28 Dec 2014 19:36:26 +0100 (CET)
Date:   Sun, 28 Dec 2014 19:36:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
Message-ID: <20141228183625.GE3922@amd>
References: <1418849927.28384.1.camel@perches.com>
 <alpine.DEB.2.11.1412190031530.17382@nanos>
 <1418951658.28384.20.camel@perches.com>
 <yw1x388ch0su.fsf@unicorn.mansr.com>
 <1418954914.25129.1.camel@perches.com>
 <yw1xy4q4exo9.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xy4q4exo9.fsf@unicorn.mansr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
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

On Fri 2014-12-19 10:33:42, Måns Rullgård wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > On Fri, 2014-12-19 at 01:43 +0000, Måns Rullgård wrote:
> >> What exactly are you proposing to remove?
> >
> > Optionally compile out
> > kernel/printk/printk.c:early_printk()
> > even if CONFIG_EARLY_PRINTK is enabled.
> >
> >> I see no unused code related
> >> to early printk (in any variant) under arch/mips.
> >
> > I think there could be yet another CONFIG option
> > to specifically enable the early_printk function
> > for the arches that use it.
> 
> Why bother?  On MIPS it would save 132 bytes of compiled code.
> 
> > The kernel/printk/early_printk() function seems
> > used only by arm/microblaze/tile/x86.
> 
> Rather than introduce more config complexity, you could try to remove
> the 7 remaining uses of early_printk().
> 
> - arch/arm/mach-socfpga
>   Single early_printk("Early printk initialized\n") call serving no
>   apparent purpose can probably be safely deleted.  Since there are no
>   other early_printk() calls, this information seems rather useless.

Feel free to do that, but please keep early_printk() available...

...so that I can debug the socfpga early boot when needed.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
