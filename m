Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 21:23:28 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33584 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492925AbZKVUXU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Nov 2009 21:23:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAMKNIER017259;
	Sun, 22 Nov 2009 20:23:18 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAMKNE1r017257;
	Sun, 22 Nov 2009 20:23:14 GMT
Date:	Sun, 22 Nov 2009 20:23:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ingo Molnar <mingo@elte.hu>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Add a high resolution sched_clock() via
	cnt32_to_63().
Message-ID: <20091122202314.GB1941@linux-mips.org>
References: <dae45f23b5d34f64fc60a445015e7dfe05aa0d07.1258875717.git.wuzhangjin@gmail.com> <20091122081328.GB24558@elte.hu> <4B0925BD.6070507@ru.mvista.com> <20091122180616.GB24711@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091122180616.GB24711@elte.hu>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 22, 2009 at 07:06:16PM +0100, Ingo Molnar wrote:

> >   MIPS's is not really a proper English. :-)
> 
> AFAIK 'MIPS' is not the plural of 'MIP' (but an acronym ending with 
> 'S'), hence the possessive form would be MIPS's.

MIPS Technologies' IP lawyers insist that MIPS is a proper name and not an
acronym - this position has certain advantages in trademark law.

Historically MIPS stood for Microprocessor without Interlocked Pipeline
Stages but technically may only have been true for the original Stanford
RISC processor but certainly not for the first commercial MIPS processor,
the R2000, which was released in 1985 which at least had some interlocks.

> It doesnt matter much i guess ;-)

Not to us because we're not trademark lawyers ;-)

  Ralf
