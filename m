Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 05:03:25 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:56673 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491822AbZJ1EDS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Oct 2009 05:03:18 +0100
Received: by pwi11 with SMTP id 11so582561pwi.24
        for <linux-mips@linux-mips.org>; Tue, 27 Oct 2009 21:03:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H06s0DtMwV1xiu+yuC6o83SwjdeEJhhZycp7XuZpHyQ=;
        b=olBYfAUgYfRShdVjCq9oYMg1hMTJVFmKDDdcWidRD7o552y2N3+e7Z7bsiFpx0djy+
         oJ77zTUrHocfjx8ILFDCdie8qV4DZl13AEZuGq42Ek49lOi2+XVKu4OuXfVSdiHG3Br0
         9M3+8nqMxE5PxsvyDrcYFiSHatwCiMmr7LBYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AwgSAjTMZcKz18nlmmERpTmdIJIDnUSg2V7UQ8RVeVZZN0o97yO9eRt5jg66Pd6Te5
         l+3pvZOocY44slLy4NAJju2BhEa4BdBzSAaI89UKH0EvfhWkxe1JHgKEhJchyAUF+2Fh
         zUQ1TNGnxKqSg8vovkJxp9U1bXGXoIrTuV044=
MIME-Version: 1.0
Received: by 10.143.25.39 with SMTP id c39mr1438871wfj.249.1256702588080; Tue, 
	27 Oct 2009 21:03:08 -0700 (PDT)
In-Reply-To: <f284c33d0910272056n4cd082et2ba1a4b5e228bb0e@mail.gmail.com>
References: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com>
	 <f284c33d0910272056n4cd082et2ba1a4b5e228bb0e@mail.gmail.com>
Date:	Wed, 28 Oct 2009 12:03:08 +0800
Message-ID: <3a665c760910272103gd4a6b78idb5e1175ba288b7e@mail.gmail.com>
Subject: Re: kernel panic about kernel unaligned access
From:	loody <miloody@gmail.com>
To:	Mulyadi Santosa <mulyadi.santosa@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Kernel Newbies <kernelnewbies@nl.linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

hi

2009/10/28 Mulyadi Santosa <mulyadi.santosa@gmail.com>:
> Hi...
>
> On Tue, Oct 27, 2009 at 8:27 PM, loody <miloody@gmail.com> wrote:
>> Dear all:
>> I use kernel 2.6.18 and I get the kernel panic as below:
>> Unhandled kernel unaligned access[#1]:
>> Cpu 0
>> $ 0   : 00000000 11000001 0000040a 8721f0d8
>> $ 4   : 874a6c00 80001d18 00000000 00000000
>> $ 8   : 00000000 ffffa438 00000000 874c2000
>> $12   : 00000000 00000000 00005800 00011000
>> $16   : 80001d10 874a6c40 874a6c00 87d7bf00
>> $20   : 874a6c78 871a0000 87370000 874a6c80
>> $24   : 00000000 2aacc770
>> $28   : 87d7a000 87d7be88 ffffa438 8709ed20
>> Hi    : 00000000
>> Lo    : 00000000
>> epc   : 8709e72c sync_sb_inodes+0x9c/0x320     Not tainted
>> ra    : 8709ed20 writeback_inodes+0xb4/0x160
>
> Hmmm, your machine is not x86, is it? So, I guess this panic is caused
> by unaligned memory access.
Yes, my machine is mips machine.
if do_ade in unaligned.c is a trap, where do  we register it?
I grep the source code but I only find the definition but cannot get
the place where we register the trap.
Does it have any relationship with the word 'asmlinkage'?
I know init is the keyword for init section.
but what does asmlinkage mean?

> AFAIK, in certain architecture, accessing memory at address not a
> multiple of its word size might cause trap. So, for example if it is a
> CPU with 4 byte word size, then accessing memory at 0x00000005 will
> cause panic.
>
>
>> my questions are:
>> 1. what does "Not tainted" mean?
>
> AFAIK, it means no non GPL-ed kernel module are currently inserted.
>
>> 2. I grep the kernel and I find the above message comes from do_ade in
>> unaligned.c, If I guess correctly.
>>    but from the call trace I cannot find out who call it.
>>    who and how kernel pass the information to do_ade?
>
> Likely it is part of trap handler.... thus it is installed as interrupt handler.
>
>
> --
appreciate your help,
miloody
