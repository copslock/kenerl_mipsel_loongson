Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 04:48:23 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:63143 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491845AbZJ2DsQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Oct 2009 04:48:16 +0100
Received: by pxi26 with SMTP id 26so1020706pxi.22
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 20:48:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aWRctwBtpAjCpEPmul3LKit9EmIRjr/FSBYXPNOmy+s=;
        b=AIy5QjuMz5X40rWCacv34VHGtuQZEDBAP1zo+m/Zq+8yeKfpS3FCga5H4l+f4BiD3h
         kAIQD6nTbv0lYOaYbjS5nlhylA08T9h+NOryfLc7fp6MM06QEM6C7waNc9/5TJiVUjEk
         /zvXyxyp/qIFI9gEWwfX/if2H6hYf5ZJu+D58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sZWobt0EUAskG9lUpdVeBW2MUXQ8T2ISACkaRCrZhqql/T3nZDUJtysnI19uw8rncC
         Yy1D/ufMaRXjnGdZ5gIYsGCXugXE+sozr4OdhA4biBLlWBj3jBtiCxd6RTyrp+pFEwZk
         qUONIGsfMXg/76/by/Lsm/LxucGhYcdj2/yj8=
MIME-Version: 1.0
Received: by 10.142.202.9 with SMTP id z9mr1545912wff.166.1256788087971; Wed, 
	28 Oct 2009 20:48:07 -0700 (PDT)
In-Reply-To: <4AE865E5.2080008@caviumnetworks.com>
References: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com>
	 <f284c33d0910272056n4cd082et2ba1a4b5e228bb0e@mail.gmail.com>
	 <3a665c760910272103gd4a6b78idb5e1175ba288b7e@mail.gmail.com>
	 <4AE865E5.2080008@caviumnetworks.com>
Date:	Thu, 29 Oct 2009 11:48:07 +0800
Message-ID: <3a665c760910282048t3454e14bx431b035d2d3192b4@mail.gmail.com>
Subject: Re: kernel panic about kernel unaligned access
From:	loody <miloody@gmail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Mulyadi Santosa <mulyadi.santosa@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>,
	Kernel Newbies <kernelnewbies@nl.linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Hi:
thanks for all your kind help.
2009/10/28 David Daney <ddaney@caviumnetworks.com>:
> loody wrote:
>>
>> hi
>>
>> 2009/10/28 Mulyadi Santosa <mulyadi.santosa@gmail.com>:
>>>
>>> Hi...
>>>
>>> On Tue, Oct 27, 2009 at 8:27 PM, loody <miloody@gmail.com> wrote:
>>>>
>>>> Dear all:
>>>> I use kernel 2.6.18 and I get the kernel panic as below:
>>>> Unhandled kernel unaligned access[#1]:
>>>> Cpu 0
>>>> $ 0   : 00000000 11000001 0000040a 8721f0d8
>>>> $ 4   : 874a6c00 80001d18 00000000 00000000
>>>> $ 8   : 00000000 ffffa438 00000000 874c2000
>>>> $12   : 00000000 00000000 00005800 00011000
>>>> $16   : 80001d10 874a6c40 874a6c00 87d7bf00
>>>> $20   : 874a6c78 871a0000 87370000 874a6c80
>>>> $24   : 00000000 2aacc770
>>>> $28   : 87d7a000 87d7be88 ffffa438 8709ed20
>>>> Hi    : 00000000
>>>> Lo    : 00000000
>>>> epc   : 8709e72c sync_sb_inodes+0x9c/0x320     Not tainted
>>>> ra    : 8709ed20 writeback_inodes+0xb4/0x160
>>>
>>> Hmmm, your machine is not x86, is it? So, I guess this panic is caused
>>> by unaligned memory access.
>>
>> Yes, my machine is mips machine.
>> if do_ade in unaligned.c is a trap, where do  we register it?
>> I grep the source code but I only find the definition but cannot get
>> the place where we register the trap.
>
>
> Look in genex.S for lines like:
>
>        BUILD_HANDLER adel ade ade silent               /* #4  */
>        BUILD_HANDLER ades ade ade silent               /* #5  */
>
> And also in traps.c for lines like:
>
>        set_except_vector(4, handle_adel);
>        set_except_vector(5, handle_ades);
Take  "8709ed20 writeback_inodes+0xb4/0x160" for example, what does
0x160, the last hex mean? The value of parameter?
appreciate your help,
miloody
