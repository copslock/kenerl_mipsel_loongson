Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 13:03:19 +0000 (GMT)
Received: from mx1.redhat.com ([66.187.233.31]:32913 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20038564AbXA2NDP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 13:03:15 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l0TCxRvw016446;
	Mon, 29 Jan 2007 07:59:27 -0500
Received: from gelk.kernelslacker.org (vpn-248-1.boston.redhat.com [10.13.248.1])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0TCxN6N013740;
	Mon, 29 Jan 2007 07:59:26 -0500
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.13.8/8.13.8) with ESMTP id l0TCxM3a025007;
	Mon, 29 Jan 2007 07:59:23 -0500
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.13.8/8.13.8/Submit) id l0TCwuoP025004;
	Mon, 29 Jan 2007 07:58:56 -0500
X-Authentication-Warning: gelk.kernelslacker.org: davej set sender to davej@redhat.com using -f
Date:	Mon, 29 Jan 2007 07:58:55 -0500
From:	Dave Jones <davej@redhat.com>
To:	Ingo Molnar <mingo@elte.hu>
Cc:	Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Duncan <1i5t5.duncan@cox.net>, Neil Brown <neilb@suse.de>,
	mingo@redhat.com, linux-raid@vger.kernel.org,
	cpufreq@lists.linux.org.uk, lenb@kernel.org,
	linux-acpi@vger.kernel.org, Jan Altenberg <jan@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Clayton <andrew@digital-domain.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.20-rc6: known regressions with patches
Message-ID: <20070129125855.GA30599@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Duncan <1i5t5.duncan@cox.net>, Neil Brown <neilb@suse.de>,
	mingo@redhat.com, linux-raid@vger.kernel.org,
	cpufreq@lists.linux.org.uk, lenb@kernel.org,
	linux-acpi@vger.kernel.org, Jan Altenberg <jan@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Clayton <andrew@digital-domain.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org> <20070126181853.GO17836@stusta.de> <20070129084548.GA10578@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070129084548.GA10578@elte.hu>
User-Agent: Mutt/1.4.2.2i
Return-Path: <davej@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davej@redhat.com
Precedence: bulk
X-list: linux-mips

On Mon, Jan 29, 2007 at 09:45:48AM +0100, Ingo Molnar wrote:
 > 
 > * Adrian Bunk <bunk@stusta.de> wrote:
 > 
 > > Subject    : ACPI: fix cpufreq regression
 > > References : http://lkml.org/lkml/2007/1/16/120
 > > Submitter  : Ingo Molnar <mingo@elte.hu>
 > > Caused-By  : Dave Jones <davej@redhat.com>
 > >              commit 0916bd3ebb7cefdd0f432e8491abe24f4b5a101e
 > > Handled-By : Ingo Molnar <mingo@elte.hu>
 > > Patch      : http://lkml.org/lkml/2007/1/16/120
 > > Status     : patch available
 > 
 > this is commit e4233dec749a3519069d9390561b5636a75c7579 meanwhile.

Thanks for pushing this on in my absense btw.
FWIW, it has my belated ACK :)
I've asked for it to be in 19.3 too as the same bug exists there.

		Dave

-- 
http://www.codemonkey.org.uk
