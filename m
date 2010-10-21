Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 18:33:14 +0200 (CEST)
Received: from tvwna-ip-c-172.princeton.org ([66.180.187.89]:58034 "EHLO
        localhost.m.enhanced.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491133Ab0JUQdK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Oct 2010 18:33:10 +0200
Received: from camm by localhost.m.enhanced.com with local (Exim 4.69)
        (envelope-from <camm@maguirefamily.org>)
        id 1P8y4Z-0001ey-V9; Thu, 21 Oct 2010 12:32:59 -0400
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: recent SIGBUS/SIGSEGV mips kernel bug
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>
        <4C93993E.7030008@caviumnetworks.com>
        <8762y49k1k.fsf@maguirefamily.org>
        <4C93D86D.5090201@caviumnetworks.com>
        <87fwx4dwu5.fsf@maguirefamily.org>
        <4C97D9A1.7050102@caviumnetworks.com>
        <87lj6te9t1.fsf@maguirefamily.org>
        <4C9A8BC9.1020605@caviumnetworks.com>
        <4C9A9699.6080908@caviumnetworks.com>
        <87pqvbs7oa.fsf@maguirefamily.org>
        <4CB88D2C.8020900@caviumnetworks.com>
        <87r5fksxby.fsf_-_@maguirefamily.org>
        <4CBF1B1E.6050804@caviumnetworks.com>
        <8762wwlfen.fsf@maguirefamily.org>
        <4CC06826.2070508@caviumnetworks.com>
From:   Camm Maguire <camm@maguirefamily.org>
Date:   Thu, 21 Oct 2010 12:32:59 -0400
In-Reply-To: <4CC06826.2070508@caviumnetworks.com> (David Daney's message of "Thu\, 21 Oct 2010 09\:19\:50 -0700")
Message-ID: <87tykf7bgk.fsf@maguirefamily.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <camm@maguirefamily.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: camm@maguirefamily.org
Precedence: bulk
X-list: linux-mips

Greetings!

David Daney <ddaney@caviumnetworks.com> writes:

> On 10/20/2010 02:31 PM, Camm Maguire wrote:
>> Greetings!
>>
>> Does this suffice?
>>
>> (sid)camm@gabrielli:~/maxima-5.22.1/tests$ uname -a
>> Linux gabrielli 2.6.35.4-dsa-octeon #1 SMP Fri Sep 17 21:15:34 UTC 2010 mips64 GNU/Linux
>> (sid)camm@gabrielli:~/maxima-5.22.1/tests$ cat /proc/cpuinfo
>> system type		: CUST_WSX16 (CN3860p3.X-500-EXP)
>> processor		: 0
>> cpu model		: Cavium Octeon V0.3
> [...]
>
> Hah!  I have those things piled up all around me.
>
> No guarantees, but I will try to reproduce it.  If I can reproduce it,
> it should be easy to fix.
>
> David Daney
>

Thanks so much!  Please keep me posted.

Take care,

>
>
>
>

-- 
Camm Maguire			     		    camm@maguirefamily.org
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
