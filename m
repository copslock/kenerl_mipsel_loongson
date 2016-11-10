Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 14:03:18 +0100 (CET)
Received: from Galois.linutronix.de ([146.0.238.70]:55781 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993076AbcKJNDLejg0P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2016 14:03:11 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1c4oyT-0007d9-UE; Thu, 10 Nov 2016 14:01:02 +0100
Date:   Thu, 10 Nov 2016 14:00:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        k@vodka.home.kg
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
In-Reply-To: <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611101351260.3501@nanos>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com> <alpine.DEB.2.20.1611092227200.3501@nanos> <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com> <alpine.DEB.2.20.1611100959040.3501@nanos>
 <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, 10 Nov 2016, Jason A. Donenfeld wrote:
> On Thu, Nov 10, 2016 at 10:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Does the slowdown come from the kmalloc overhead or mostly from the less
> > efficient code?
> >
> > If it's mainly kmalloc, then you can preallocate the buffer once for the
> > kthread you're running in and be done with it. If it's the code, then bad
> > luck.
> 
> I fear both. GCC can optimize stack variables in ways that it cannot
> optimize various memory reads and writes.

The question is how much of it is code and how much of it is the kmalloc.
 
> Strangely, the solution that appeals to me most at the moment is to
> kmalloc (or vmalloc?) a new stack, copy over thread_info, and fiddle
> with the stack registers. I don't see any APIs, however, for a
> platform independent way of doing this. And maybe this is a horrible
> idea. But at least it'd allow me to keep my stack-based code the
> same...

Do not even think about going there. That's going to be a major
mess.

As a short time workaround you can increase THREAD_SIZE_ORDER for now and
then fix it proper with switching to seperate irq stacks.

Thanks,

	tglx
