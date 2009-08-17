Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Aug 2009 18:20:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13114 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492961AbZHQQUQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Aug 2009 18:20:16 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a89830e0000>; Mon, 17 Aug 2009 12:19:26 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 17 Aug 2009 09:19:25 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 17 Aug 2009 09:19:25 -0700
Message-ID: <4A89830B.40904@caviumnetworks.com>
Date:	Mon, 17 Aug 2009 09:19:23 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	keshav yadav <keshav.yadav2005@gmail.com>
CC:	linux-mips@linux-mips.org, binutils <binutils@sourceware.org>
Subject: Re: Fwd: mips 16 bit compilation lead to crash
References: <9651e57b0908160650s2b81e48bod8fc1d50c19c8e5b@mail.gmail.com> <9651e57b0908160721g4d9893bfrcd1afcb66f3b28d1@mail.gmail.com>
In-Reply-To: <9651e57b0908160721g4d9893bfrcd1afcb66f3b28d1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2009 16:19:25.0905 (UTC) FILETIME=[7D0BBC10:01CA1F56]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The proper forum for this question is binutils@sourceware.org (now CCed).

keshav yadav wrote:
> ---------- Forwarded message ----------
> From: keshav yadav <keshav.yadav2005@gmail.com>
> Date: Sun, Aug 16, 2009 at 7:20 PM
> Subject: mips 16 bit compilation lead to crash
> To: gcc-help@gcc.gnu.org, gcc-help@gnu.org
> 
> 
> Hi all,
> 
> I want to use MIPS 16 bit instruction similar to ARM thumb mode. But i
> am getting error
> 
> #mips-gcc   -mips16   -o test.o test.c
> 
> /tmp/ccJFGlL0.s: Assembler messages:
> /tmp/ccJFGlL0.s:17: Internal error!
> Assertion failure in macro_build_lui at ../../gas/config/tc-mips.c line 3142
> 
> 1. Is there problem in toolchain i have made ?
> 2. is i am giving 16 bit option to gcc correctly.
> 

Your report is lacking important information:

1) Which versions of the tools are you using.

2) A self contained test case.  (The contents of test.c).

Because of those deficiencies, it is impossible to answer your questions.

David Daney
