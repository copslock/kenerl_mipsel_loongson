Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 20:28:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([63.81.120.158]:7479 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20038884AbWJCT2X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 20:28:23 +0100
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 711F31BB52; Tue,  3 Oct 2006 12:28:14 -0700 (PDT)
Message-ID: <4522B9CE.8060502@mvista.com>
Date:	Tue, 03 Oct 2006 12:28:14 -0700
From:	mlachwani <mlachwani@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To:	Manoj Ekbote <manoje@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Build error
References: <710F16C36810444CA2F5821E5EAB7F230A0FB6@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F230A0FB6@NT-SJCA-0752.brcm.ad.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Manoj Ekbote wrote:
> Hi,
>
> I see this error while compiling the latest sources:
>
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/mips/kernel/built-in.o: In function `do_gettimeofday':
> : undefined reference to `tickadj'
> arch/mips/kernel/built-in.o: In function `do_gettimeofday':
> : undefined reference to `tickadj'
> make: *** [.tmp_vmlinux1] Error 1
>
> There is no definition of tickadj anywhere in the tree. Is it supposed
> to be in kernel/time/ntp.c?
>
>
> /manoj
>
>
>
>   
I think you would need the GENERIC_TIME support enabled.

Thanks
Manish Lachwani
