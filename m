Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 22:14:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27379 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225479AbUC3VO6>;
	Tue, 30 Mar 2004 22:14:58 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA20757;
	Tue, 30 Mar 2004 13:14:53 -0800
Message-ID: <4069E34B.1080608@mvista.com>
Date: Tue, 30 Mar 2004 13:14:51 -0800
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Lees <bob@diamond.demon.co.uk>
CC: linux-mips@linux-mips.org
Subject: Re: Frequency (cpu speed) control on AU1100
References: <200403302137.38123.bob@diamond.demon.co.uk>
In-Reply-To: <200403302137.38123.bob@diamond.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Bob Lees wrote:

>Hi All
>
>I am working on an AU1100 board (Aurora) from DSP Design and want to control 
>the processor cpu speed, as in CPU_FREQ, type control.  I suspect I am 
>missing something somewhere, but I can't find any references to cpu speed 
>control for the MIPS processors, specically the au1x range.
>
>Any clues?
>  
>
I assume you mean dynamically? Or at boot time only?

There is an Au1x power management implementation that I haven't tested 
in a while. It allows you to scale the frequency using sysctl, if I 
remember correctly.

Pete
