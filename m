Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2007 21:22:05 +0000 (GMT)
Received: from gateway-1237.mvista.com ([63.81.120.158]:59092 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28646200AbXABVWB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jan 2007 21:22:01 +0000
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 7E8B51C5C1; Tue,  2 Jan 2007 13:21:54 -0800 (PST)
Message-ID: <459ACCF2.5000500@mvista.com>
Date:	Tue, 02 Jan 2007 13:21:54 -0800
From:	mlachwani <mlachwani@mvista.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
Subject: Re: Running linux-2.6.18 kernel in uncache area
References: <30660.40204.qm@web7910.mail.in.yahoo.com>
In-Reply-To: <30660.40204.qm@web7910.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

sathesh babu wrote:
> Hi,
>   I would like to know is there any configuration option ( using make 
> menuconfig)  to turn off cache in linux-2.6.18 kernel.
>  
> Basically i would like to run kernel in uncache area.
>  
> I see there is an option in the in the menuconfig under 
> Kernel hacking
>              [ ] Run uncached (NEW)
> Sould i need to enable this  option to run in the uncahe area?
>  
> Could you please tell me how to disable cache and run the kernel in 
> uncache area.
>  
>  
>  
> Regards,
> Sathesh
>
> Send free SMS to your Friends on Mobile from your Yahoo! Messenger. 
> Download Now! http://messenger.yahoo.com/download.php
>
That should be it. Did you try with that option MIPS_UNCACHED enabled?

thanks,
Manish Lachwani
