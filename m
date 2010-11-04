Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 20:11:19 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17673 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491118Ab0KDTLQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Nov 2010 20:11:16 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cd305780000>; Thu, 04 Nov 2010 12:11:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 4 Nov 2010 12:11:50 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 4 Nov 2010 12:11:50 -0700
Message-ID: <4CD30551.1000006@caviumnetworks.com>
Date:   Thu, 04 Nov 2010 12:11:13 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Robert Millan <rmh@gnu.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
References: <1288873119.12965.1@thorin> <4CD2E2F7.4090701@caviumnetworks.com>   <4CD2EE64.5060404@aurel32.net> <AANLkTik3SH8EmhcgY9HNQLLk9Np+E6LGo8jVoGQiQCx4@mail.gmail.com>
In-Reply-To: <AANLkTik3SH8EmhcgY9HNQLLk9Np+E6LGo8jVoGQiQCx4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Nov 2010 19:11:50.0317 (UTC) FILETIME=[2234BDD0:01CB7C54]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/04/2010 11:43 AM, Robert Millan wrote:
> Hi!
>
> David Daney a écrit :
>> You are claiming that all loongson2 are loongson-2f.  Is that really
>> true?  Or are there other types of loongson2 that are not loongson-2f?
>>
>> You need to be very careful here.  This is part of the userspace ABI, so
>> if you get it wrong, you are stuck with it forever.
>
> I'll figure out how to distinguish them and send a new patch.
>
>> One question you didn't address is why userspace would care that it is
>> running on exactly "loongson-2f" instead of just mips4.
>
> I think Aurelien answered this.
>
>> The __elf_platform gets converted to a directory name by ld.so, so you
>> may want to choose a value without '-' in it.
>
> Well I appreciate consistency with GCC flag names, so I'd rather keep
> the dash, but then again it's not my decision to make.  In any case,
> whoever commits this can adjust the name to his/her liking.

I don't like to put words into Ralf's mouth, but it is easier to work 
with patches that have been tested and are ready to go, rather than 
having to re-write everything.


Some of the strings in use are "i686", "x86_64", "octeon", "octeon2", 
"PARISC", "PARISC32", tilegx-m32", "v4l", "v3l", "v4b", and "v3b", these 
last for for ARM and they don't match the GCC -mcpu= values.

So I guess what ever you want.

David Daney
