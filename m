Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 12:57:15 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:63416 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038469AbWJIL5J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 12:57:09 +0100
Received: by nf-out-0910.google.com with SMTP id n29so595220nfc
        for <linux-mips@linux-mips.org>; Mon, 09 Oct 2006 04:57:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=t2qhhnyRc58b5DFycBt177FscFy5/3Ud3B95koXVgCNVhAKE7Ubj+htFA9i322H4g6F+WIa7valWAu4YHhbVc1pR8uiTqxnIHeKanUju3P4i7cU6eQ+nIyJhQCH6QnWCDvNtWwV3fdbHwe6Onvjy4jZA2Ir59VyWVcLqoa3m4BA=
Received: by 10.49.20.5 with SMTP id x5mr1843565nfi;
        Mon, 09 Oct 2006 04:57:06 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id k9sm419797nfc.2006.10.09.04.57.06;
        Mon, 09 Oct 2006 04:57:06 -0700 (PDT)
Message-ID: <452A3953.4060802@innova-card.com>
Date:	Mon, 09 Oct 2006 13:58:11 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
References: <45265BF0.8080103@innova-card.com> <20061006172153.GB4456@networkno.de>
In-Reply-To: <20061006172153.GB4456@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>>
>> -	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
>> +	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> 
> ISTR this failed on O2, where kernel+initrd are loaded into KSEG0 but the
> PAGE_OFFSET is for XKPHYS.
> 

I guess that you were meaning somthing like:

LOADADDR    = 0xffffffff80004000
PAGE_OFFSET = 0xa800000000000000

is that correct ? If so could you explain the choice of these values
because I fail to understand it.

Thanks
		Franck
