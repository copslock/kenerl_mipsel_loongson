Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 22:35:38 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56826 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225746AbVDRVfX>; Mon, 18 Apr 2005 22:35:23 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id DDDE218C23; Mon, 18 Apr 2005 14:35:16 -0700 (PDT)
Message-ID: <42642814.8040701@mvista.com>
Date:	Mon, 18 Apr 2005 14:35:16 -0700
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jun Sun <jsun@junsun.net>
Cc:	Pavel Kiryukhin <vksavl@cityline.ru>, linux-mips@linux-mips.org
Subject: Re: Preemption in do_cpu      (Re: [PATCH]Preemption patch for 2.6)
References: <1098468403.4266.42.camel@prometheus.mvista.com> <1807918959.20050418133246@cityline.ru> <20050418212021.GA12996@gw.junsun.net>
In-Reply-To: <20050418212021.GA12996@gw.junsun.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

>On Mon, Apr 18, 2005 at 01:32:46PM +0400, Pavel Kiryukhin wrote:
>  
>
>>Hi,
>>the preempt_disable/preempt_enable sequence in do_cpu() [traps.c]
>>exists quite long (patch submitted in Oct. 2004), so it should be nothing
>>wrong there.
>>
>>Can somebody please comment why use of preempt_disable/enable in do_cpu
>>will not result in "scheduling while atomic" for fpu-less cpu (with enabled
>>preemption).
>>
>>The sequence looks like
>>
>>do_cpu()
>>| preempt_disable()
>>| fpu_emulator_cop1Handler()
>>| | cond_reshed()
>>| | | schedule()  <------ scheduling while atomic
>>
>>
>>The proposed patch was tested for Sibyte, but it has fpu (AFAIK) and has no
>>fpu_emulator_cop1Handler called.
>>
>>    
>>
>
>fpu_emulator maintains global variables and in general is dangerous
>to be preempted in the middle of processing.
>
>The quick fix for this problem is probably to move preemption disabling/
>enabling inside fpu_emulator_cop1Handler().
>
>Better fix is probably to modify fpu emulator so that it is preemption
>safe overall.
>
>Jun
>  
>
Missed this one ! I had a patch that enables preemption before the 
cond_resched and disables right after it. I forgot to send it to 
linux-mips though. But, I needed it to work on fpu-less CPU. My bad.

Thanks
Manish Lachwani
