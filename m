Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 17:24:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:9721 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224893AbUJRQYU>; Mon, 18 Oct 2004 17:24:20 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id E726118581; Mon, 18 Oct 2004 09:24:09 -0700 (PDT)
Message-ID: <4173EE29.3070805@mvista.com>
Date: Mon, 18 Oct 2004 09:24:09 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Running RM9000 in SMP mode
References: <20041018150355.GP880@enix.org>
In-Reply-To: <20041018150355.GP880@enix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Thomas Petazzoni wrote:

>Hello,
>
>Has anyone tried to use the RM9000 processor in SMP mode ? Is code
>available for it ?
>
>Thanks,
>
>Thomas
>  
>
Hello Thomas

The Rm9000x2 revision 1.1 and 1.0 does not have support for the five 
state MOESI protocol and can only support SMP if appropriate hacks are 
applied to the memory management code. The revision 1.2 of the chip does 
support MOESI protocol and SMP. I am sure PMC can provide you with the 
necessary sources. Which board are you using?

Thanks
Manish Lachwani
