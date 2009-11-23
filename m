Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 09:43:10 +0100 (CET)
Received: from mx3.mail.elte.hu ([157.181.1.138]:47259 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492424AbZKWInE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 09:43:04 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1NCUVR-0008JF-S0
	from <mingo@elte.hu>; Mon, 23 Nov 2009 09:42:53 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 681D93E22E1; Mon, 23 Nov 2009 09:42:42 +0100 (CET)
Date:	Mon, 23 Nov 2009 09:42:41 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
Message-ID: <20091123084241.GA23635@elte.hu>
References: <dae45f23b5d34f64fc60a445015e7dfe05aa0d07.1258875717.git.wuzhangjin@gmail.com>
 <20091122081328.GB24558@elte.hu>
 <4B0925BD.6070507@ru.mvista.com>
 <20091122180616.GB24711@elte.hu>
 <20091122202314.GB1941@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091122202314.GB1941@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.2.5
	_SUMMARY_
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sun, Nov 22, 2009 at 07:06:16PM +0100, Ingo Molnar wrote:
> 
> > >   MIPS's is not really a proper English. :-)
> > 
> > AFAIK 'MIPS' is not the plural of 'MIP' (but an acronym ending with 
> > 'S'), hence the possessive form would be MIPS's.
> 
> MIPS Technologies' IP lawyers insist that MIPS is a proper name and 
> not an acronym - this position has certain advantages in trademark 
> law.

That too seems to support my point that "MIPS's" is the right spelling.

	Ingo
