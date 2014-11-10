Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 09:17:38 +0100 (CET)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:46286 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013170AbaKJIRge8lXO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 09:17:36 +0100
Received: from resomta-ch2-05v.sys.comcast.net ([69.252.207.101])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id DkHW1p0032Bo0NV01kHWYg; Mon, 10 Nov 2014 08:17:30 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-ch2-05v.sys.comcast.net with comcast
        id DkHV1p0090gJalY01kHV7F; Mon, 10 Nov 2014 08:17:30 +0000
Message-ID: <54607499.2070806@gentoo.org>
Date:   Mon, 10 Nov 2014 03:17:29 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP Help
References: <5457187D.6030708@gentoo.org>
In-Reply-To: <5457187D.6030708@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415607450;
        bh=v+fDI3eInnmS+J5vaj3d+wiGn02TQUa84QQZoarkJEM=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=GQAfIi5MNSeWtR98nFihR6WF588tJ/R6TEYWT80+sWMBgoM1OBclAiksmu4rX7fpx
         F/yjMJR9Esh/+A0jMYJw1foaKYg7ZUpoRjzG/hcNq09LUKzf6MIjjdmMA93FlAlcvg
         QxbvnyDJnbFb6dfJSxUw5iiWjUPxWWKEKAGCC8GrKC1/D4kFTg+XbNy51xuV0L3GjT
         aquH5V6/k+qd/F2LG9tGUjFNOeK5qve9/WF3RuzGFcZwfuBLI4QVihqZ6acpKz7RPm
         ZObPQIWj+r81pFwXAsiur0O1xEv9ONnKlCCYONdt7D1+IApnDp1/a675/NwyHB/Ayl
         QUB+vmnPus3QQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 11/03/2014 00:54, Joshua Kinard wrote:
> 
> I've recently acquired a dual R14000 CPU for the Octane, so I am trying to get
> SMP working again, but I can't get things setup properly.  I've attached both
> ip30-irq.c and ip30-smp.c -- does anyone see any immediate problems (or just
> where I am doing it wrong)?
> 
> Most reboot cycles with this code panics because init exited with a code of 0xa
> or 0xb (which matches w/ SIGSEGV or SIGBUS).  Randomly, I can acquire a dash
> shell by passing init=/bin/dash.  I can't do much in it, though.  A basic 'ls'
> either segfaults or triggers a SIGBUS.  If I execute 'ls' enough times, it
> eventually works.  Can't get much farther beyond that.

I take it no one has any feedback or tips on this?

I think one of the problems is I'm not syncing the CPU timers (IP7) correctly.
 The old IP30 SMP code used a timer broadcast trick yo do this, sharing a
single IRQ, #63.  However, 63 is one of the hardware error IRQs.  Still not
sure how that ever worked.

I've tried using the sync-r4k module...that just hangs in the sync function.
atomics seemed messed up (I wonder if PR61538 has something to do...).  Also
tried re-implementing the timer broadcast but that just hangs because the two
CPUs get into a deadlock situation w/ each trying to tell the other about the
timer broadcast event.  Not even sure if I should be using
spin_lock/spin_unlock or spin_lock_irqsave/spin_unlock_irqrestore for the HEART
irq code or SMP IRQ code.  Each MIPS SMP machine seems to use a completely
different mechanism in the kernel.  IP27 doesn't even enable the CPU timer
IRQs, it looks, and relies solely on the HUB timer present on each nodeboard.

So, yeah, out of ideas.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
