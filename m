Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 21:14:30 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:4377
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133592AbVJQUOJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Oct 2005 21:14:09 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 17 Oct 2005 13:14:02 -0700
Message-ID: <43540609.4000105@avtrex.com>
Date:	Mon, 17 Oct 2005 13:14:01 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: OProfile cannot be loaded as module...
References: <43470BCF.1070709@avtrex.com> <20051013225520.GA3234@linux-mips.org>
In-Reply-To: <20051013225520.GA3234@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2005 20:14:02.0110 (UTC) FILETIME=[50CC29E0:01C5D357]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Oct 07, 2005 at 04:59:11PM -0700, David Daney wrote:
> 
> 
>>arch/mips/oprofile/common.c defines several symbols (op_model_mipsxx and 
>>op_model_rm9000) with __attribute__((weak)).  It then assumes that ELF 
>>linking conventions will prevail and there will be no problems if they 
>>are undefined.
>>
>>The problem is if you try to load oprofile as a module.  The kernel 
>>module linker evidentially does not understand weak symbols and refuses 
>>to load the module because they are undefined.
> 
> 
> Actually it contains code to handle weak symbols so this is a bit
> surprising not last because STB_WEAK handling happen in the generic
> module loader code and is being used by other architectures as well.
> 
> So if there's a problem with the module loader I'd prefer to solve that
> instead of starting to kludge around it.
> 

Fine, but what exactly are the semantics of __attribute__((weak)) in 
modules?  It gets resolved when linking with other objects that make up 
the module.  But what if the weak symbol can be resolved at module load 
time against symbols in either the kernel proper or other modules?  What 
happens if the weak symbol can be resolved by a symbol in a module that 
is loaded after the one with the weak symbol?  Does it get fixed up when 
the new module is loaded?


> What compiler exactly are you using btw?
> 

GCC-3.4.3 / binutils 2.16.91 20050817

David Daney.
