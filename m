Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 09:30:53 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:1471 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28573704AbWJSIav (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 09:30:51 +0100
Received: by nf-out-0910.google.com with SMTP id l23so980315nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 01:30:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=snCdsaLpDBbHBf6tFqVxYGO4Ub5siSxLxHLXUNE3fhY3JwaK4sPARykVjutKinXzoIQ8ufX1W+EHM40OcocPYPUqBTJpLLfEoYfPhRHb7B3YOOvvFOx87pPvW+SwEIx2VdTDwBzkGpyXGSUV6STvQuDImrpQIUt8s5zUkPEEvtY=
Received: by 10.49.36.6 with SMTP id o6mr5413091nfj;
        Thu, 19 Oct 2006 01:30:50 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id q28sm443301nfc.2006.10.19.01.30.50;
        Thu, 19 Oct 2006 01:30:50 -0700 (PDT)
Message-ID: <453737B8.9090307@innova-card.com>
Date:	Thu, 19 Oct 2006 10:30:48 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <cda58cb80610182337h611f1cf0vd489b5828dfd269f@mail.gmail.com>	<20061019.155124.96684956.nemoto@toshiba-tops.co.jp>	<4537296C.50702@innova-card.com> <20061019.165110.21957261.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061019.165110.21957261.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 19 Oct 2006 09:29:48 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> But we need sign extension for values comes from the initrd_header
>>> anyway.  The initrd_header is fixed-size and can not hold 64-bit
>>> address.
>>>
>> initrd_header gives only 2 numbers: size of initrd, and a magic number,
>> well it's what I understood when rewriting the code.
>>
>> the start address of initrd is given by:
>>
>> 	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + 8)) - 8;
>> 		
>>
>> I don't think we need any sign extension here, do we ?
> 
> Oh I was confused.  You are right.

yeah I was confused at the first look too. I think rewriting it like
this:

	initrd_start = (unsigned long)(initrd_header + 2);

is less confusing...

> 
> BTW, we can just ignore initrd instead of panic() if invalid values
> given.  This place around is too early to print panic message.
> Continuing with printk(KERN_ERR) will give us a chance to see what's
> wrong.
> 

ok, I'm rebuilding a new patchset and sending it pretty soon,

		Franck
