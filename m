Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 20:37:50 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16891 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225298AbUK3Uhn>; Tue, 30 Nov 2004 20:37:43 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id DDCCC185EE; Tue, 30 Nov 2004 12:37:40 -0800 (PST)
Message-ID: <41ACDA14.3050808@mvista.com>
Date: Tue, 30 Nov 2004 12:37:40 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: SB1250 Swarm IDE problems...
References: <41A8D9C2.7060804@realitydiluted.com>
In-Reply-To: <41A8D9C2.7060804@realitydiluted.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Steven J. Hill wrote:
> Hey guys.
> 
> Using the latest 2.6 kernel, IDE on the Swarm board kills the
> kernel with a bus error. I have not sat down to debug it yet,
> but I was curious if anyone else was aware of this and at
> what point it became broken. Thanks.
> 
> -Steve
> 
Hi Steve,

I had sent a patch earlier to get the IDE on SWARM working. It has not 
been applied as yet. Currently, I am using 2.6.10 and IDE is working 
well on this board (after applying this patch). I will resend the patch 
shortly

Thanks
Manish Lachwani
