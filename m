Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 15:24:41 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:7250 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037847AbWJIOYg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 15:24:36 +0100
Received: by nf-out-0910.google.com with SMTP id n29so632115nfc
        for <linux-mips@linux-mips.org>; Mon, 09 Oct 2006 07:24:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=mcXztVW623J6V+lYkQGCezMBBzNtJw0JvCiGJYZdfG/uXBstSkPzL9ZuEXP8Ir3Ou62sgzFt2XmdK+STgu7nCPqzIBhvqWSBzxEk1ga5tfDfWtWUjY+qFvDu5balRQHFvXe4AFNH92U5kc2fyy9XOHdEmV6IIl8yYAixkhlwsEs=
Received: by 10.49.8.10 with SMTP id l10mr2108562nfi;
        Mon, 09 Oct 2006 07:24:35 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id l27sm7943594nfa.2006.10.09.07.24.34;
        Mon, 09 Oct 2006 07:24:35 -0700 (PDT)
Message-ID: <452A5BEA.2060500@innova-card.com>
Date:	Mon, 09 Oct 2006 16:25:46 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
References: <45265BF0.8080103@innova-card.com> <20061006172153.GB4456@networkno.de> <452A3953.4060802@innova-card.com> <20061009132131.GA18308@networkno.de>
In-Reply-To: <20061009132131.GA18308@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>> Thiemo Seufer wrote:
>>> Franck Bui-Huu wrote:
>>>> -	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
>>>> +	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
>>> ISTR this failed on O2, where kernel+initrd are loaded into KSEG0 but the
>>> PAGE_OFFSET is for XKPHYS.
>>>
>> I guess that you were meaning somthing like:
>>
>> LOADADDR    = 0xffffffff80004000
>> PAGE_OFFSET = 0xa800000000000000
>>
>> is that correct ?
> 
> Yes.
> 
>> If so could you explain the choice of these values
>> because I fail to understand it.
> 
> It allows to load a 64-bit kernel in KSEG0,

sorry to be ignorant of 64 bit kernels, but what's the point
to load them in KSEG0.

> and use short 2-instruction symbol references there.

do you mean "it allows to use only 2 'lui' instructions to load
a symbol address into a register" ?

Futhermore I don't see how some part of the kernel convert virtual
address into a physical one with such values. For example in setup.c,
the function resource_init() does:

	code_resource.start = virt_to_phys(&_text);
	code_resource.end = virt_to_phys(&_etext) - 1;
	data_resource.start = virt_to_phys(&_etext);
	data_resource.end = virt_to_phys(&_edata) - 1;

How does it work in this case ?

Thanks
		Franck
