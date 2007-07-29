Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 08:34:21 +0100 (BST)
Received: from il.qumranet.com ([82.166.9.18]:40143 "EHLO il.qumranet.com")
	by ftp.linux-mips.org with ESMTP id S20022634AbXG2HeT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Jul 2007 08:34:19 +0100
Received: from blast.qumranet.com (blast.qumranet.com [10.0.57.243])
	by il.qumranet.com (Postfix) with ESMTP id CC7DE250037;
	Sun, 29 Jul 2007 10:33:58 +0300 (IDT)
Message-ID: <46AC42E6.5010606@qumranet.com>
Date:	Sun, 29 Jul 2007 10:33:58 +0300
From:	Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
MIME-Version: 1.0
To:	Heiko Carstens <heiko.carstens@de.ibm.com>
CC:	Stephane Eranian <eranian@hpl.hp.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, mucci@cs.utk.edu,
	linux-mips@linux-mips.org, ak@suse.de, akpm@linux-foundation.org,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] MIPS: add smp_call_function_single()
References: <20070727124451.GC9828@frankl.hpl.hp.com> <20070727125533.GD5118@linux-mips.org> <20070727135323.GF9828@frankl.hpl.hp.com> <20070728091950.GA4642@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20070728091950.GA4642@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <avi@qumranet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avi@qumranet.com
Precedence: bulk
X-list: linux-mips

Heiko Carstens wrote:
> This will not do the right thing. Semantics of smp_call_function_single()
> changed recently. It now is supposed to call func() locally with irqs
> disabled if cpu == smp_processor_id(). See i386/x86_64 and powerpc.
> Unfortunately ia64 hasn't been changed yet, so it will behave differently.
>   

A patch for ia64 has been submitted, presumably it's somewhere in the 
pipeline.

-- 
error compiling committee.c: too many arguments to function
