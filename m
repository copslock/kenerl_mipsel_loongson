Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 08:55:21 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:33849 "EHLO www.tglx.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490978Ab1A0HzS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jan 2011 08:55:18 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
        by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id p0R7sxk0009803
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 27 Jan 2011 08:55:02 +0100
Date:   Thu, 27 Jan 2011 08:54:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org
Subject: Re: [patch 3/9] mips: Replace deprecated spinlock initialization
In-Reply-To: <20110124124215.GA3133@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1101270854480.31804@localhost6.localdomain6>
References: <20110123143631.392446736@linutronix.de> <20110123143837.128260362@linutronix.de> <20110124124215.GA3133@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.3 at www.tglx.de
X-Virus-Status: Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Mon, 24 Jan 2011, Ralf Baechle wrote:

> Thanks, applied.
> 
>   Ralf
> 

I take it through core/locking in tip as well, because further
cleanups depend on it. Git will sort out the identical changes.

Thanks,

        tglx
