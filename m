Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 22:21:55 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:57416 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493594Ab1AQVVv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 22:21:51 +0100
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=laptop)
        by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1PevU3-0000Df-MU; Mon, 17 Jan 2011 20:15:23 +0000
Received: by laptop (Postfix, from userid 1000)
        id 26CCD1033A271; Mon, 17 Jan 2011 21:16:04 +0100 (CET)
Subject: Re: [uclinux-dist-devel] [PATCH] sched: provide scheduler_ipi()
 callback in response to smp_send_reschedule()
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
        Linux-Arch <linux-arch@vger.kernel.org>
In-Reply-To: <AANLkTik3hE=_34Lbs944MzKpkNzqY+kCxpxmncUM2HB7@mail.gmail.com>
References: <1295262433.30950.53.camel@laptop>
         <AANLkTik3hE=_34Lbs944MzKpkNzqY+kCxpxmncUM2HB7@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Mon, 17 Jan 2011 21:16:03 +0100
Message-ID: <1295295363.30950.318.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Mon, 2011-01-17 at 14:49 -0500, Mike Frysinger wrote:
> On Mon, Jan 17, 2011 at 06:07, Peter Zijlstra wrote:
> > Also, while reading through all this, I noticed the blackfin SMP code
> > looks to be broken, it simply discards any IPI when low on memory.
> 
> not really.  see changelog of commit 73a400646b8e26615f3ef1a0a4bc0cd0d5bd284c.

Ah, indeed, it appears my tree was simply out of date, very good!
