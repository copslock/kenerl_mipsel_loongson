Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 11:34:40 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40341 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903557Ab1KIKeg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 11:34:36 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9AYYu4028135;
        Wed, 9 Nov 2011 10:34:34 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9AYXDR028126;
        Wed, 9 Nov 2011 10:34:33 GMT
Date:   Wed, 9 Nov 2011 10:34:33 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Kernel hangs occasionally during boot.
Message-ID: <20111109103432.GA27378@linux-mips.org>
References: <y>
 <1320764341-4275-1-git-send-email-alcooperx@gmail.com>
 <20111108175532.GA15493@linux-mips.org>
 <4EBA2E65.3010009@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EBA2E65.3010009@niisi.msk.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7620

On Wed, Nov 09, 2011 at 11:40:21AM +0400, Gleb O. Raiko wrote:

> On 08.11.2011 21:55, Ralf Baechle wrote:
> >but we may need another hazard barrier to
> >replace back_to_back_c0_hazard().
> Urgently. We need some ticks to wait until counter state machine has
> been updated. The amount of ticks may occasionally be the same as in
> case of back_to_back_hazard for some cpus. It's completely different
> for others, I sure. Original compare_change_hazard waits up to 12
> ticks for r4k. While I don't think this amount should depend on
> irq_disable_hazard as old code assumes, we may still need 12 or so
> ticks for old cpus.

Hmm...  Looking at the R4000 manual which generall has the longest
pipeline hazards, mtc0 gets executed at stage 7, interrupts get sampled
at stage 3 meaning there is a (7 - 3 - 1) = 3 cycles hazard.  Does
that one statisfy your constraints?  Or are additional cycles needed
for a hazard that's generated outside of the CPU's pipeline?

  Ralf
