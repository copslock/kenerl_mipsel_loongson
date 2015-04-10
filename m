Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2015 20:17:35 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:56174 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006987AbbDJSRdVEbs3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2015 20:17:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id E5D715A722F;
        Fri, 10 Apr 2015 21:17:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 85v-0YG0C8J9; Fri, 10 Apr 2015 21:17:18 +0300 (EEST)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 2ED1D5BC005;
        Fri, 10 Apr 2015 21:17:29 +0300 (EEST)
Date:   Fri, 10 Apr 2015 21:17:28 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH RFC v2] MIPS: add support for vmlinux.bin appended DTB
Message-ID: <20150410181728.GC569@fuloong-minipc.musicnaut.iki.fi>
References: <1405162157-30357-1-git-send-email-jogo@openwrt.org>
 <CAOiHx=mS-CSE-rM7nWxoRwO9twYiO2F4ObMf9ZVLo1oskZVKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=mS-CSE-rM7nWxoRwO9twYiO2F4ObMf9ZVLo1oskZVKLg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Fri, Aug 08, 2014 at 08:39:48PM +0200, Jonas Gorski wrote:
> On Sat, Jul 12, 2014 at 12:49 PM, Jonas Gorski <jogo@openwrt.org> wrote:
> > (snip)
> > diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> > index 3b46f7c..8009530 100644
> > --- a/arch/mips/kernel/vmlinux.lds.S
> > +++ b/arch/mips/kernel/vmlinux.lds.S
> > @@ -127,6 +127,12 @@ SECTIONS
> >         }
> >
> >         PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
> > +
> > +#ifdef CONFIG_MIPS_APPENDED_DTB
> > +       __appended_dtb = .;
> > +       /* leave space for appended DTB */
> > +       . = . + 0x100000;
> > +#endif
> 
> Okay, this won't work for non SMP kernels - PERCPU is empty there, so
> the actual binary end is then __mips_machine_end, not __per_cpu_end
> (unless mips_machine_end happens to satisfty the per_cpu alignment
> requirements).
> 
> So back to the drawing board.

Any news? Would it work just by not defining PERCPU on non-SMP builds?

A.
