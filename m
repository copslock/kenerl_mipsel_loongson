Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 23:39:01 +0100 (BST)
Received: from gateway-1237.mvista.com ([63.81.120.158]:12376 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20027614AbWJJWjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 23:39:00 +0100
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 78A9C1BA8A; Tue, 10 Oct 2006 15:38:52 -0700 (PDT)
Message-ID: <452C20FC.6000705@mvista.com>
Date:	Tue, 10 Oct 2006 15:38:52 -0700
From:	mlachwani <mlachwani@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
Subject: Re: calibrate_delay function
References: <1160520180.6521.29.camel@sandbar.kenati.com>
In-Reply-To: <1160520180.6521.29.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ashlesha Shintre wrote:
> Hi,
> I m working on the Encore M3 board that has the AU1500 MIPS processor on
> it.  I aim to port the 2.6 linux kernel to the board which is already
> supported in the 2.4 kernel.
>
> The start_kernel function in linux/init/main.c file, calls a function
> calibrate_delay found in the arch/frv/kernel/setup.c file.  Why does the
> kernel call this function which is a part of the Fujitsu FR-V
> architecture?  
>
> When I build the image, this is the point where the kernel is stuck and
> the last contents of the log buffer show the following printk message
> from the calibrate_delay function:
>
>
>   
>> Calibrating delay loop...
>>     
>
> Thanks,
> Ashlesha.
>
>
>
>
>   
start_kernel() calls calibrate_delay() which can be found in 
init/calibrate.c

thanks,
Manish Lachwani
