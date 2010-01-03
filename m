Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 23:59:46 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:48589 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493116Ab0ACW7l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 23:59:41 +0100
Received: from c-24-20-218-92.hsd1.or.comcast.net ([24.20.218.92] helo=localhost.localdomain)
        by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
        id 1NRZPb-0000kG-Uu; Sun, 03 Jan 2010 22:59:04 +0000
Date:   Sun, 3 Jan 2010 15:01:34 -0800
From:   Arjan van de Ven <arjan@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Hui Zhu <teawater@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        saeed bishara <saeed.bishara@gmail.com>,
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
        Brian Gerst <brgerst@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core
 file   when kernel die
Message-ID: <20100103150134.5bdab023@infradead.org>
In-Reply-To: <4B411F14.1040302@kernel.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
        <4B411F14.1040302@kernel.org>
Organization: Intel
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.16.6; i586-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by casper.infradead.org
        See http://www.infradead.org/rpr.html
X-archive-position: 25493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arjan@infradead.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2038

On Mon, 04 Jan 2010 07:49:56 +0900
Tejun Heo <tj@kernel.org> wrote:
> 
> If implementing parsing of oops message in C is too awkward
> (unsurprising at all), maybe implementing a converter in perl or
> python is the easiest way so that it takes the oops message and puts
> out well formatted input for the s2c program?

you mean like scripts/markup_oops.pl ?



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
