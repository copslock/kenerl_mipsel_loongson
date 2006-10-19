Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 11:51:42 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:34928 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037802AbWJSKvj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 11:51:39 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1019823nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 03:51:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=kX1t96qProlXONSDZXC63XUGMBWwNCoXmHTDpMESsl7dLAbY/hHRH8mGdkBalkw5gO566AluBr3ekw17zVhuvpzvKpoAWjCX9lCbhJUl0/WLUyG+glf/p6x8xD0TbTExYAtR2gSZV5l2EvMLegUF62ahzq2RcuzpgC5sp77uMj4=
Received: by 10.49.8.15 with SMTP id l15mr5539198nfi;
        Thu, 19 Oct 2006 03:51:32 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id p45sm800725nfa.2006.10.19.03.51.30;
        Thu, 19 Oct 2006 03:51:32 -0700 (PDT)
Message-ID: <453758AF.2060109@innova-card.com>
Date:	Thu, 19 Oct 2006 12:51:27 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <453739B2.1010705@innova-card.com>	<20061019.181508.15248454.nemoto@toshiba-tops.co.jp>	<45374B41.6060008@innova-card.com> <20061019.193050.39153762.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061019.193050.39153762.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 19 Oct 2006 11:54:09 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> This does not work if PAGE_OFFSET was 0xffffffff80000000 and
>>> initrd_start was 0x980000000XXXXXXX :-)
>>>
>> I think we should terminate this patch pretty quickly because
>> it's going to make me mad ;)
>>
>> How can PAGE_OFFSET be in CKSEG0 segment and initrd_start be
>> in XKPHYS ?
> 
> If we passed a XKPHYS address to "rd_start=" option.  Bad usage :-)
> 

ok so testing initrd_start against PAGE_OFFSET (instead of XKPHYS)
is good check since we catch such bad usages. Do you agree ?

>> With the current code we can say:
>>
>>   - If PAGE_OFFSET is in CKSEG0, that means that all kernel
>>     virtual address must be in CKSEG0.
>>   - If PAGE_OFFSET is in XKPHYS, that means that _after_ booting
>>     process all kernel virtual address will be in XKPHYS. But we
>>     allow CKSEG0 virtual address during boot for the reasons
>>     we know.
>>
>> What woud give __pa(initrd_start) in your example ?
>>
>> __pa(initrd_start) -> 0x980000000XXXXXXX - 0xffffffff80000000
>>
>> which is wrong...Does your example come from a real use case ?
> 
> It's wrong indeed.  But I can not see good way to handle such terrible
> usage.  So ... let's ignore it.  I'm OK, are you ?
> 

why do we need to handle them anyway ?

PAGE_OFFSET in XKPHYS means that the kernel runs in XKPHYS address
space. We allow at boot time kernel address to be in CKSEG0 because
we have a good reason to handle that. It allows to get a kernel
smaller and faster at compile time.

PAGE_OFFSET in CKSEG0 means that the kernel runs in CKSEG0 address
space. This means also that kernel can't handle XKPHYS address. But
how would the kernel get addresses in XKPHYS (except user bad usages) ?

		Franck
