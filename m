Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 10:15:08 +0000 (GMT)
Received: from mx2.mail.elte.hu ([157.181.151.9]:36306 "EHLO mx2.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S21103583AbZAOKPE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 10:15:04 +0000
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LNPFB-0006bA-2n
	from <mingo@elte.hu>; Thu, 15 Jan 2009 11:14:39 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 4256B3E21AA; Thu, 15 Jan 2009 11:14:27 +0100 (CET)
Date:	Thu, 15 Jan 2009 11:14:28 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Mike Travis <travis@sgi.com>
Cc:	Rusty Russell <rusty@rustcorp.com.au>,
	Yinghai Lu <yinghai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	IA64 <linux-ia64@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linux-am33-list@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	SPARC <sparclinux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: crash: IP: [<ffffffff80478092>] __bitmap_intersects+0x48/0x73
	[PATCH supplied]
Message-ID: <20090115101428.GG5833@elte.hu>
References: <496BF6D5.9030403@sgi.com> <20090113130048.GB31147@elte.hu> <496CAF5A.3010304@sgi.com> <496D0F46.2010907@sgi.com> <496D2172.6030608@sgi.com> <20090114165431.GA18826@elte.hu> <20090114165524.GA21742@elte.hu> <20090114175126.GA21078@elte.hu> <496E78BA.5040609@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496E78BA.5040609@sgi.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Mike Travis <travis@sgi.com> wrote:

> Ingo Molnar wrote:
> > also, with latest tip/master the ia64 cross-build still fails:
> > 
> > /home/mingo/tip/arch/ia64/kernel/irq_ia64.c: In function `ia64_handle_irq':
> > /home/mingo/tip/arch/ia64/kernel/irq_ia64.c:498: error: structure has no member named `irqs'
> > /home/mingo/tip/arch/ia64/kernel/irq_ia64.c:500: error: structure has no member named `irqs'
> > /home/mingo/tip/arch/ia64/kernel/irq_ia64.c: In function `ia64_process_pending_intr':
> > /home/mingo/tip/arch/ia64/kernel/irq_ia64.c:556: error: structure has no member named `irqs'
> > /home/mingo/tip/arch/ia64/kernel/irq_ia64.c:558: error: structure has no member named `irqs'
> > make[2]: *** [arch/ia64/kernel/irq_ia64.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > 
> > and so does the MIPS build:
> > 
> > /home/mingo/tip/arch/mips/sgi-ip22/ip22-int.c: In function 'indy_buserror_irq':
> > /home/mingo/tip/arch/mips/sgi-ip22/ip22-int.c:158: error: 'struct kernel_stat' has no member named 'irqs'
> > make[2]: *** [arch/mips/sgi-ip22/ip22-int.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > /home/mingo/tip/arch/mips/sgi-ip22/ip22-time.c: In function 'indy_8254timer_irq':
> > /home/mingo/tip/arch/mips/sgi-ip22/ip22-time.c:125: error: 'struct kernel_stat' has no member named 'irqs'
> > make[2]: *** [arch/mips/sgi-ip22/ip22-time.o] Error 1
> > make[1]: *** [arch/mips/sgi-ip22] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > 
> > 	Ingo
> 
> Hi Ingo,
> 
> This appears to be a fallout of the sparse irqs changes.  Here is a 
> suggested patch.
> 
> Btw, my ia64 build fails under tip/cpus4096 because this commit is not 
> present:
> 
> commit e65e49d0f3714f4a6a42f6f6a19926ba33fcda75
> Author: Mike Travis <travis@sgi.com>
> Date:   Mon Jan 12 15:27:13 2009 -0800
> 
>     irq: update all arches for new irq_desc

it is present:

 [mingo@hera tip]$ git log cpus4096 | grep e65e49d
 commit e65e49d0f3714f4a6a42f6f6a19926ba33fcda75

	Ingo
