Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 22:09:31 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:4817 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133612AbWDGVJW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 22:09:22 +0100
Received: (qmail 20930 invoked from network); 8 Apr 2006 01:22:18 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2006 01:22:18 -0000
Message-ID: <4436D74F.3040108@ru.mvista.com>
Date:	Sat, 08 Apr 2006 01:19:11 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Pete Popov <ppopov@embeddedalley.com>,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH] Fix swap entry for MIPS32 36-bit physical address
References: <B482D8AA59BF244F99AFE7520D74BF9609D4F2@server1.RightHand.righthandtech.com> <4433C9EE.8030402@ru.mvista.com> <4436C301.2060001@ru.mvista.com>
In-Reply-To: <4436C301.2060001@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylyov wrote:

>>    Additionally, PTEs in MIPS32R2 should have the same layout for the 
>> 36-bit physical address case as in MIPS32R1, according to the 
>> architecture manuals -- so, fix the #ifdef's.

>    I've decided to tead off that part (incomplete anyway) and move it to 
> a separate patch which I'll post shortly.

    I'm really not sure that we need that #if defined(CONFIG_CPU_MIPS32) -- it 
renders CONFIG_64BIT_PHYS_ADDR non-working on all other 32-bit CPUs for which 
Kconfig entry claims that this support exists:

config 64BIT_PHYS_ADDR
         bool "Support for 64-bit physical address space"
         depends on (CPU_R4X00 || CPU_R5000 || CPU_RM7000 || CPU_RM9000 || 
CPU_R10000 || CPU_SB1 || CPU_MIPS32 || CPU_MIPS64) && 32BIT

    At least RM7000 has the same PTE layout as MIPS32, I guess the others also 
do. I suspect that the intent was to limit this option to the Alchemy CPUs 
where it's *really* necessary?

WBR, Sergei
