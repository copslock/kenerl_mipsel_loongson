Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2011 01:42:28 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:44341 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1CSAmZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Mar 2011 01:42:25 +0100
Received: by gxk2 with SMTP id 2so1934269gxk.36
        for <linux-mips@linux-mips.org>; Fri, 18 Mar 2011 17:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=08Iz9/7CG2hcJktu2V2xD7HVCp6CR5kBHZ/qNydUV30=;
        b=kylfr2EGjIZ6rRBvn+NUGs3Zx3trx5gp+KYO2grZeCg6+b2cFLZpQOnA4eeShqiWrt
         vzzuklxVyQSK/SsxuQi7oUR6kzko9xHinAlHbyBCxXPZMnpzY9U8l+zsxg+GsI4jPlmj
         BqYmmSgHdPXKFIqJqgKBvEYpZSbKMcwfmDL6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JT3Nwl//ARaWruPHjggskE0rafkoHyeJCdgPspvgR3iTB6DfRiorJWrtHZu3tzMb0V
         ZCw1sBGXwvedEf3gJWLcQDU29l08E3yCm/W9QHQ1YDF1jv8ps//fscsXoYXb7z2i9Fux
         h4EU5YOaNAavem7/WiEWVOuodGLZKRxHHRtrw=
MIME-Version: 1.0
Received: by 10.151.116.6 with SMTP id t6mr1872008ybm.43.1300495337116; Fri,
 18 Mar 2011 17:42:17 -0700 (PDT)
Received: by 10.146.167.5 with HTTP; Fri, 18 Mar 2011 17:42:17 -0700 (PDT)
In-Reply-To: <AANLkTikWUehOmyD6Nk3Abz=u7FEb8NMtX2-N4r5HHuY9@mail.gmail.com>
References: <AANLkTinhM4PUmLbWeAyavf-JPM1Xpu9pJVkXDq4c-f0C@mail.gmail.com>
        <AANLkTinsQrZJsXt0SKRfe3S0cNGT+uuW-t3Jo4Ob4=B4@mail.gmail.com>
        <A7DEA48C84FD0B48AAAE33F328C02014033DADEC@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
        <AANLkTikWUehOmyD6Nk3Abz=u7FEb8NMtX2-N4r5HHuY9@mail.gmail.com>
Date:   Sat, 19 Mar 2011 08:42:17 +0800
Message-ID: <AANLkTimK1xpHwvfE95rEMCikk8-0EkGjn4b5DwYWyN-E@mail.gmail.com>
Subject: Re: Problem About Vectored interrupt
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Content-Type: multipart/alternative; boundary=001e680f15c099d4ad049ecb2a59
Return-Path: <dennis.yxun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips

--001e680f15c099d4ad049ecb2a59
Content-Type: text/plain; charset=UTF-8

HI ALL:
  Again, found that when come to set vect irq 7, do additional data flush
fix my problem, here is the patch

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e971043..850ce58 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1451,6 +1451,9 @@ static void *set_vi_srs_handler(int n, vi_handler_t
addr, int srs)
                *w = (*w & 0xffff0000) | (((u32)handler >> 16) & 0xffff);
                w = (u32 *)(b + ori_offset);
                *w = (*w & 0xffff0000) | ((u32)handler & 0xffff);
+               /* FIXME: need flash data cache, for timer irq */
+               if (n == 7)
+                       flush_data_cache_page((unsigned int)b);
                local_flush_icache_range((unsigned long)b,
                                         (unsigned long)(b+handler_len));
        }



Dennis

On Mon, Dec 27, 2010 at 11:56 PM, Dennis.Yxun <dennis.yxun@gmail.com> wrote:

> HI Annop:
>   Thanks for your reply.
>   Actually, I think I've already done those two point
> you mentioned here.
>   I checked my .config file, it include
>   CONFIG_CEVT_R4K_LIB=y
>   CONFIG_CEVT_R4K=y
>   CONFIG_CSRC_R4K_LIB=y
>   CONFIG_CSRC_R4K=y
>
> for the get_c0_compare_int
> I've already implemented, see my attached time.c
>
> unsigned int __cpuinit get_c0_compare_int(void)
> {
>         if (cpu_has_vint)
>                 set_vi_handler(cp0_compare_irq, mips_timer_dispatch0);
>
>         mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
>
>         return mips_cpu_timer_irq;
> }
>
> c0_compare_irq = 7
> and MIPS_CPU_IRQ_BASE = 0
> so mips_cpu_timer_irq = 7
>
> should be the same as your mail
>
> Dennis
>
>
> On Mon, Dec 27, 2010 at 11:20 PM, Anoop P.A. <Anoop_P.A@pmc-sierra.com>wrote:
>
>> Hi Dennis,
>>
>> You may not have to do this ugly hack. Since your cpu is 24kc you should
>> be able to re-use r4k timer library. Select r4k timer from your Kconfig
>> [code]
>>        select CEVT_R4K
>>        select CSRC_R4K
>>
>> To point your timer interrupt you can add get_c0_compare_int function to
>> your platform init code
>>
>> [code]
>>
>> unsigned int __cpuinit get_c0_compare_int(void)
>> {
>> return 7;
>> }
>>
>> Thanks
>> Anoop
>>
>>
>> ________________________________
>>
>> From: linux-mips-bounce@linux-mips.org on behalf of Dennis.Yxun
>> Sent: Mon 12/27/2010 7:30 PM
>> To: linux-mips@linux-mips.org
>> Subject: Re: Problem About Vectored interrupt
>>
>>
>> HI:
>>   Here is my patch which hacked set_vi_srs_handler, with this I could
>> successfully bring timer(compare/counter),
>>   But I still not reach the root problem,
>> Could someone shine some lights on me.
>>   Thanks
>>
>> Dennis
>>
>>
>> On Mon, Dec 27, 2010 at 4:40 PM, Dennis.Yxun <dennis.yxun@gmail.com>
>> wrote:
>>
>>
>>        HI ALL:
>>            I'm try to porting kernel-2.6.36 to one mips24kc board, seems
>> it can't bind vectored irq 7 to timer interrupt.
>>        The hardware wired IP7 to timer interrupt (CP0 compare/counter
>> interrupt)
>>            I implemented my own time.c, use set_vi_handler to map
>> cp0_compare_irq(value: 7) to mips_timer_dispatch,
>>         but weird problem, it didn't successfully map to
>> mips_timer_dispatch, but print out "Caught unexpected vectored interrupt."
>>        which means it still use " static asmlinkage void
>> do_default_vi(void)"  [1]
>>
>>           My question is : why first call to "set_vi_srs_handler"
>> successfully mapped to vectored irq7 [2]
>>        but later is fail[3], see my attached file, bad_kernel.txt
>>
>>        Dennis
>>
>>
>>        [1] arch/mips/kernel/traps.c 1339
>>        [2] arch/mips/kernel/traps.c  1436, when addr == NULL
>>        [3] my attached file time.c get_c0_compare_int
>>
>>
>>
>>
>>
>

--001e680f15c099d4ad049ecb2a59
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

HI ALL:<br>=C2=A0 Again, found that when come to set vect irq 7, do additio=
nal data flush fix my problem, here is the patch<br><br>diff --git a/arch/m=
ips/kernel/traps.c b/arch/mips/kernel/traps.c<br>index e971043..850ce58 100=
644<br>
--- a/arch/mips/kernel/traps.c<br>+++ b/arch/mips/kernel/traps.c<br>@@ -145=
1,6 +1451,9 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, in=
t srs)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *w =3D (*w &amp; 0xffff0000) | (((u32)handler &=
gt;&gt; 16) &amp; 0xffff);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 w =3D (u32 *)(b + ori_offset);<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *w =3D (=
*w &amp; 0xffff0000) | ((u32)handler &amp; 0xffff);<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FIXME=
: need flash data cache, for timer irq */<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (n =3D=3D 7)<b=
r>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_data_cac=
he_page((unsigned int)b);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_flush_icache_range((uns=
igned long)b,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long)(b+handler_len));<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br><br>
<br><br>Dennis<br><br><div class=3D"gmail_quote">On Mon, Dec 27, 2010 at 11=
:56 PM, Dennis.Yxun <span dir=3D"ltr">&lt;<a href=3D"mailto:dennis.yxun@gma=
il.com">dennis.yxun@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">
HI Annop:<div>=C2=A0=C2=A0Thanks for your reply.<br><div>=C2=A0=C2=A0Actual=
ly, I think I&#39;ve already done those two point</div><div>you mentioned h=
ere.</div><div>=C2=A0=C2=A0I checked my .config file, it include</div><div>=
=C2=A0=C2=A0CONFIG_CEVT_R4K_LIB=3Dy<div>

=C2=A0=C2=A0CONFIG_CEVT_R4K=3Dy</div><div>=C2=A0=C2=A0CONFIG_CSRC_R4K_LIB=
=3Dy</div><div>=C2=A0=C2=A0CONFIG_CSRC_R4K=3Dy</div><div><br></div><div>for=
 the get_c0_compare_int</div><div>I&#39;ve already implemented, see my atta=
ched time.c</div><div><br></div><div>
<div class=3D"im">
<div>unsigned int __cpuinit get_c0_compare_int(void)</div><div>{</div></div=
><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_has_vint)</div><div>=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_vi_handler(cp0_c=
ompare_irq, mips_timer_dispatch0);</div><div><br></div><div>=C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0mips_cpu_timer_irq =3D MIPS_CPU_IRQ_BASE + cp0_compare_=
irq;</div>

<div><br></div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0return mips_cpu_timer_=
irq;</div><div>}</div></div><div><br></div><div>c0_compare_irq =3D 7</div><=
div>and MIPS_CPU_IRQ_BASE =3D 0</div><div>so mips_cpu_timer_irq =3D 7</div>=
<div><br></div><div>should be the same as your mail</div>

<div><br></div><font color=3D"#888888"><div>Dennis</div></font><div><div></=
div><div class=3D"h5"><div><br></div><br><div class=3D"gmail_quote">On Mon,=
 Dec 27, 2010 at 11:20 PM, Anoop P.A. <span dir=3D"ltr">&lt;<a href=3D"mail=
to:Anoop_P.A@pmc-sierra.com" target=3D"_blank">Anoop_P.A@pmc-sierra.com</a>=
&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi Dennis,<br>
<br>
You may not have to do this ugly hack. Since your cpu is 24kc you should be=
 able to re-use r4k timer library. Select r4k timer from your Kconfig<br>
[code]<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0select CEVT_R4K<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0select CSRC_R4K<br>
<br>
To point your timer interrupt you can add get_c0_compare_int function to yo=
ur platform init code<br>
<br>
[code]<br>
<br>
unsigned int __cpuinit get_c0_compare_int(void)<br>
{<br>
return 7;<br>
}<br>
<br>
Thanks<br>
Anoop<br>
<br>
<br>
________________________________<br>
<br>
From: <a href=3D"mailto:linux-mips-bounce@linux-mips.org" target=3D"_blank"=
>linux-mips-bounce@linux-mips.org</a> on behalf of Dennis.Yxun<br>
Sent: Mon 12/27/2010 7:30 PM<br>
To: <a href=3D"mailto:linux-mips@linux-mips.org" target=3D"_blank">linux-mi=
ps@linux-mips.org</a><br>
Subject: Re: Problem About Vectored interrupt<br>
<div><div></div><div><br>
<br>
HI:<br>
 =C2=A0 Here is my patch which hacked set_vi_srs_handler, with this I could=
 successfully bring timer(compare/counter),<br>
 =C2=A0 But I still not reach the root problem,<br>
Could someone shine some lights on me.<br>
 =C2=A0 Thanks<br>
<br>
Dennis<br>
<br>
<br>
On Mon, Dec 27, 2010 at 4:40 PM, Dennis.Yxun &lt;<a href=3D"mailto:dennis.y=
xun@gmail.com" target=3D"_blank">dennis.yxun@gmail.com</a>&gt; wrote:<br>
<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0HI ALL:<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I&#39;m try to porting kernel-2.6=
.36 to one mips24kc board, seems it can&#39;t bind vectored irq 7 to timer =
interrupt.<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0The hardware wired IP7 to timer interrupt (CP0 =
compare/counter interrupt)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I implemented my own time.c, use =
set_vi_handler to map cp0_compare_irq(value: 7) to mips_timer_dispatch,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 but weird problem, it didn&#39;t successfully =
map to mips_timer_dispatch, but print out &quot;Caught unexpected vectored =
interrupt.&quot;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0which means it still use &quot; static asmlinka=
ge void do_default_vi(void)&quot; =C2=A0[1]<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 My question is : why first call to &quo=
t;set_vi_srs_handler&quot; successfully mapped to vectored irq7 [2]<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0but later is fail[3], see my attached file, bad=
_kernel.txt<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Dennis<br>
<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1] arch/mips/kernel/traps.c 1339<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0[2] arch/mips/kernel/traps.c =C2=A01436, when a=
ddr =3D=3D NULL<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0[3] my attached file time.c get_c0_compare_int<=
br>
<br>
<br>
<br>
<br>
</div></div></blockquote></div><br></div></div></div></div>
</blockquote></div><br>

--001e680f15c099d4ad049ecb2a59--
