Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 12:20:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58581 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006858AbaHZKUHPFdvL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Aug 2014 12:20:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7QAK4tu022477;
        Tue, 26 Aug 2014 12:20:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7QAK4HX022476;
        Tue, 26 Aug 2014 12:20:04 +0200
Date:   Tue, 26 Aug 2014 12:20:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
Message-ID: <20140826102004.GA22221@linux-mips.org>
References: <53FC5300.4070902@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53FC5300.4070902@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Aug 26, 2014 at 05:27:28AM -0400, Joshua Kinard wrote:

> Okay, so from the "make kmap cache coloring aware" thread, I've been playing
> with larger PAGE_SIZE values on the Octane and O2 for the last few hours.
> 16k and 64k used to, in the past, never get far after init (usually died
> *at* init)  That appears to have changed now.  Most programs seem to
> JustWork(), but very randomly, I am getting a signal -4, illegal instruction
> (SIGILL) on the Octane.  Both systems are running kernels w/ 64k PAGE_SIZE
> at the moment.
> 
> I cannot reproduce it on demand, so I'm not really sure what the cause could
> be.  PAGE_SIZE should be largely transparent to userland these days, so I am
> wondering if this might be more oddities w/ an R14000 CPU.

This sound very unlikely as the CPU was primarily designed to run IRIX and
SGI's systems were using 16k or even 64k page size.

What userland are you running and how old is it?  Are you seeing different
results for 16k and 64k?

  Ralf
