Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 02:49:48 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:61252 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494562AbZLHBto (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 02:49:44 +0100
Received: by pwj1 with SMTP id 1so400986pwj.24
        for <multiple recipients>; Mon, 07 Dec 2009 17:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=XKXWg8dmOQz/aFW9Ia6RDliGwEBycBvJXX6uUmncVqQ=;
        b=lBbTdrLUPJW/AzOiMVAeoEZQBMm6ItIcXodLYtDjDzfuEK6orXwAar0ZdzNelYxK8f
         c/WN/tjn5U36H5TunUeN5ERums/usggcebXkov7xi1NQk6ramvQ/Wamxs0qD9EBjJGaT
         FjoRUlTXBocEFUrGqP1s9pmG/+plc3ct01jT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vlOkVJXlpNONdLvfrMF6nNykCAZgbwMRZIupv3l09Jyp2C4VciOUUwJbf35BWaEPq8
         ySCm9cSk5CljVB+qJNOU+rn7X50L407QJ0YaiyoZpI2mlsO8JhnWujTDWQg5Dapw9oIl
         8aTIzmbO/oG4FMqv/9mFNvigY6E6eUoXqvrco=
MIME-Version: 1.0
Received: by 10.115.117.4 with SMTP id u4mr13666518wam.43.1260236974784; Mon, 
        07 Dec 2009 17:49:34 -0800 (PST)
In-Reply-To: <20091207134502.GB5119@linux-mips.org>
References: <c6ed1ac50912070455n736af31fuf2c981fc182b494f@mail.gmail.com>
         <20091207134502.GB5119@linux-mips.org>
Date:   Tue, 8 Dec 2009 09:49:34 +0800
Message-ID: <c6ed1ac50912071749m49b1e5f5m7ae53384389338d9@mail.gmail.com>
Subject: Re: Dma addr should use Kuseg1 for MIPS32?
From:   figo zhang <figo1802@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, macro@linux-mips.org,
        linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64e9098384a61047a2dc9a0
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64e9098384a61047a2dc9a0
Content-Type: text/plain; charset=ISO-8859-1

2009/12/7 Ralf Baechle <ralf@linux-mips.org>

> On Mon, Dec 07, 2009 at 08:55:12PM +0800, figo zhang wrote:
>
> > I am writing a driver for MIPS32. i wirte this code for DMA addr:
> >
> > dma_vaddr =(char*) __get_free_pages(GFP_KERNEL|
> > GFP_DMA, order);
>
> You probably don't want to use GFP_DMA - unless your hardware has DMA
> restrictions such as the ISA's bus's 16MB limit.
>
> > dma_phy = virt_to_phy(dma_vaddr);
>

> Ouch.  Don't.  See Documentation/DMA-API.txt for how to do it.
>

hi Ralf,
is it using dma_alloc_coherent()? i see the this funtion in
arch/mips/mm/dma_default.c, it also invork the
__get_free_pages() and return the dma_addr by
plat_map_dma_mem()->virt_to_phy() , see
include/asm-mips/mach-genric/dma-coherent.h. so i think, i see use
__get_free_pages() alloce buffer for DMA.

>
> > i write dma_phy to DMA base register, but why it cannot work? it should
> > write Kseg1 space to DMA register?
> > I remember that it is ok for ARM/X86 .
>
> It's only happens to work on some systems.
>

in my puzzle, if i run
dma_vaddr =(char*) __get_free_pages(GFP_KERNEL,  order);
dma_phy = virt_to_phy(dma_vaddr);

if the result is:
dma_vaddr = 0x801b00000;
dma_phy = 0x1b00000;

so i should write 0x1b00000 to my DMA Base register or wirte (0x1b000000 |
0xa0000000) to DMA?

2. If my system have HIGHMEM, so i alloc highmem pages by :
  page = alloc_pages(__GFP_HIGHMEM, order);
  phy = page_to_phys(page);

how i write this highmem phy addr to DMA base register?

Best,
Figo.zhang



>  Ralf
>

--0016e64e9098384a61047a2dc9a0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/12/7 Ralf Baechle <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt;</sp=
an><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Mon, Dec 07, 2009 at 08:55:12PM +0800, figo zhang wrot=
e:<br>
<br>
&gt; I am writing a driver for MIPS32. i wirte this code for DMA addr:<br>
&gt;<br>
&gt; dma_vaddr =3D(char*) __get_free_pages(GFP_KERNEL|<br>
&gt; GFP_DMA, order);<br>
<br>
</div>You probably don&#39;t want to use GFP_DMA - unless your hardware has=
 DMA<br>
restrictions such as the ISA&#39;s bus&#39;s 16MB limit.<br>
<div><br>
&gt; dma_phy =3D virt_to_phy(dma_vaddr); <br></div></blockquote><blockquote=
 class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); =
margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im">
<br>
</div>Ouch. =A0Don&#39;t. =A0See Documentation/DMA-API.txt for how to do it=
.<br></blockquote><div><br>hi Ralf, <br>is it using dma_alloc_coherent()? i=
 see the this funtion in arch/mips/mm/dma_default.c, it also invork the=A0 =
<br>
__get_free_pages() and return the dma_addr by plat_map_dma_mem()-&gt;virt_t=
o_phy() , see include/asm-mips/mach-genric/dma-coherent.h. so i think, i se=
e use __get_free_pages() alloce buffer for DMA.<br></div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im"><br>
&gt; i write dma_phy to DMA base register, but why it cannot work? it shoul=
d<br>
&gt; write Kseg1 space to DMA register?<br>
&gt; I remember that it is ok for ARM/X86 .<br>
<br>
</div>It&#39;s only happens to work on some systems.<br></blockquote><div><=
br>in my puzzle, if i run=A0 <br>dma_vaddr =3D(char*) __get_free_pages(GFP_=
KERNEL,=A0 order);<br>dma_phy =3D virt_to_phy(dma_vaddr); <br><br>if the re=
sult is:<br>
dma_vaddr =3D 0x801b00000;<br>dma_phy =3D 0x1b00000;<br><br>so i should wri=
te 0x1b00000 to my DMA Base register or wirte (0x1b000000 | 0xa0000000) to =
DMA?<br><br>2. If my system have HIGHMEM, so i alloc highmem pages by :<br>
=A0 page =3D alloc_pages(__GFP_HIGHMEM, order);<br>=A0 phy =3D page_to_phys=
(page);<br><br>how i write this highmem phy addr to DMA base register?<br><=
br>Best,<br>Figo.zhang<br>=A0 <br><br></div><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">

<font color=3D"#888888"><br>
 =A0Ralf<br>
</font></blockquote></div><br>

--0016e64e9098384a61047a2dc9a0--
