Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 18:14:17 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37326 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493095Ab0ACRON (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 18:14:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:In-Reply-To:
        Sender; bh=b+KVeDGTRxna6nYooZMgog5WYVnkYOhgfICoDw9iu+A=; b=KkfNs
        dnGA6JhGjTAm0iWTAGwBaQPzK8gC4UmufAvwDVwZa2jRnJjAUVO6M2P5zsj+rm81
        eImVOFYhyZZ2zGzXHqktveEFCmB4MK/zhD4WZ77iXmZdZIiRMO7kKcR5KZUvjxP+
        ArIzkpUBB0ry1K2/bt8zViIG/Tim3O7UoBuHek=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1NRTy4-00070N-Tp; Sun, 03 Jan 2010 17:10:17 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1NRTy2-0005sb-Ch; Sun, 03 Jan 2010 17:10:14 +0000
Date:   Sun, 3 Jan 2010 17:10:13 +0000
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
Message-ID: <20100103171013.GC21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> <20100103160313.GA21156@n2100.arm.linux.org.uk> <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com> <20100103164414.GB21156@n2100.arm.linux.org.uk> <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1952

On Mon, Jan 04, 2010 at 12:55:04AM +0800, Hui Zhu wrote:
> I didn't give the user raw oopses.
> I give him core file. When the kernel die, do we can get a core file now?

I think there's a communication issue here... clearly you're not
understanding what I've been trying to tell you.

I don't think I can help you any further.
