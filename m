Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2011 19:25:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5572 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab1HJRZ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Aug 2011 19:25:27 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e42bf460000>; Wed, 10 Aug 2011 10:26:31 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 10 Aug 2011 10:25:10 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 10 Aug 2011 10:25:10 -0700
Message-ID: <4E42BEF0.1040502@cavium.com>
Date:   Wed, 10 Aug 2011 10:25:04 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Holger Hans Peter Freyther <holger@freyther.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, "VomLehn, David" <dvomlehn@cisco.com>,
        gergely@homejinni.com
Subject: Re: [RFC][PATCH] Implement perf_callchain_user for o32 ABI (on mipsel)
References: <4E423228.2080309@freyther.de>
In-Reply-To: <4E423228.2080309@freyther.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Aug 2011 17:25:10.0177 (UTC) FILETIME=[74AD2110:01CC5782]
X-archive-position: 30846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7762

On 08/10/2011 12:24 AM, Holger Hans Peter Freyther wrote:
> Hi all,
>
> I wanted to use perf to profile my userspace application on MIPS but I saw
> that there is no solution for that. I have written some code to scan the
> prologue of the function to identify the stack size and where in the stack the
> return address is stored.
>
>     0:	27bdffd8 	addiu	sp,sp,-40<-- used to find prev. stack
>     4:	afbf0024 	sw	ra,36(sp)<-- stored return addr.
>     8:	afbe0020 	sw	s8,32(sp)
>     c:	03a0f021 	move	s8,sp
>    10:	3c1c0000 	lui	gp,0x0
>    14:	279c0000 	addiu	gp,gp,0
>
> The code appears to work in qemu-system-mipsel (not where I am going to do my
> profiling) with my simple test application.
>
> The code is missing a S-o-b because I would like to get feedback if something
> like this would ever be accepted upstream. The other question is also about
> security, other ABIs, 32/64 bit...
>
> comments more than welcome
> 	holger

You need to reconcile your patches with these:

http://patchwork.linux-mips.org/patch/2579/
http://patchwork.linux-mips.org/patch/2376/
http://patchwork.linux-mips.org/patch/2375/

We probably could use some sort of backtrace code in the kernel, but 
three seperate implementations are too many.

Also separating most of the unwinder into a separate file would be 
preferable to mixing it into the perf counter driver.

David Daney
