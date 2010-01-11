Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2010 18:30:12 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1056 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492654Ab0AKRaI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jan 2010 18:30:08 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b4b5fbb0000>; Mon, 11 Jan 2010 09:28:30 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 11 Jan 2010 09:28:23 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 11 Jan 2010 09:28:23 -0800
Message-ID: <4B4B5FB7.3050701@caviumnetworks.com>
Date:   Mon, 11 Jan 2010 09:28:23 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Use non-overflowing arithmetic in sched_clock
References: <1262990856-8300-1-git-send-email-ddaney@caviumnetworks.com> <20100111102023.GE13886@linux-mips.org>
In-Reply-To: <20100111102023.GE13886@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2010 17:28:23.0395 (UTC) FILETIME=[79E7DB30:01CA92E3]
X-archive-position: 25567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7156

Ralf Baechle wrote:
> On Fri, Jan 08, 2010 at 02:47:36PM -0800, David Daney wrote:
> 
>> With typical mult and shift values, the calculation for Octeon's
>> sched_clock overflows when using 64-bit arithmetic.  Use 128-bit
>> calculations instead.
> 
> Applied though my first thought whenever I see extended precission math
> is gross - maybe we're going to find a better solution.  Hopefully!
> 
>   Ralf

I did have some apprehension myself.  However consider:

* For an 800MHz core clock, clocksource_set_clock() generates a shift 
value of 31.  This leads to overflow of 64-bit arithmetic approximately 
every 8 seconds.  This specific case could be reduced to a 2 bit shift, 
resulting in time to overflow of more than 100 years.  But one can 
imagine clock rates that would require large shifts.

* We need to return a 64-bit clock value, this will overflow in about 
500 years, Unless we are very careful with our arithmetic, we risk 
overflow in unacceptable short time periods.

* This is octeon specific and the 128-bit operation is cheap.  Probably 
cheaper than accounting for overflows in 64-bit arithmetic.

David Daney
