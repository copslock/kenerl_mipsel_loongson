Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 23:59:21 +0100 (CET)
Received: from hera.kernel.org ([140.211.167.34]:59269 "EHLO hera.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493268Ab0ADW7P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2010 23:59:15 +0100
Received: from htj.dyndns.org (localhost [127.0.0.1])
        by hera.kernel.org (8.14.3/8.14.3) with ESMTP id o04MwLhE018502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Mon, 4 Jan 2010 22:58:23 GMT
Received: from [127.0.0.2] (htj.dyndns.org [127.0.0.2])
        by htj.dyndns.org (Postfix) with ESMTPSA id 173F51079D629;
        Tue,  5 Jan 2010 08:03:51 +0900 (KST)
Message-ID: <4B4273D6.2010306@kernel.org>
Date:   Tue, 05 Jan 2010 08:03:50 +0900
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
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>        <4B411F14.1040302@kernel.org> <20100103150134.5bdab023@infradead.org>   <4B412341.2010002@kernel.org> <20100103151406.20228c3a@infradead.org> <daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>
In-Reply-To: <daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>
X-Enigmail-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 25512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2742

Hello,

On 01/05/2010 01:22 AM, Hui Zhu wrote:
> For the s2c, user just "s2c < message >core" It did everything with itself.
> After that, gdb vmlinux core.

It is true that by making the kernel oops message more verbose, s2c
can be made way simpler.  However, dependence on standard object tools
or perl is already assumed and avoiding it doesn't really buy
anything.  I really like the idea but unfortunately I'm doubtful that
it will be able to go upstream in the current form.  The suggested
solution (extending markup_oops.pl) won't be too much work, most of
functionality will remain the same and will have much higher chance of
getting included.

Thanks.

-- 
tejun
