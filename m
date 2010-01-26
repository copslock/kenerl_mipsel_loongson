Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 17:30:44 +0100 (CET)
Received: from gv-out-0910.google.com ([216.239.58.185]:63606 "EHLO
        gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492063Ab0AZQak convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 17:30:40 +0100
Received: by gv-out-0910.google.com with SMTP id r4so303198gve.2
        for <multiple recipients>; Tue, 26 Jan 2010 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K461E7t67R9Wd2msjBfzFvAcCOrbiIOJt0SFeAXNjaA=;
        b=IF5p9D2dXlvLmXlDiVd16B46Su+C+2g2VfagrGbU12ErJJkRqK+JgLF9jnF9vX9tjg
         i3iYmbQEpMpRBd7zi9+l2A/s/3HswSkcRp1Vw4mE2TNIGGRvg2gOPreG6onYwIKLU2fy
         E0ys/umoTmZAJbHLe+OyP1+EzLZDoxo2FalrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uDP7TwadpfcEvbHxggw1HTVLU/bpDl1oBbII+Gwoj1BBFWZShbIMhXgqDejzSHTx/v
         pHInt0cM22Eiqwg8/f/7IVPNEccB/tfr2dmzCijWCWVFCYFB3uRlkbrNeWV94rDAOrBt
         yACCRQQreMZDOcbQVJELNdgrH9fM5OPLifVcE=
MIME-Version: 1.0
Received: by 10.102.15.30 with SMTP id 30mr4141367muo.36.1264523439965; Tue, 
        26 Jan 2010 08:30:39 -0800 (PST)
In-Reply-To: <1264521494.24895.28.camel@falcon>
References: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
         <f861ec6f1001260728x64c54ec7m65bc6ebc0ee64a80@mail.gmail.com>
         <1264521494.24895.28.camel@falcon>
Date:   Tue, 26 Jan 2010 17:30:39 +0100
Message-ID: <f861ec6f1001260830x6facb42fi37074dcc1c2afade@mail.gmail.com>
Subject: Re: [PATCH -queue v2] MIPS: Cleanup the debugging of compressed 
        kernel support
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     wuzhangjin@gmail.com
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16795

On Tue, Jan 26, 2010 at 4:58 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> On Tue, 2010-01-26 at 16:28 +0100, Manuel Lauss wrote:
>> Hi,
>>
>> On Tue, Jan 26, 2010 at 4:02 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
>> > Changes from v1 (feedbacks from Ralf):
>> >
>> >  o make DEBUG_ZBOOT also depend on DEBUG_KERNEL
>> >
>> >  o DEBUG_ZBOOT already depends on SYS_SUPPORTS_ZBOOT_UART16550 so simplify the
>>
>> Not every chip has a standard 16550, unfortunately.  I liked your
>> first iteration better:
>> DEBUG_ZBOOT visible at all times (or depend on DEBUG_KERNEL)  another
>> (invisible)
>> config symbol selecting the code to build (i.e. SYS_SUPPORTS_ZBOOT_UART16550
>> for your loongson boxes, MACH_ALCHEMY for alchemy, and nothing for unsupported
>> chips).
>>
>
> Yes, It will be not convenient for a new serial port debugging support
> with the current modification, for example, if you add UARTXXXX, we need
> to select it for the new board and also add it under the "depends" of
> DEBUG_ZBOOT. how about this?

[...]

Fine with me.  I'll resend an updated Alchemy zboot debug patch once
this has been applied.

Thank you!
     Manuel Lauss
