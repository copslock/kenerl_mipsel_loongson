Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 20:58:38 +0200 (CEST)
Received: from gateway14.websitewelcome.com ([69.93.243.15]:37602 "HELO
        gateway14.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492709Ab0EDS6d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 20:58:33 +0200
Received: (qmail 11237 invoked from network); 4 May 2010 19:03:24 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway14.websitewelcome.com with SMTP; 4 May 2010 19:03:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=WPK27LMTCp/yrI9KeJ2UB1/OwONMj2e12OX4Ld0XHOUEi3+KRRoCvu9uhNyjP4WhUlrZxHkTS2QL/e3JpcVZCBPSFrZQVe+nBjX0Ce72LBUO0Mab0OpVUNmTD4umZWNI;
Received: from 216-239-45-4.google.com ([216.239.45.4]:30017 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9NK0-0000IT-Mn; Tue, 04 May 2010 13:58:20 -0500
Message-ID: <4BE06E55.4030002@paralogos.com>
Date:   Tue, 04 May 2010 11:58:29 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com> <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com> <4BDF8092.1060401@paralogos.com> <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com> <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com> <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com> <4BE00207.6030506@paralogos.com> <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com> <4BE0479E.6060506@paralogos.com> <20100504184457.GA21929@linux-mips.org>
In-Reply-To: <20100504184457.GA21929@linux-mips.org>
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
X-archive-position: 26583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, May 04, 2010 at 09:13:18AM -0700, Kevin D. Kissell wrote:
>
>   
>> What we used to use was what I *thought* was an old public domain
>> program whose name was an English word that had something to do with
>> being exacting.  Googling with obvious keywords didn't turn it up.
>>     
>
> Is it paranoia by any chance?  Paranoia is available as single files at:
>
>   http://www.math.utah.edu/~beebe/software/ieee/paranoia.c
>   http://www.math.utah.edu/~beebe/software/ieee/paranoia.h
>
> It's ages that soembody last ran it but last known status is that there
> were no paranoia fault.
>   
Yes, that's it!  I used to run it all the time when I was working on 
SMTC FPU support. Shane, does it work on your system with the emulator??

/K.
