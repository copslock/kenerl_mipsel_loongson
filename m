Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 21:56:05 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1198 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491884Ab0BVUz6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2010 21:55:58 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b82ef650000>; Mon, 22 Feb 2010 12:56:05 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Feb 2010 12:55:29 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Feb 2010 12:55:29 -0800
Message-ID: <4B82EF41.2050603@caviumnetworks.com>
Date:   Mon, 22 Feb 2010 12:55:29 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Andreas Barth <aba@not.so.argh.org>
CC:     linux-mips@linux-mips.org
Subject: Re: Problems and workarounds while building octeon kernels
References: <20100220175125.GQ27216@mails.so.argh.org> <4B82C20D.9000302@caviumnetworks.com> <20100222202545.GV27216@mails.so.argh.org>
In-Reply-To: <20100222202545.GV27216@mails.so.argh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2010 20:55:29.0563 (UTC) FILETIME=[5DD41EB0:01CAB401]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/22/2010 12:25 PM, Andreas Barth wrote:
> * David Daney (ddaney@caviumnetworks.com) [100222 18:57]:
>> On 02/20/2010 09:51 AM, Andreas Barth wrote:
>>> I tried to build an recent linux 2.6.33-rc something in an unstable
>>> Debian chroot. I had the following issues (plus workarounds / fixes) -
>>> please don't hesitate to ask me if you have further questions.
>
>> Can you supply the .config as well as tell me the version of GCC you are
>> using?
>
> Attached (the compiling variant).

It is uninteresting, I already have one that works.  How about the 
version that provokes all the errors you mention?


>
> gcc is 4.4.3-2.
>

How about sending me the output of "gcc -x c -dM -E /dev/null" from that 
compiler?

Thanks,
David Daney
