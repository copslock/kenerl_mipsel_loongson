Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2004 05:41:46 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:24310 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225192AbUJYEll>; Mon, 25 Oct 2004 05:41:41 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 5883418569; Sun, 24 Oct 2004 21:41:39 -0700 (PDT)
Message-ID: <417C8403.3060009@mvista.com>
Date: Sun, 24 Oct 2004 21:41:39 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnzhan@sinovee.com
Cc: linux-mips@linux-mips.org
Subject: Re: status about RM9122
References: <002d01c4ba3e$f29d99d0$0300a8c0@bigshot>
In-Reply-To: <002d01c4ba3e$f29d99d0$0300a8c0@bigshot>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

johnzhan@sinovee.com wrote:
> Hi, folks,
> Could you tell me the status about RM9122/9222 porting?
> RM9000 series is PMC-sierra mip64 CPU.
> I have searched whole archives, but I could not get any thread about that.
> Did anyone know that?
> 1 start point.
> 2 current status
> 3 how about SMP kernel on RM9222
> 
> 
> thanks a lot.
> 
> 
> --
> John Zhan.

Hello !

Rm9122/Rm9222 code is under CONFIG_CPU_RM9000. The 2.4 version of the 
kernel supports all IO and SMP support for this core. I am sure PMC will 
be able to provide you with the sources.

If you are interested in 2.6, then get the latest sources from 
Linux-MIPS CVS and try to compile for CONFIG_CPU_RM9000.

Let me know if you are looking for something specific

Thanks
Manish Lachwani
