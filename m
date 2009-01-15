Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 16:46:44 +0000 (GMT)
Received: from relay3.sgi.com ([192.48.171.31]:15533 "EHLO relay.sgi.com")
	by ftp.linux-mips.org with ESMTP id S21365943AbZAOQql (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 16:46:41 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [150.166.39.100])
	by relay3.corp.sgi.com (Postfix) with ESMTP id 910E2AC015;
	Thu, 15 Jan 2009 08:46:32 -0800 (PST)
Received: from [134.15.31.35] (vpn-2-travis.corp.sgi.com [134.15.31.35])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id n0FGkQF5014487;
	Thu, 15 Jan 2009 08:46:27 -0800
Message-ID: <496F6862.5070104@sgi.com>
Date:	Thu, 15 Jan 2009 08:46:26 -0800
From:	Mike Travis <travis@sgi.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
MIME-Version: 1.0
To:	Ingo Molnar <mingo@elte.hu>
CC:	Rusty Russell <rusty@rustcorp.com.au>,
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
References: <496BF6D5.9030403@sgi.com> <20090113130048.GB31147@elte.hu> <496CAF5A.3010304@sgi.com> <496D0F46.2010907@sgi.com> <496D2172.6030608@sgi.com> <20090114165431.GA18826@elte.hu> <20090114165524.GA21742@elte.hu> <20090114175126.GA21078@elte.hu> <496E78BA.5040609@sgi.com> <20090115101617.GH5833@elte.hu>
In-Reply-To: <20090115101617.GH5833@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <travis@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: travis@sgi.com
Precedence: bulk
X-list: linux-mips

Ingo Molnar wrote:
> * Mike Travis <travis@sgi.com> wrote:
> 
>> Subject: irq: fix build errors referencing old kstat.irqs array
> 
> i've picked this up into tip/cpus4096, thanks Mike,
> 
> 	Ingo

I sent it as a patch because I wasn't sure if you wanted in the
cpus4096 branch or the sparseirqs branch.

Thanks,
Mike
