Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 07:57:37 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:62680 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225192AbTB0H5h>;
	Thu, 27 Feb 2003 07:57:37 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h1R7urUe016564;
	Wed, 26 Feb 2003 23:56:53 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA19746;
	Wed, 26 Feb 2003 23:56:51 -0800 (PST)
Message-ID: <003501c2de36$b27c8360$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Greg Lindahl" <lindahl@keyresearch.com>,
	<linux-mips@linux-mips.org>
References: <20030227005338.GB2077@greglaptop.internal.keyresearch.com>
Subject: Re: volatile question
Date: Thu, 27 Feb 2003 09:03:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> In the mips, mips64, and even the i386 arch, arch/kernel/smp.c has
> this in smp_call_function:
> 
>         spin_lock(&call_lock);
>         call_data = &data;
> 
>         /* Send a message to all other CPUs and wait for them to respond */
>         for (i = 0; i < smp_num_cpus; i++)
>                 if (i != cpu)
>                         core_send_ipi(i, SMP_CALL_FUNCTION);
> 
> call_data isn't volatile, it's a plain static *. So how can we be sure
> that "call_data = &data" does anything other than change a register?
> 
> The i386 has a wb() after the assignment; we don't even have that.

call_data is neither local nor static to the function, so the modification
of the storage location would seem to be mandatory for the compiler
before the call to core_send_ipi(), so I can see how the code, as written, 
would generally work on most MIPS CPUs.  However, it would be legal 
for the compiler to defer the store until *just* before the invocation of 
core_send_ipi(), and on moderately complex,  high-ILP processors 
it seems to me like the wb() might well be necessary.  I take it that
you've observed a problem with this on your system?:
