Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 11:08:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46130 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992121AbcJYJI16Zv1m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Oct 2016 11:08:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u9P98OLD018572;
        Tue, 25 Oct 2016 11:08:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u9P98MwW018571;
        Tue, 25 Oct 2016 11:08:22 +0200
Date:   Tue, 25 Oct 2016 11:08:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     SF Markus Elfring <elfring@users.sourceforge.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 4/4] MIPS/kernel/proc: Combine four seq_printf() calls
 into one call in show_cpuinfo()
Message-ID: <20161025090822.GB4795@linux-mips.org>
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
 <61796ee0-b3b8-53a6-d29d-487c89145fc1@users.sourceforge.net>
 <CAMuHMdXn2gss2MRP7j1pAcmcXL_VivGQqMw1mAu-PUaRxGER0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXn2gss2MRP7j1pAcmcXL_VivGQqMw1mAu-PUaRxGER0w@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55564
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

On Tue, Oct 25, 2016 at 10:55:42AM +0200, Geert Uytterhoeven wrote:

> > -       seq_printf(m, "shadow register sets\t: %d\n",
> > -                     cpu_data[n].srsets);
> > -       seq_printf(m, "kscratch registers\t: %d\n",
> > -                     hweight8(cpu_data[n].kscratch_mask));
> > -       seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
> > -       seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
> > +       seq_printf(m,
> > +                  "shadow register sets\t: %d\n"
> > +                  "kscratch registers\t: %d\n"
> > +                  "package\t\t\t: %d\n"
> > +                  "core\t\t\t: %d\n",
> > +                  cpu_data[n].srsets,
> > +                  hweight8(cpu_data[n].kscratch_mask),
> > +                  cpu_data[n].package,
> > +                  cpu_data[n].core);
> 
> I think the code is much easier to read with separate seq_printf()s for
> each line printed.

Which is why I originally implemented this as separate function calls.
Code size and performance are hardly an argument for /proc/cpuinfo.

  Ralf
