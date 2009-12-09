Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2009 12:46:30 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:42159 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491978AbZLILqY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2009 12:46:24 +0100
Received: by pzk35 with SMTP id 35so5462736pzk.22
        for <multiple recipients>; Wed, 09 Dec 2009 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+IR+/hVZIXeyFUMO03UeX32rKxjo6HV2C49LJRRasVk=;
        b=kW/5M4bzvwioukJRvFId+g+/zJ/4OcnG8+dG3Mnew5rZTDY9NWtQoFcWpNSMvQdL4w
         MebUkNyw9L4jIdHUSHPQacHP0GD9d6QpmLKrlgW20dtKXLUFe2wyFx1qb48y/Yoc6qpm
         I60YY/wmZHV96k+S+PJwBRWDOBKzfq19+CYA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ywfpu1+uqSA0MXucSvMavWrL8TeOmXsqOyxITZOd5jjV7ncn4ehhs6tEwYgYpxjFsA
         jmbe1+rednUBRcrPLNGc32+2efGOLchD/PdraeNH2iTvhDuqRIXIr7qSz3wS/afizIFR
         K+aN9YhMZ+gxj/2AUDR69iyu67MCINumGUvYU=
MIME-Version: 1.0
Received: by 10.114.252.14 with SMTP id z14mr5972230wah.84.1260359175411; Wed, 
        09 Dec 2009 03:46:15 -0800 (PST)
In-Reply-To: <4B1E3A5A.9050100@ru.mvista.com>
References: <c6ed1ac50912070455n736af31fuf2c981fc182b494f@mail.gmail.com>
         <20091207134502.GB5119@linux-mips.org>
         <c6ed1ac50912071749m49b1e5f5m7ae53384389338d9@mail.gmail.com>
         <4B1E3A5A.9050100@ru.mvista.com>
Date:   Wed, 9 Dec 2009 19:46:15 +0800
Message-ID: <c6ed1ac50912090346p1109b095p5b4c26be5308f80a@mail.gmail.com>
Subject: Re: Dma addr should use Kuseg1 for MIPS32?
From:   figo zhang <figo1802@gmail.com>
To:     Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>, macro@linux-mips.org,
        linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e687872af09a7c047a4a3ccb
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e687872af09a7c047a4a3ccb
Content-Type: text/plain; charset=ISO-8859-1

2009/12/8 Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Hello.
>
>
> figo zhang wrote:
>
>
>>    > i write dma_phy to DMA base register, but why it cannot work? it
>>    should
>>    > write Kseg1 space to DMA register?
>>    > I remember that it is ok for ARM/X86 .
>>
>>    It's only happens to work on some systems.
>>
>>
>> in my puzzle, if i run dma_vaddr =(char*) __get_free_pages(GFP_KERNEL,
>>  order);
>> dma_phy = virt_to_phy(dma_vaddr);
>>
>> if the result is:
>> dma_vaddr = 0x801b00000;
>> dma_phy = 0x1b00000;
>>
>> so i should write 0x1b00000 to my DMA Base register or wirte (0x1b000000 |
>> 0xa0000000) to DMA?
>>
>
>  You must always use the physical addresses when programming DMA, i.e.
> 0x1b00000 in this case.
>

I  write  0x1b00000 to my DMA Base register, the driver donot work.  write
(0x1b00000 | 0xa000000) it work, why?

>
> WBR, Sergei
>
>
>

--0016e687872af09a7c047a4a3ccb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/12/8 Sergei Shtylyov <span dir=3D"l=
tr">&lt;<a href=3D"mailto:sshtylyov@ru.mvista.com">sshtylyov@ru.mvista.com<=
/a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>
Hello.<div class=3D"im"><br>
<br>
figo zhang wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
 =A0 =A0&gt; i write dma_phy to DMA base register, but why it cannot work? =
it<br>
 =A0 =A0should<br>
 =A0 =A0&gt; write Kseg1 space to DMA register?<br>
 =A0 =A0&gt; I remember that it is ok for ARM/X86 .<br>
<br>
 =A0 =A0It&#39;s only happens to work on some systems.<br>
<br>
<br>
in my puzzle, if i run dma_vaddr =3D(char*) __get_free_pages(GFP_KERNEL, =
=A0order);<br>
dma_phy =3D virt_to_phy(dma_vaddr);<br>
<br>
if the result is:<br>
dma_vaddr =3D 0x801b00000;<br>
dma_phy =3D 0x1b00000;<br>
<br>
so i should write 0x1b00000 to my DMA Base register or wirte (0x1b000000 | =
0xa0000000) to DMA?<br>
</blockquote>
<br></div>
 =A0You must always use the physical addresses when programming DMA, i.e. 0=
x1b00000 in this case.<br></blockquote><div><br>I=A0 write=A0 0x1b00000 to =
my DMA Base register, the driver donot work.=A0 write (0x1b00000 | 0xa00000=
0) it work, why?<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
WBR, Sergei<br>
<br>
<br>
</blockquote></div><br>

--0016e687872af09a7c047a4a3ccb--
