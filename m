Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 03:54:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:29686 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225321AbULPDyf>; Thu, 16 Dec 2004 03:54:35 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id D1E5818772; Wed, 15 Dec 2004 19:54:23 -0800 (PST)
Message-ID: <41C106EF.9080000@mvista.com>
Date: Wed, 15 Dec 2004 19:54:23 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Avoid compile warnings on Sibyte using 2.6.10-rc3
References: <20041215235632.GA11386@prometheus.mvista.com> <41C0FCFD.9010603@realitydiluted.com> <41C100CB.2070000@mvista.com> <41C105BB.9020402@realitydiluted.com>
In-Reply-To: <41C105BB.9020402@realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

On a side note, I think this problem will appear on other arches as well 
when running in UP mode.

Thanks
Manish Lachwani


Steven J. Hill wrote:

> Manish Lachwani wrote:
>
>>
>> When did you last sync with CVS?  There was a change introduced :
>
> Literally 10 minutes ago and I did a fresh compile.
>
>> And if running Sibyte in UP mode, cpu_icache_snoops_remote_store is 
>> redefined
>>
> I do not run in UP mode, so that is why I did not see it. I suggest
> a different version attached. How does that work for you?
>
> -Steve
>
>------------------------------------------------------------------------
>
>Index: cpu-features.h
>===================================================================
>RCS file: /home/cvs/linux/include/asm-mips/cpu-features.h,v
>retrieving revision 1.9
>diff -u -r1.9 cpu-features.h
>--- cpu-features.h	7 Dec 2004 02:08:34 -0000	1.9
>+++ cpu-features.h	16 Dec 2004 03:42:03 -0000
>@@ -87,13 +87,13 @@
>  * that did the store so we can't optimize this into only doing the flush on
>  * the local CPU.
>  */
>-#ifdef CONFIG_SMP
> #ifndef cpu_icache_snoops_remote_store
>+#ifdef CONFIG_SMP
> #define cpu_icache_snoops_remote_store	(cpu_data[0].icache.flags & MIPS_IC_SNOOPS_REMOTE)
>-#endif
> #else
> #define cpu_icache_snoops_remote_store	1
> #endif
>+#endif
> 
> /*
>  * Certain CPUs may throw bizarre exceptions if not the whole cacheline
>  
>
