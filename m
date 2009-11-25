Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 17:19:44 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52724 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493095AbZKYQTl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 17:19:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAPGJse2010928;
        Wed, 25 Nov 2009 16:19:54 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAPGJqUR010926;
        Wed, 25 Nov 2009 16:19:52 GMT
Date:   Wed, 25 Nov 2009 16:19:52 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Kevin Hickey <khickey@netlogicmicro.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: EARLY_PRINTK: Fixup of dependency
Message-ID: <20091125161952.GB10490@linux-mips.org>
References: <1259055230-15818-1-git-send-email-wuzhangjin@gmail.com> <f861ec6f0911240824u187347d6od5bfebc509a27d8d@mail.gmail.com> <20091124163006.GA11277@linux-mips.org> <1259160138.4675.14.camel@kh-d280-64> <1259165736.13740.7.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259165736.13740.7.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 26, 2009 at 12:15:36AM +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> Date:   Thu, 26 Nov 2009 00:15:36 +0800
> To: Kevin Hickey <khickey@netlogicmicro.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>,
> 	Manuel Lauss <manuel.lauss@googlemail.com>,
> 	Linux-MIPS <linux-mips@linux-mips.org>
> Subject: Re: [PATCH] MIPS: EARLY_PRINTK: Fixup of dependency
> Content-Type: text/plain; charset="UTF-8"
> 
> On Wed, 2009-11-25 at 08:42 -0600, Kevin Hickey wrote:
> > On Tue, 2009-11-24 at 16:30 +0000, Ralf Baechle wrote:
> > > On Tue, Nov 24, 2009 at 05:24:57PM +0100, Manuel Lauss wrote:
> > > 
> > > > On Tue, Nov 24, 2009 at 10:33 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > > > [...]
> > > > > This patch will only enable that option when the DEBUG_KERNEL is
> > > > > enabled.
> > > > 
> > > > How about making it independent from DEBUG_KERNEL altogether?  If find
> > > > it useful even without full debug info.
> > 
> > I agree with Manuel here.  I often build release kernels that benefit
> > from EARLY_PRINTK.  Why not make EARLY_PRINTK a selectable option in the
> > config?  Coupling it to DEBUG_KERNEL seems confusing. 
> 
> Hello,
> 
> Ralf have moved the EARLY_PRINTK to Kconfig.debug and removed the
> dependency on DEBUG_KERNEL in his -queue repository ;) Just as the X86
> and some other ARCHs does:
> 
> http://www.linux-mips.org/git?p=linux-queue.git
> 
> [...]
> +config EARLY_PRINTK
> +       bool "Early printk" if EMBEDDED
> +       depends on SYS_HAS_EARLY_PRINTK
> +       default y
> [...]
> 
> So, it is okay now, please ignore this patch ;)

Okay, dropped then.

Thanks!

  Ralf
