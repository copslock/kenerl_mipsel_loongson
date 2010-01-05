Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2010 10:15:45 +0100 (CET)
Received: from hera.kernel.org ([140.211.167.34]:44599 "EHLO hera.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490985Ab0AEJPh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2010 10:15:37 +0100
Received: from htj.dyndns.org (localhost [127.0.0.1])
        by hera.kernel.org (8.14.3/8.14.3) with ESMTP id o059EnFn024251
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 5 Jan 2010 09:14:51 GMT
Received: from [127.0.0.2] (htj.dyndns.org [127.0.0.2])
        by htj.dyndns.org (Postfix) with ESMTPSA id 8FC5D1006343A;
        Tue,  5 Jan 2010 18:20:23 +0900 (KST)
Message-ID: <4B430457.5020906@kernel.org>
Date:   Tue, 05 Jan 2010 18:20:23 +0900
From:   Tejun Heo <tj@kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
MIME-Version: 1.0
To:     Hui Zhu <teawater@gmail.com>
CC:     Arjan van de Ven <arjan@infradead.org>,
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
        file when kernel die
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>        <4B411F14.1040302@kernel.org> <20100103150134.5bdab023@infradead.org>   <4B412341.2010002@kernel.org> <20100103151406.20228c3a@infradead.org>   <daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>   <4B4273D6.2010306@kernel.org> <daef60381001050104u5d4adf11k16bec2406501fbd2@mail.gmail.com>
In-Reply-To: <daef60381001050104u5d4adf11k16bec2406501fbd2@mail.gmail.com>
X-Enigmail-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 25515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3136

Hello,

On 01/05/2010 06:04 PM, Hui Zhu wrote:
> I agree with read the current stack message is better.
> 
> About the extending, I have some question with it:
> 1.  markup_oops.pl have itself idea, it try use dmesg| markup_oops.pl
> show what happen to usr.  This is different with s2c.
> I am not sure people like it have other function with it.  Too much
> part of this file need to be change.  It need rewrite, just the oops
> message parse part can be keep.

Yeah, I think you'll need to refactor it and share only the parsing
frontend.  Just adding a switch (-m or whatever) which puts it into
machine-friendly translator mode should do the trick.

> 2.  I use perl to work in a long time before, I know it good at parse
> the text, but I am not sure it good at handle struct like:

You don't need to handle the data structure at all.  Just make it
parse the dmesg and output machine-friendly formatted output which can
be processed by s2c.  ie. just make it do the reformatting.

> Even if what happen, I will keep a c s2c with myself.  :)

That will be sad.  I really want it too.  :-)

Thanks.

-- 
tejun
