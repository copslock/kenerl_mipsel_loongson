Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 23:48:33 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:59712 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992123AbdBJWs04iEMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 23:48:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=ysE0EvnEYXZrtanBtXqYPxjjZtLPy1QdHCDif9qoBRE=; b=PYpaZ3tiVPaRYpvypF8sUA4JDT
        /jNDWue3vXUk+SfRvrDpiKWQZ1RVV/Iwl7jEGKsORcQhZGazaE1RQ4wB6zAei8JHVzQTQcuzVdWZb
        9Znt6fwU6T0qGb205ctUDs7DGJxNLop6eXhf0K5YtRgA4kzD/PUIFSq+dDahfYLXQlfAhKiwBsOVm
        gcOercYeZCV+9KDPy+dOgyVQmqIbAY3hDnVa1NT4bkK4tkn/OblnqxGMgZT/89UlOPUX2j85CK7Yg
        r07R0KMM/OTFfEIr7Bujh+1plUJSqRk6RnMNVqA8eGuN9puhj7SLN+gQy+Wl781EhsorU0t2Kg9Tk
        tunVrT6A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44328 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1ccJzH-000HK8-SN; Fri, 10 Feb 2017 22:48:20 +0000
Date:   Fri, 10 Feb 2017 14:48:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Crash in -next due to 'MIPS: Add cacheinfo support'
Message-ID: <20170210224819.GA6552@roeck-us.net>
References: <20170208234523.GA13263@roeck-us.net>
 <CAJx26kWDuH2AbibrOdHi7yh9YG314T7J5Zz7CwgTrZCfwDGuYw@mail.gmail.com>
 <eee97bba-5386-9d78-1c82-9e9753a28920@roeck-us.net>
 <20170210094011.GB24226@jhogan-linux.le.imgtec.org>
 <20170210103952.GC24226@jhogan-linux.le.imgtec.org>
 <20170210174644.GA15372@roeck-us.net>
 <6360d767-39f9-ad9b-6ca4-cb16c617e3cc@gmail.com>
 <20170210221152.GA20435@roeck-us.net>
 <20170210223932.GA9246@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170210223932.GA9246@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Feb 10, 2017 at 10:39:32PM +0000, James Hogan wrote:
> > 
> > > and essentially Justin's commit just made problem 1) to occur, but is
> > > not the root cause of the crash you are seeing?
> > 
> > That would not necessarily be my conclusion. Of course, the code appears
> > to be heavily SMP related, so it may well be that it exposes some
> > problem associated with cache handling or support in non-SMP configurations.
> > 
> > Of course, it might also be possible that there is a qemu problem somewhere
> > which only manifests itself on non-SMP mips images with Justin's commit
> > applied. That appears to be somewhat unlikely, though I have no hard data
> > supporting this guess.
> > 
> > I'll do some more testing and try to find the actual crash location.
> > Tricky though since it almost looks like there is a not completely
> > initialized workqueue. Making things worse, the problem "goes away"
> > if I add some debug log into process_one_work(), meaning there may
> > be a heisenbug.
> 
> cracked it by moving around an early return error. populate_cache()
> macro has multiple statements with no do while (0) around it. The
> c->scache.waysize condition in populate_cache_leaves then only
> conditionalises the first statement in the macro and in absense of l2
> (or l3 for that matter) it'll continue to write beyond the end of the
> array allocated in detect_cache_attributes(). Badness ensues.
> 
Outch. Yes, after you mention it, the problem is easy to see.

> The SMP calls in arch/mips/kernel/cacheinfo.c file are pretty redundant
> too since all the cache info is read from the cpu info structures.
> 
> I'll write a patch. Thanks for reporting Guenter!
> 
Thank you for tracking it down!

Guenter
