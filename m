Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 22:02:19 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11809 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492741Ab0EDUCN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 22:02:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4be07d500000>; Tue, 04 May 2010 13:02:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 4 May 2010 13:01:28 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 4 May 2010 13:01:28 -0700
Message-ID: <4BE07D13.6010105@caviumnetworks.com>
Date:   Tue, 04 May 2010 13:01:23 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost> <4BDF8092.1060401@paralogos.com>         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>         <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>         <4BE00207.6030506@paralogos.com>         <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>         <4BE0479E.6060506@paralogos.com>         <20100504184457.GA21929@linux-mips.org>         <k2s10f740e81005041228pea323400u89dfcefd4a5047d0@mail.gmail.com> <h2yf861ec6f1005041230p80a664e6o51296c106853d3fc@mail.gmail.com>
In-Reply-To: <h2yf861ec6f1005041230p80a664e6o51296c106853d3fc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2010 20:01:28.0189 (UTC) FILETIME=[9525F2D0:01CAEBC4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/04/2010 12:30 PM, Manuel Lauss wrote:
> On Tue, May 4, 2010 at 9:28 PM, Geert Uytterhoeven<geert@linux-m68k.org>  wrote:
>> On Tue, May 4, 2010 at 20:44, Ralf Baechle<ralf@linux-mips.org>  wrote:
>>> On Tue, May 04, 2010 at 09:13:18AM -0700, Kevin D. Kissell wrote:
>>>
>>>> What we used to use was what I *thought* was an old public domain
>>>> program whose name was an English word that had something to do with
>>>> being exacting.  Googling with obvious keywords didn't turn it up.
>>>
>>> Is it paranoia by any chance?  Paranoia is available as single files at:
>>>
>>>   http://www.math.utah.edu/~beebe/software/ieee/paranoia.c
>>>   http://www.math.utah.edu/~beebe/software/ieee/paranoia.h
>>
>> You also need
>>
>> http://www.math.utah.edu/~beebe/software/ieee/args.h
>>
>> Ran fine on:
>>   - Toshiba RBTX4927 (with FPU :-)
>>   - Mikrotik RouterBOARD 150 (without FPU), using an older 2.6.x OpenWRT kernel
>
> and runs into an endless loop around line 806 when built with
> a softfloat toolchain (gcc-4.4.3).
>

 From the point of view of this specific problem, using a softfloat 
toolchain isn't what you want to do.

The question is if the kernel's FP emulator is operating correctly,  if 
you never execute any FP instructions (due to the use of a softfloat 
toolchain), you would not be testing the emulator.

David Daney
