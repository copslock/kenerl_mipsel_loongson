Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 17:35:45 +0000 (GMT)
Received: from mx2.mail.elte.hu ([157.181.151.9]:50614 "EHLO mx2.mail.elte.hu")
	by ftp.linux-mips.org with ESMTP id S21365245AbZAORfl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 17:35:41 +0000
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LNW7Z-0007hn-HY
	from <mingo@elte.hu>; Thu, 15 Jan 2009 18:35:15 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 9B88D3E21AA; Thu, 15 Jan 2009 18:35:05 +0100 (CET)
Date:	Thu, 15 Jan 2009 18:35:06 +0100
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
Message-ID: <20090115173506.GB22472@elte.hu>
References: <20090113130048.GB31147@elte.hu> <496CAF5A.3010304@sgi.com> <496D0F46.2010907@sgi.com> <496D2172.6030608@sgi.com> <20090114165431.GA18826@elte.hu> <20090114165524.GA21742@elte.hu> <20090114175126.GA21078@elte.hu> <496E78BA.5040609@sgi.com> <20090115101428.GG5833@elte.hu> <496F67D8.4060507@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496F67D8.4060507@sgi.com>
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
X-archive-position: 21752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Mike Travis <travis@sgi.com> wrote:

> Non-working tree:
> 
>  21> git-describe
> v2.6.29-rc1-19-g92296c6
> 
>  22> git-status

why do you use git-dash commands? Latest git does not have them. Maybe you 
have an older Git version?

	Ingo
