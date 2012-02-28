Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 09:48:27 +0100 (CET)
Received: from mail-tul01m020-f177.google.com ([209.85.214.177]:54619 "EHLO
        mail-tul01m020-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903549Ab2B1IsU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 09:48:20 +0100
Received: by obcuz6 with SMTP id uz6so7812924obc.36
        for <multiple recipients>; Tue, 28 Feb 2012 00:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FH+LlM1iw5/DupuEMYIDzlsf4bNC8TAJ9hCoht/g+24=;
        b=OYwHxf6CLg4nvqKK+jqJrHvQHPtjOL514cEuJwhHNg5Njtsl49YSZhX/Z+O84qkqsJ
         CO9k5m0vNx9sifJsbD05vKNUPaMu3oBcowkPfHMG9xbiL5kAZV+L02albMygCiq5JQO2
         5YHu9tdnm6MnMutg4zsRsr923nYDplE2xzCOU=
MIME-Version: 1.0
Received: by 10.182.216.101 with SMTP id op5mr5627900obc.54.1330418894112;
 Tue, 28 Feb 2012 00:48:14 -0800 (PST)
Received: by 10.182.220.68 with HTTP; Tue, 28 Feb 2012 00:48:13 -0800 (PST)
In-Reply-To: <CAKYAXd8O1ibkkv0wrPxJFxuCwtsdW1Z66WAxKN15FX2VZvV0gQ@mail.gmail.com>
References: <28c262361003230146o7bca61e6h3af2062b1172fdb2@mail.gmail.com>
        <afc622a1003230511o108556f4s5d1282bd3122b3d9@mail.gmail.com>
        <BANLkTimKw3mg8N-gBxh3jbo9msaHOF3qPA@mail.gmail.com>
        <CAF1ZMEdh19eNbknfNskQxKeo0sjP7ELOAdRi9zD5VEqTLBXj6Q@mail.gmail.com>
        <CAKYAXd8O1ibkkv0wrPxJFxuCwtsdW1Z66WAxKN15FX2VZvV0gQ@mail.gmail.com>
Date:   Tue, 28 Feb 2012 16:48:13 +0800
Message-ID: <CAF1ZMEdVxUpUbd6nmCdmnW8rR+iObmkBUYSDDS3JLd-SM2v+OA@mail.gmail.com>
Subject: Re: data consistency of high page
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Minchan Kim <minchan.kim@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>, yan@mips.com
Content-Type: multipart/alternative; boundary=f46d0447864b96084704ba0249cb
X-archive-position: 32570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--f46d0447864b96084704ba0249cb
Content-Type: text/plain; charset=UTF-8

HI NamJae:
    I think someone already published this patch, just can't remember when
exactly~
Also, before we push this patch into repository, should we have more
reviews?
Is there any better solution? Should we always flush cache when it is
highmem?
    thanks

Dennis

On Tue, Feb 28, 2012 at 3:09 PM, Namjae Jeon <linkinjeon@gmail.com> wrote:

> 2012/2/28 Dennis.Yxun <dennis.yxun@gmail.com>:
> > Hi NamJae:
> >  We hit pretty much the same problem, highmem + cache consistence
> > but our hardware should have cache alias problem
> >  Could you try attached following patch?
> Hi Dennis.
> I already fixed it as your patch in our system before.
> your patch looks reasonable to me.
> Would you post this patch with adding the below ?
>
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> Tested-by: Namjae Jeon <linkinjeon@gmail.com>
>
> Thanks~
>
> >
> > dmesg:
> > [    0.000000] PID hash table entries: 1024 (order: 0, 4096
> > bytes)
> > [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
> > bytes)
> > [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
> > bytes)
> > [    0.000000] Primary instruction cache 16kB, VIPT, 4-way, linesize 32
> > bytes.
> > [    0.000000] Primary data cache 16kB, 4-way, VIPT, no aliases,
> linesize 32
> > byt
> > es
> > [    0.000000] MIPS secondary cache 128kB, 8-way, linesize 32
> > bytes.
> > [    0.000000] Writing ErrCtl
> > register=00000000
> > [    0.000000] Readback ErrCtl
> > register=00000000
> > [    0.000000] Memory: 510548k/262144k available (2728k kernel code,
> 13740k
> > rese
> > rved, 630k data, 5784k init, 262144k highmem)
> >
> > diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> > index 00d70c8..536b7f9 100644
> > --- a/arch/mips/mm/cache.c
> > +++ b/arch/mips/mm/cache.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/mm.h>
> > +#include <linux/highmem.h>
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/processor.h>
> > @@ -83,8 +84,13 @@ void __flush_dcache_page(struct page *page)
> >         struct address_space *mapping = page_mapping(page);
> >         unsigned long addr;
> >
> > -       if (PageHighMem(page))
> > +       if (PageHighMem(page) &&
> > +               (addr = (unsigned long) kmap_atomic(page,
> KM_SYNC_DCACHE)))
> > {
> > +               flush_data_cache_page(addr);
> > +               kunmap_atomic((void *)addr, KM_SYNC_DCACHE);
> >                 return;
> > +       }
> >
> >
> >
> > On Tue, Apr 5, 2011 at 4:17 PM, NamJae Jeon <linkinjeon@gmail.com>
> wrote:
> >>
> >> Hi.
> >>
> >> As you know, there is cache operation about highpage in arm arch.
> >>
> >> arch/arm/mm/flush.c
> >>
> >>
> -----------------------------------------------------------------------------------------------
> >> if (!PageHighMem(page)) {
> >>                __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> >>        } else {
> >>                void *addr = kmap_high_get(page);
> >>                if (addr) {
> >>                        __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> >>                        kunmap_high(page);
> >>                } else if (cache_is_vipt()) {
> >>                        /* unmapped pages might still be cached */
> >>                        addr = kmap_atomic(page);
> >>                        __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> >>                        kunmap_atomic(addr);
> >>                }
> >>        }
> >>
> >>
> -------------------------------------------------------------------------------------------------
> >>
> >> currently, mips kernel just return without cache operation.
> >>
> >> Would you plz tell me your opinion ?
> >>
> >> Thanks.
> >>
> >>
> >> 2010/3/23 NamJae Jeon <linkinjeon@gmail.com>:
> >> > Hi. Ralf.
> >> >
> >> > I'm Namjae.jeon. nice to meet you.
> >> >
> >> > I face cache aliasing problem on mips 34ke.
> >> >
> >> > Our target cache is 34kB 4way i/d-cache , 32bytes linesize.
> >> >
> >> > As you know, there is possibility of cache aliasing on 8kB per way.
> >> >
> >> > But mips arch of kernel mainline can not properly  handile this case.
> >> >
> >> > For example, highmem handling in __fluash_dcache_page function is just
> >> > return.
> >> >
> >> > So, if argument page is page in highmem, it can not flush in dcache
> >> > line.
> >> >
> >> > I want to listen your opinion.
> >> >
> >> > Thanks.
> >> >
> >> >
> >> > 2010/3/23 Minchan Kim <minchan.kim@gmail.com>:
> >> >> Hi, Ralf.
> >> >>
> >> >> Below is thread long time ago.
> >> >> At that time, we can't end up the problem by some reason.
> >> >> Sorry for that.
> >> >>
> >> >> The problem would occur, again.
> >> >>
> >> >> On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle <ralf@linux-mips.org>
> >> >> wrote:
> >> >>> On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:
> >> >>>
> >> >>>> Many code of kernel fs usually allocate high page and flush.
> >> >>>> But flush_dcache_page of mips checks PageHighMem to avoid flush
> >> >>>> so that data consistency is broken, I think.
> >> >>>
> >> >>> What processor and cache configuration?
> >> >>>
> >> >>>> I found it's by you and Atsushi-san on 585fa724.
> >> >>>> Why do we need the check?
> >> >>>> Could you elaborte please?
> >> >>>
> >> >>> The if statement exists because __flush_dcache_page would crash if a
> >> >>> page
> >> >>> is not mapped.  This of course isn't correct but that wasn't a
> problem
> >> >>> since highmem still is only supported on machines that don't have
> >> >>> aliases.
> >> >>>
> >> >>>  Ralf
> >> >>>
> >> >>
> >> >> Our system is following as.
> >> >>
> >> >> mips 34ke
> >> >> primary i-cache 32kB VIPT 4way 32 byte line size.
> >> >> primary d-cache 32kB 4way  32 bytes linesize
> >> >>
> >> >> If you have further questions, Namjae, Could you follow question of
> >> >> Ralf?
> >> >>
> >> >> --
> >> >> Kind regards,
> >> >> Minchan Kim
> >> >>
> >> >
> >>
> >
>

--f46d0447864b96084704ba0249cb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

HI NamJae:<br>=C2=A0=C2=A0=C2=A0 I think someone already published this pat=
ch, just can&#39;t remember when exactly~<br>Also, before we push this patc=
h into repository, should we have more reviews?<br>Is there any better solu=
tion? Should we always flush cache when it is highmem?<br>
=C2=A0=C2=A0=C2=A0 thanks<br><br>Dennis<br><br><div class=3D"gmail_quote">O=
n Tue, Feb 28, 2012 at 3:09 PM, Namjae Jeon <span dir=3D"ltr">&lt;<a href=
=3D"mailto:linkinjeon@gmail.com">linkinjeon@gmail.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
2012/2/28 Dennis.Yxun &lt;<a href=3D"mailto:dennis.yxun@gmail.com">dennis.y=
xun@gmail.com</a>&gt;:<br>
<div class=3D"im">&gt; Hi NamJae:<br>
&gt; =C2=A0We hit pretty much the same problem, highmem + cache consistence=
<br>
&gt; but our hardware should have cache alias problem<br>
&gt; =C2=A0Could you try attached following patch?<br>
</div>Hi Dennis.<br>
I already fixed it as your patch in our system before.<br>
your patch looks reasonable to me.<br>
Would you post this patch with adding the below ?<br>
<br>
Reviewed-by: Namjae Jeon &lt;<a href=3D"mailto:linkinjeon@gmail.com">linkin=
jeon@gmail.com</a>&gt;<br>
Tested-by: Namjae Jeon &lt;<a href=3D"mailto:linkinjeon@gmail.com">linkinje=
on@gmail.com</a>&gt;<br>
<br>
Thanks~<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; dmesg:<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] PID hash table entries: 1024 (order: 0, =
4096<br>
&gt; bytes)<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 32768 (=
order: 5, 131072<br>
&gt; bytes)<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash table entries: 16384 (o=
rder: 4, 65536<br>
&gt; bytes)<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] Primary instruction cache 16kB, VIPT, 4-=
way, linesize 32<br>
&gt; bytes.<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] Primary data cache 16kB, 4-way, VIPT, no=
 aliases, linesize 32<br>
&gt; byt<br>
&gt; es<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] MIPS secondary cache 128kB, 8-way, lines=
ize 32<br>
&gt; bytes.<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] Writing ErrCtl<br>
&gt; register=3D00000000<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] Readback ErrCtl<br>
&gt; register=3D00000000<br>
&gt; [=C2=A0=C2=A0=C2=A0 0.000000] Memory: 510548k/262144k available (2728k=
 kernel code, 13740k<br>
&gt; rese<br>
&gt; rved, 630k data, 5784k init, 262144k highmem)<br>
&gt;<br>
&gt; diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c<br>
&gt; index 00d70c8..536b7f9 100644<br>
&gt; --- a/arch/mips/mm/cache.c<br>
&gt; +++ b/arch/mips/mm/cache.c<br>
&gt; @@ -15,6 +15,7 @@<br>
&gt; =C2=A0#include &lt;linux/sched.h&gt;<br>
&gt; =C2=A0#include &lt;linux/syscalls.h&gt;<br>
&gt; =C2=A0#include &lt;linux/mm.h&gt;<br>
&gt; +#include &lt;linux/highmem.h&gt;<br>
&gt;<br>
&gt; =C2=A0#include &lt;asm/cacheflush.h&gt;<br>
&gt; =C2=A0#include &lt;asm/processor.h&gt;<br>
&gt; @@ -83,8 +84,13 @@ void __flush_dcache_page(struct page *page)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mappi=
ng =3D page_mapping(page);<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long addr;<br>
&gt;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PageHighMem(page))<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PageHighMem(page) &amp;&amp;=
<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (addr =3D (unsigned long) kmap_atomic(page, KM_SYNC_DCACHE)=
))<br>
&gt; {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 flush_data_cache_page(addr);<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 kunmap_atomic((void *)addr, KM_SYNC_DCACHE);<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Apr 5, 2011 at 4:17 PM, NamJae Jeon &lt;<a href=3D"mailto:link=
injeon@gmail.com">linkinjeon@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi.<br>
&gt;&gt;<br>
&gt;&gt; As you know, there is cache operation about highpage in arm arch.<=
br>
&gt;&gt;<br>
&gt;&gt; arch/arm/mm/flush.c<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------------------------------------------=
-----------------------------<br>
&gt;&gt; if (!PageHighMem(page)) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__cpuc_flus=
h_dcache_area(page_address(page), PAGE_SIZE);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *addr =
=3D kmap_high_get(page);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr) {=
<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0__cpuc_flush_dcache_area(addr, PAGE_SIZE);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0kunmap_high(page);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (=
cache_is_vipt()) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* unmapped pages might still be cached */<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0addr =3D kmap_atomic(page);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0__cpuc_flush_dcache_area(addr, PAGE_SIZE);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0kunmap_atomic(addr);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------------------------------------------=
-------------------------------<br>
&gt;&gt;<br>
&gt;&gt; currently, mips kernel just return without cache operation.<br>
&gt;&gt;<br>
&gt;&gt; Would you plz tell me your opinion ?<br>
&gt;&gt;<br>
&gt;&gt; Thanks.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; 2010/3/23 NamJae Jeon &lt;<a href=3D"mailto:linkinjeon@gmail.com">=
linkinjeon@gmail.com</a>&gt;:<br>
&gt;&gt; &gt; Hi. Ralf.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;m Namjae.jeon. nice to meet you.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I face cache aliasing problem on mips 34ke.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Our target cache is 34kB 4way i/d-cache , 32bytes linesize.<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; As you know, there is possibility of cache aliasing on 8kB pe=
r way.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; But mips arch of kernel mainline can not properly =C2=A0handi=
le this case.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; For example, highmem handling in __fluash_dcache_page functio=
n is just<br>
&gt;&gt; &gt; return.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So, if argument page is page in highmem, it can not flush in =
dcache<br>
&gt;&gt; &gt; line.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I want to listen your opinion.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 2010/3/23 Minchan Kim &lt;<a href=3D"mailto:minchan.kim@gmail=
.com">minchan.kim@gmail.com</a>&gt;:<br>
&gt;&gt; &gt;&gt; Hi, Ralf.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Below is thread long time ago.<br>
&gt;&gt; &gt;&gt; At that time, we can&#39;t end up the problem by some rea=
son.<br>
&gt;&gt; &gt;&gt; Sorry for that.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The problem would occur, again.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle &lt;<a href=
=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt;<br>
&gt;&gt; &gt;&gt; wrote:<br>
&gt;&gt; &gt;&gt;&gt; On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim=
 wrote:<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; Many code of kernel fs usually allocate high page=
 and flush.<br>
&gt;&gt; &gt;&gt;&gt;&gt; But flush_dcache_page of mips checks PageHighMem =
to avoid flush<br>
&gt;&gt; &gt;&gt;&gt;&gt; so that data consistency is broken, I think.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; What processor and cache configuration?<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; I found it&#39;s by you and Atsushi-san on 585fa7=
24.<br>
&gt;&gt; &gt;&gt;&gt;&gt; Why do we need the check?<br>
&gt;&gt; &gt;&gt;&gt;&gt; Could you elaborte please?<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; The if statement exists because __flush_dcache_page w=
ould crash if a<br>
&gt;&gt; &gt;&gt;&gt; page<br>
&gt;&gt; &gt;&gt;&gt; is not mapped. =C2=A0This of course isn&#39;t correct=
 but that wasn&#39;t a problem<br>
&gt;&gt; &gt;&gt;&gt; since highmem still is only supported on machines tha=
t don&#39;t have<br>
&gt;&gt; &gt;&gt;&gt; aliases.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; =C2=A0Ralf<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Our system is following as.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; mips 34ke<br>
&gt;&gt; &gt;&gt; primary i-cache 32kB VIPT 4way 32 byte line size.<br>
&gt;&gt; &gt;&gt; primary d-cache 32kB 4way =C2=A032 bytes linesize<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; If you have further questions, Namjae, Could you follow q=
uestion of<br>
&gt;&gt; &gt;&gt; Ralf?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; Kind regards,<br>
&gt;&gt; &gt;&gt; Minchan Kim<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;<br>
</div></div></blockquote></div><br>

--f46d0447864b96084704ba0249cb--
