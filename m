Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 23:23:57 +0200 (CEST)
Received: from gateway16.websitewelcome.com ([69.56.185.3]:44416 "HELO
        gateway16.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492741Ab0EDVXw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 23:23:52 +0200
Received: (qmail 22696 invoked from network); 4 May 2010 21:27:10 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway16.websitewelcome.com with SMTP; 4 May 2010 21:27:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=r6VebV5DTgEuMOyQVmk7GLhwwnR5G9SQiopG1FCeGRf3kLNQOpsPkSSOvGRxzrXL990BHcLvPIaqe3HIGgIRVUeD+zfilZphjUmwgkf3n6tayv9QtMpMvBfMYqIJvBfl;
Received: from 216-239-45-4.google.com ([216.239.45.4]:48297 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9Pad-0004Ey-2V; Tue, 04 May 2010 16:23:39 -0500
Message-ID: <4BE09064.8010001@paralogos.com>
Date:   Tue, 04 May 2010 14:23:48 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost> <4BDF8092.1060401@paralogos.com>         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>         <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>         <4BE00207.6030506@paralogos.com>         <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>         <4BE0479E.6060506@paralogos.com>         <20100504184457.GA21929@linux-mips.org>         <k2s10f740e81005041228pea323400u89dfcefd4a5047d0@mail.gmail.com> <h2yf861ec6f1005041230p80a664e6o51296c106853d3fc@mail.gmail.com> <4BE07D13.6010105@caviumnetworks.com>
In-Reply-To: <4BE07D13.6010105@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> On 05/04/2010 12:30 PM, Manuel Lauss wrote:
>> On Tue, May 4, 2010 at 9:28 PM, Geert 
>> Uytterhoeven<geert@linux-m68k.org>  wrote:
>>> On Tue, May 4, 2010 at 20:44, Ralf Baechle<ralf@linux-mips.org>  wrote:
>>>> Is it paranoia by any chance?  Paranoia is available as single 
>>>> files at:
>>>>
>>>>   http://www.math.utah.edu/~beebe/software/ieee/paranoia.c
>>>>   http://www.math.utah.edu/~beebe/software/ieee/paranoia.h
>>>
>>> You also need
>>>
>>> http://www.math.utah.edu/~beebe/software/ieee/args.h
>>>
>>> Ran fine on:
>>>   - Toshiba RBTX4927 (with FPU :-)
>>>   - Mikrotik RouterBOARD 150 (without FPU), using an older 2.6.x 
>>> OpenWRT kernel
>>
>> and runs into an endless loop around line 806 when built with
>> a softfloat toolchain (gcc-4.4.3).
>>
>
> From the point of view of this specific problem, using a softfloat 
> toolchain isn't what you want to do.
That's absolutely true.  I would mention, however, that in ancient 
times, I built and ran paranoia with a couple of different softfloat 
libraries, and was able to make it work with them.  If people care about 
softfloat (and I think they should), this should probably be 
investigated.  Easy for me to say, though... ;o)

          Regards,

          Kevin K.
