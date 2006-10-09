Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 16:29:26 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:42869 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039676AbWJIP3V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 16:29:21 +0100
Received: by nf-out-0910.google.com with SMTP id n29so647944nfc
        for <linux-mips@linux-mips.org>; Mon, 09 Oct 2006 08:29:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=BqtHAU0VnAvgqE4WF7DxFVYbw+GkRBRkWa1RCkOdhBiY7lsnknZ0k0qaMEPVjkler0vqt3CZzKL571GMNV7DV/pb4pPsQJ2G61DZJ2vqm985OAoc+4oJBsjaphWcXXKWKP79xvSC/9Qj6HAzMyn6SrsLvinQealGAlqMm3fa0UU=
Received: by 10.48.48.15 with SMTP id v15mr10393266nfv;
        Mon, 09 Oct 2006 08:29:20 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id k9sm825221nfc.2006.10.09.08.29.19;
        Mon, 09 Oct 2006 08:29:20 -0700 (PDT)
Message-ID: <452A6B16.60507@innova-card.com>
Date:	Mon, 09 Oct 2006 17:30:30 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
References: <45265BF0.8080103@innova-card.com> <20061006172153.GB4456@networkno.de> <452A3953.4060802@innova-card.com> <20061009132131.GA18308@networkno.de> <452A5BEA.2060500@innova-card.com> <20061009145817.GB18308@networkno.de>
In-Reply-To: <20061009145817.GB18308@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>> sorry to be ignorant of 64 bit kernels, but what's the point
>> to load them in KSEG0.
> 
> Smaller code with better performance.
> 

you mean we get smaller code _only_ by using the short 2 instructions
you described below ?

>>> and use short 2-instruction symbol references there.
>> do you mean "it allows to use only 2 'lui' instructions to load
>> a symbol address into a register" ?
> 
> It allows a 2-instruction "lui ; addiu" sequence instead of a
> 6-instruction "lui ; lui ; addiu ; addiu ; dsll32 ; addu" sequence.
> 
[snip]
>>
>> 	code_resource.start = virt_to_phys(&_text);
>> 	code_resource.end = virt_to_phys(&_etext) - 1;
>> 	data_resource.start = virt_to_phys(&_etext);
>> 	data_resource.end = virt_to_phys(&_edata) - 1;
>>
>> How does it work in this case ?
> 
> Those are addresses in 64-bit space, no special handling is needed
> there.

hm I'missing something there. Let's say that '&_text' is in KSEG0 and
is equal to 0xffffffff80000000. In this case virt_to_phys() returns
0x57ffffff80000000 (with PAGE_OFFSET = 0xa800000000000000). Is this 
physical address correct ??

> 
> The same doesn't hold for the initrd addresses supplied by the (32-bit)
> firmware. The firmware doesn't convert the kernel parameters to 64-bit
> values because the O2 kernel used to allow a pure 32-bit build, and the
> firmware can't find out what's actually inside the object file.
> 

This should be already handled by this code taken from setup.c:

static int __init rd_start_early(char *p)
{
        unsigned long start = memparse(p, &p);

#ifdef CONFIG_64BIT
        /* HACK: Guess if the sign extension was forgotten */
        if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
                start |= 0xffffffff00000000UL;
#endif
        initrd_start = start;
        initrd_end += start;

        return 0;
}

Thanks
		Franck
