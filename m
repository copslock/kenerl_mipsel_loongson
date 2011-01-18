Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2011 19:19:11 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10441 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491062Ab1ARSTE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jan 2011 19:19:04 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d35d9c50000>; Tue, 18 Jan 2011 10:19:49 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 18 Jan 2011 10:19:00 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 18 Jan 2011 10:19:00 -0800
Message-ID: <4D35D98F.60407@caviumnetworks.com>
Date:   Tue, 18 Jan 2011 10:18:55 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Amker.Cheng" <amker.cheng@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: about oprofile callgraph on linux-mips
References: <AANLkTin+TzF2QtbfRi8Ltqwp97ME-JtuwwEBn8cYt1zS@mail.gmail.com>
In-Reply-To: <AANLkTin+TzF2QtbfRi8Ltqwp97ME-JtuwwEBn8cYt1zS@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2011 18:19:00.0408 (UTC) FILETIME=[2DC64380:01CBB73C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/17/2011 07:01 PM, Amker.Cheng wrote:
> Hi,
>      Previously I have run oprofile on linux-mips and have two
> questions about it.
>      It seems that oprofile does not support callgraph on linux-mips
> currently, since there is no
> backtrace function in oprofile kernel module for mips target.
>      Is it possible or easy to support callgraph on mips target? If I
> am right, it's some kind of
> difficult to calculate stack frames of interrupted user space
> programs, at least for O32 ABI.
>

By default, most MIPS code doesn't use frame pointers.  This makes 
generating an accurate stack trace either very difficult or impossible.

If you compile *all* your user space code with -fno-omit-framepointer, 
you could write a fairly simple stack walker.  Otherwise you have to do 
code analysis to try to get a stack trace, and that is quite complex, 
and at in some cases impossible.

> Any tips would be appriciated. thanks.

I wrote a userspace o32 stack trace generator once and posted it to 
java-patches@gcc.gnu.org.  If you search for it you might find it.

David Daney
