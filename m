Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 00:21:18 +0100 (CET)
Received: from hera.kernel.org ([140.211.167.34]:34424 "EHLO hera.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493121Ab0ACXVN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2010 00:21:13 +0100
Received: from htj.dyndns.org (localhost [127.0.0.1])
        by hera.kernel.org (8.14.3/8.14.3) with ESMTP id o03NJWeG010170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Sun, 3 Jan 2010 23:19:34 GMT
Received: from [127.0.0.2] (htj.dyndns.org [127.0.0.2])
        by htj.dyndns.org (Postfix) with ESMTPSA id CA8E110810A37;
        Mon,  4 Jan 2010 08:24:53 +0900 (KST)
Message-ID: <4B412745.9070307@kernel.org>
Date:   Mon, 04 Jan 2010 08:24:53 +0900
From:   Tejun Heo <tj@kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
MIME-Version: 1.0
To:     Arjan van de Ven <arjan@infradead.org>
CC:     Hui Zhu <teawater@gmail.com>,
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
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>        <4B411F14.1040302@kernel.org>   <20100103150134.5bdab023@infradead.org> <4B412341.2010002@kernel.org> <20100103151406.20228c3a@infradead.org>
In-Reply-To: <20100103151406.20228c3a@infradead.org>
X-Enigmail-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 25496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2049

On 01/04/2010 08:14 AM, Arjan van de Ven wrote:
>> Whichever one works but s2c wouldn't require symbol decoding.  Maybe
>> we can simply add an option to tell it to just parse the oops and
>> output it in machine friendly format.  Oh, also, the patch does add
>> new information the module load addresses.  We should be able to add
>> those to the oops message in a compact form.
> 
> actually one does not need those; you know the start address of the
> function already from the current oops output, and since you know the
> address of the function within the module as well, you know the start
> address of the module.

Right.  Thanks for the explanation.

-- 
tejun
