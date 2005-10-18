Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 16:46:45 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:58895
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133619AbVJRPqZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 16:46:25 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Oct 2005 08:46:20 -0700
Message-ID: <435518CC.3060403@avtrex.com>
Date:	Tue, 18 Oct 2005 08:46:20 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: OProfile cannot be loaded as module...
References: <43470BCF.1070709@avtrex.com> <20051013225520.GA3234@linux-mips.org> <43540609.4000105@avtrex.com> <20051018110355.GB2656@linux-mips.org>
In-Reply-To: <20051018110355.GB2656@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2005 15:46:20.0931 (UTC) FILETIME=[16007D30:01C5D3FB]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 17, 2005 at 01:14:01PM -0700, David Daney wrote:

>>Fine, but what exactly are the semantics of __attribute__((weak)) in 
>>modules?  It gets resolved when linking with other objects that make up 
>>the module.  But what if the weak symbol can be resolved at module load 
>>time against symbols in either the kernel proper or other modules?
> 
> 
> Yes.
> 
> 
>>What happens if the weak symbol can be resolved by a symbol in a module
>>that is loaded after the one with the weak symbol?  Does it get fixed up
>>when the new module is loaded?
> 
> 
> No, it won't - and I don't think that would be a good idea.  The potencial
> for bugs is just too large.
> 

Given your 'yes' and 'no' answers, the behavior of a module could depend 
on the order in which the modules are loaded, as they can be linked 
differently depending on which modules are already present.

That doesn't seem like a good way of doing things.

If if were up to me (and I know that it is not), I would disallow 
linking of weak symbols at module load time altogether.

David Daney.
