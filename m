Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 08:50:53 +0000 (GMT)
Received: from mx2.mail.elte.hu ([157.181.151.9]:16853 "EHLO mx2.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S20037669AbXA2Ius (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 08:50:48 +0000
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1HBSAV-0006mj-SF
	from <mingo@elte.hu>; Mon, 29 Jan 2007 09:47:24 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 792923E245A; Mon, 29 Jan 2007 09:46:40 +0100 (CET)
Date:	Mon, 29 Jan 2007 09:45:48 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Adrian Bunk <bunk@stusta.de>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Duncan <1i5t5.duncan@cox.net>, Neil Brown <neilb@suse.de>,
	mingo@redhat.com, linux-raid@vger.kernel.org,
	Dave Jones <davej@redhat.com>, cpufreq@lists.linux.org.uk,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	Jan Altenberg <jan@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Clayton <andrew@digital-domain.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.20-rc6: known regressions with patches
Message-ID: <20070129084548.GA10578@elte.hu>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org> <20070126181853.GO17836@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070126181853.GO17836@stusta.de>
User-Agent: Mutt/1.4.2.2i
Received-SPF: softfail (mx2: transitioning domain of elte.hu does not designate 157.181.1.14 as permitted sender) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0247]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Adrian Bunk <bunk@stusta.de> wrote:

> Subject    : ACPI: fix cpufreq regression
> References : http://lkml.org/lkml/2007/1/16/120
> Submitter  : Ingo Molnar <mingo@elte.hu>
> Caused-By  : Dave Jones <davej@redhat.com>
>              commit 0916bd3ebb7cefdd0f432e8491abe24f4b5a101e
> Handled-By : Ingo Molnar <mingo@elte.hu>
> Patch      : http://lkml.org/lkml/2007/1/16/120
> Status     : patch available

this is commit e4233dec749a3519069d9390561b5636a75c7579 meanwhile.

	Ingo
