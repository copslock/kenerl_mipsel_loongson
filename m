Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 10:16:35 +0000 (GMT)
Received: from mx2.mail.elte.hu ([157.181.151.9]:15829 "EHLO mx2.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S21103656AbZAOKQc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 10:16:32 +0000
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LNPGu-00077H-4u
	from <mingo@elte.hu>; Thu, 15 Jan 2009 11:16:22 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id A07F33E21AA; Thu, 15 Jan 2009 11:16:15 +0100 (CET)
Date:	Thu, 15 Jan 2009 11:16:17 +0100
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
Message-ID: <20090115101617.GH5833@elte.hu>
References: <496BF6D5.9030403@sgi.com> <20090113130048.GB31147@elte.hu> <496CAF5A.3010304@sgi.com> <496D0F46.2010907@sgi.com> <496D2172.6030608@sgi.com> <20090114165431.GA18826@elte.hu> <20090114165524.GA21742@elte.hu> <20090114175126.GA21078@elte.hu> <496E78BA.5040609@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496E78BA.5040609@sgi.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.2.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4106]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Mike Travis <travis@sgi.com> wrote:

> Subject: irq: fix build errors referencing old kstat.irqs array

i've picked this up into tip/cpus4096, thanks Mike,

	Ingo
