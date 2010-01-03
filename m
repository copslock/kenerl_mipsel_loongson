Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 17:48:48 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54619 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492718Ab0ACQsb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 17:48:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:In-Reply-To:
        Sender; bh=r+L+J69+MwErNcnBsD2EYJT9LGoy+x7NFeIRWyK7KOI=; b=kIFmC
        YlRVcgEDvmc+X9e2xQyWmGi7Ai4eO9RODIAsYvAUMvrzzmVAkUhrasW8KVAFBpvh
        HpyIE32BIekrzWcDgB+rJjvTH+uiVD4PDBAj1Lrs6ojvv9/L7jKTmfedUCvQ9hrW
        +Oe+Wa5hXZFQJWTqBtJ9gRIW68X/ljAmI2uMkY=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1NRTYv-0006xW-56; Sun, 03 Jan 2010 16:44:17 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1NRTYs-0005jl-Ph; Sun, 03 Jan 2010 16:44:14 +0000
Date:   Sun, 3 Jan 2010 16:44:14 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Hui Zhu <teawater@gmail.com>
Cc:     saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>, Tejun Heo <tj@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core
        file when kernel die
Message-ID: <20100103164414.GB21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> <20100103160313.GA21156@n2100.arm.linux.org.uk> <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1937

On Mon, Jan 04, 2010 at 12:30:20AM +0800, Hui Zhu wrote:
> This S2C: message just for program s2c.
> s2c can convert it to a core file.  Then gdb can do a clear analyse
> with this file.
> Then you can get more message than current we can get.

I understand that.  What I'm saying is that all the additional noise
you're causing the kernel to create is just a pure duplication of
what we already dump.

Oops dumps are already noisy enough - especially if they cause a panic
at the end (where you end up with two backtraces.)  We do not need even
more noise caused by needless duplication.

You can get everything you need already from the kernel.  On ARM, we
already dump out all the registers and the _full_ stack.  There is no
need for you to implement your own register dumping code and full stack
dump on top of that again.

So, I'm not going to accept your patch for the ARM kernel.  Please use
what's already provided - it's more than adequate.  By doing so, you
don't penalise those of us who want to read the raw oopses.

Talking about noisy oopses, I'm getting one with 2.6.33-rc2 on 'poweroff'
shutdown.  No idea what it is because most of it's scrolled off the top of
the screen and I can't scroll back.  Not bothered about it at the moment.
What it does illustrate though is why making things too noisy when problems
occur makes it _more_ difficult to find out what went wrong.
