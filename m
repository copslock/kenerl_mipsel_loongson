Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 17:51:37 +0100 (BST)
Received: from gateway-1237.mvista.com ([63.81.120.158]:24388 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20038552AbWJRQvd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 17:51:33 +0100
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 5C1F51BE45; Wed, 18 Oct 2006 09:51:26 -0700 (PDT)
Message-ID: <45365B8E.8040704@mvista.com>
Date:	Wed, 18 Oct 2006 09:51:26 -0700
From:	mlachwani <mlachwani@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: start_kernel(): bug: interrupts were enabled early
References: <20061018155009.GA22031@deprecation.cyrius.com>
In-Reply-To: <20061018155009.GA22031@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> I see the following message when I boot a 2.6.18 kernel on a SWARM
> board:
>
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> Using 512.000 MHz high precision timer.
> start_kernel(): bug: interrupts were enabled early <--
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
>
> Has anyone else seen this?
>   
Yes, I do see it. I have a patch for it as well. Will send it out shortly.

The issue is the on_each_cpu() calls made in arch/mips/mm/c-sb1.c. This 
function enables the interrupts on exit. As a result, you will get this 
error
on bootup. The fix is  similar to arch/mips/mm/c-r4k.c, i.e. to have 
something like r4k_on_each_cpu().

Thanks,
Manish Lachwani
