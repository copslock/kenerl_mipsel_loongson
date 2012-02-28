Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 04:03:17 +0100 (CET)
Received: from mail-tul01m020-f177.google.com ([209.85.214.177]:63680 "EHLO
        mail-tul01m020-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903774Ab2B1DDJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 04:03:09 +0100
Received: by obcuz6 with SMTP id uz6so7520503obc.36
        for <multiple recipients>; Mon, 27 Feb 2012 19:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uRGxvOeQhK9Q9dDkJO58lrpWHx+c0JyUYLCVs6WTMvg=;
        b=uzuMwhIN9ogs94PD34ZtxKshm2NVksdBgW6FANbbJN6koR+jscLQx93wnRcGluya+C
         HEFc8A33jsdQadAZhjTxASTOgp9VYvcFZ7PacIr9RrFDMUuzpo74AhVjWbe/WmO33Gy0
         a83FxNFcaq+W9kwQsbi5veniWy6lifIhIyn7A=
MIME-Version: 1.0
Received: by 10.182.38.7 with SMTP id c7mr5319418obk.44.1330398182673; Mon, 27
 Feb 2012 19:03:02 -0800 (PST)
Received: by 10.182.220.68 with HTTP; Mon, 27 Feb 2012 19:03:02 -0800 (PST)
In-Reply-To: <BANLkTimKw3mg8N-gBxh3jbo9msaHOF3qPA@mail.gmail.com>
References: <28c262361003230146o7bca61e6h3af2062b1172fdb2@mail.gmail.com>
        <afc622a1003230511o108556f4s5d1282bd3122b3d9@mail.gmail.com>
        <BANLkTimKw3mg8N-gBxh3jbo9msaHOF3qPA@mail.gmail.com>
Date:   Tue, 28 Feb 2012 11:03:02 +0800
Message-ID: <CAF1ZMEdh19eNbknfNskQxKeo0sjP7ELOAdRi9zD5VEqTLBXj6Q@mail.gmail.com>
Subject: Re: data consistency of high page
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     NamJae Jeon <linkinjeon@gmail.com>
Cc:     Minchan Kim <minchan.kim@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>, yan@mips.com
Content-Type: multipart/alternative; boundary=f46d0447f28c168b6504b9fd77d8
X-archive-position: 32568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--f46d0447f28c168b6504b9fd77d8
Content-Type: text/plain; charset=UTF-8

Hi NamJae:
 We hit pretty much the same problem, highmem + cache consistence
but our hardware should have cache alias problem
 Could you try attached following patch?

dmesg:
[    0.000000] PID hash table entries: 1024 (order: 0, 4096
bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.000000] Primary instruction cache 16kB, VIPT, 4-way, linesize 32
bytes.
[    0.000000] Primary data cache 16kB, 4-way, VIPT, no aliases, linesize
32 byt
es

[    0.000000] MIPS secondary cache 128kB, 8-way, linesize 32
bytes.
[    0.000000] Writing ErrCtl
register=00000000
[    0.000000] Readback ErrCtl
register=00000000
[    0.000000] Memory: 510548k/262144k available (2728k kernel code, 13740k
rese
rved, 630k data, 5784k init, 262144k highmem)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 00d70c8..536b7f9 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/syscalls.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>

 #include <asm/cacheflush.h>
 #include <asm/processor.h>
@@ -83,8 +84,13 @@ void __flush_dcache_page(struct page *page)
        struct address_space *mapping = page_mapping(page);
        unsigned long addr;

-       if (PageHighMem(page))
+       if (PageHighMem(page) &&
+               (addr = (unsigned long) kmap_atomic(page, KM_SYNC_DCACHE)))
{
+               flush_data_cache_page(addr);
+               kunmap_atomic((void *)addr, KM_SYNC_DCACHE);
                return;
+       }


On Tue, Apr 5, 2011 at 4:17 PM, NamJae Jeon <linkinjeon@gmail.com> wrote:

> Hi.
>
> As you know, there is cache operation about highpage in arm arch.
>
> arch/arm/mm/flush.c
>
> -----------------------------------------------------------------------------------------------
> if (!PageHighMem(page)) {
>                __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
>        } else {
>                void *addr = kmap_high_get(page);
>                if (addr) {
>                        __cpuc_flush_dcache_area(addr, PAGE_SIZE);
>                        kunmap_high(page);
>                } else if (cache_is_vipt()) {
>                        /* unmapped pages might still be cached */
>                        addr = kmap_atomic(page);
>                        __cpuc_flush_dcache_area(addr, PAGE_SIZE);
>                        kunmap_atomic(addr);
>                }
>        }
>
> -------------------------------------------------------------------------------------------------
>
> currently, mips kernel just return without cache operation.
>
> Would you plz tell me your opinion ?
>
> Thanks.
>
>
> 2010/3/23 NamJae Jeon <linkinjeon@gmail.com>:
> > Hi. Ralf.
> >
> > I'm Namjae.jeon. nice to meet you.
> >
> > I face cache aliasing problem on mips 34ke.
> >
> > Our target cache is 34kB 4way i/d-cache , 32bytes linesize.
> >
> > As you know, there is possibility of cache aliasing on 8kB per way.
> >
> > But mips arch of kernel mainline can not properly  handile this case.
> >
> > For example, highmem handling in __fluash_dcache_page function is just
> return.
> >
> > So, if argument page is page in highmem, it can not flush in dcache line.
> >
> > I want to listen your opinion.
> >
> > Thanks.
> >
> >
> > 2010/3/23 Minchan Kim <minchan.kim@gmail.com>:
> >> Hi, Ralf.
> >>
> >> Below is thread long time ago.
> >> At that time, we can't end up the problem by some reason.
> >> Sorry for that.
> >>
> >> The problem would occur, again.
> >>
> >> On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle <ralf@linux-mips.org>
> wrote:
> >>> On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:
> >>>
> >>>> Many code of kernel fs usually allocate high page and flush.
> >>>> But flush_dcache_page of mips checks PageHighMem to avoid flush
> >>>> so that data consistency is broken, I think.
> >>>
> >>> What processor and cache configuration?
> >>>
> >>>> I found it's by you and Atsushi-san on 585fa724.
> >>>> Why do we need the check?
> >>>> Could you elaborte please?
> >>>
> >>> The if statement exists because __flush_dcache_page would crash if a
> page
> >>> is not mapped.  This of course isn't correct but that wasn't a problem
> >>> since highmem still is only supported on machines that don't have
> aliases.
> >>>
> >>>  Ralf
> >>>
> >>
> >> Our system is following as.
> >>
> >> mips 34ke
> >> primary i-cache 32kB VIPT 4way 32 byte line size.
> >> primary d-cache 32kB 4way  32 bytes linesize
> >>
> >> If you have further questions, Namjae, Could you follow question of
> Ralf?
> >>
> >> --
> >> Kind regards,
> >> Minchan Kim
> >>
> >
>
>

--f46d0447f28c168b6504b9fd77d8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi NamJae:<br>=C2=A0We hit pretty much the same problem, highmem + cache co=
nsistence<br>but our hardware should have cache alias problem<br>=C2=A0Coul=
d you try attached following patch?<br><br>dmesg:<br>[=C2=A0=C2=A0=C2=A0 0.=
000000] PID hash table entries: 1024 (order: 0, 4096 bytes)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
[=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 32768 (order=
: 5, 131072 bytes)=C2=A0 <br>[=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash=
 table entries: 16384 (order: 4, 65536 bytes)=C2=A0=C2=A0=C2=A0 <br>[=C2=A0=
=C2=A0=C2=A0 0.000000] Primary instruction cache 16kB, VIPT, 4-way, linesiz=
e 32 bytes.=C2=A0 <br>
[=C2=A0=C2=A0=C2=A0 0.000000] Primary data cache 16kB, 4-way, VIPT, no alia=
ses, linesize 32 byt<br>es=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>[=C2=A0=C2=A0=C2=A0 0.000000] M=
IPS secondary cache 128kB, 8-way, linesize 32 bytes.=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
[=C2=A0=C2=A0=C2=A0 0.000000] Writing ErrCtl register=3D00000000=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>[=C2=A0=C2=A0=C2=A0 0.000000] Readbac=
k ErrCtl register=3D00000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>[=C2=
=A0=C2=A0=C2=A0 0.000000] Memory: 510548k/262144k available (2728k kernel c=
ode, 13740k rese<br>
rved, 630k data, 5784k init, 262144k highmem) <br><br>diff --git a/arch/mip=
s/mm/cache.c b/arch/mips/mm/cache.c<br>index 00d70c8..536b7f9 100644<br>---=
 a/arch/mips/mm/cache.c<br>+++ b/arch/mips/mm/cache.c<br>@@ -15,6 +15,7 @@<=
br>
=C2=A0#include &lt;linux/sched.h&gt;<br>=C2=A0#include &lt;linux/syscalls.h=
&gt;<br>=C2=A0#include &lt;linux/mm.h&gt;<br>+#include &lt;linux/highmem.h&=
gt;<br>=C2=A0<br>=C2=A0#include &lt;asm/cacheflush.h&gt;<br>=C2=A0#include =
&lt;asm/processor.h&gt;<br>
@@ -83,8 +84,13 @@ void __flush_dcache_page(struct page *page)<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D page_ma=
pping(page);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long ad=
dr;<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PageHighMem(page=
))<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PageHighMem(page) &amp;&amp=
;<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (addr =3D (unsigned long) kmap_atomic(page, KM_SYNC_DCACHE))) =
{<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 flush_data_cache_page(addr);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kunmap_atomic(=
(void *)addr, KM_SYNC_DCACHE);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
<br><br><div class=3D"gmail_quote">On Tue, Apr 5, 2011 at 4:17 PM, NamJae J=
eon <span dir=3D"ltr">&lt;<a href=3D"mailto:linkinjeon@gmail.com">linkinjeo=
n@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi.<br>
<br>
As you know, there is cache operation about highpage in arm arch.<br>
<br>
arch/arm/mm/flush.c<br>
---------------------------------------------------------------------------=
--------------------<br>
if (!PageHighMem(page)) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__cpuc_flush_dcache=
_area(page_address(page), PAGE_SIZE);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *addr =3D kmap=
_high_get(page);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__cpuc_flush_dcache_area(addr, PAGE_SIZE);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0kunmap_high(page);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (cache_is=
_vipt()) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* unmapped pages might still be cached */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0addr =3D kmap_atomic(page);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__cpuc_flush_dcache_area(addr, PAGE_SIZE);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0kunmap_atomic(addr);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
---------------------------------------------------------------------------=
----------------------<br>
<br>
currently, mips kernel just return without cache operation.<br>
<br>
Would you plz tell me your opinion ?<br>
<br>
Thanks.<br>
<br>
<br>
2010/3/23 NamJae Jeon &lt;<a href=3D"mailto:linkinjeon@gmail.com">linkinjeo=
n@gmail.com</a>&gt;:<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; Hi. Ralf.<br>
&gt;<br>
&gt; I&#39;m Namjae.jeon. nice to meet you.<br>
&gt;<br>
&gt; I face cache aliasing problem on mips 34ke.<br>
&gt;<br>
&gt; Our target cache is 34kB 4way i/d-cache , 32bytes linesize.<br>
&gt;<br>
&gt; As you know, there is possibility of cache aliasing on 8kB per way.<br=
>
&gt;<br>
&gt; But mips arch of kernel mainline can not properly =C2=A0handile this c=
ase.<br>
&gt;<br>
&gt; For example, highmem handling in __fluash_dcache_page function is just=
 return.<br>
&gt;<br>
&gt; So, if argument page is page in highmem, it can not flush in dcache li=
ne.<br>
&gt;<br>
&gt; I want to listen your opinion.<br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
&gt;<br>
&gt; 2010/3/23 Minchan Kim &lt;<a href=3D"mailto:minchan.kim@gmail.com">min=
chan.kim@gmail.com</a>&gt;:<br>
&gt;&gt; Hi, Ralf.<br>
&gt;&gt;<br>
&gt;&gt; Below is thread long time ago.<br>
&gt;&gt; At that time, we can&#39;t end up the problem by some reason.<br>
&gt;&gt; Sorry for that.<br>
&gt;&gt;<br>
&gt;&gt; The problem would occur, again.<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle &lt;<a href=3D"mailt=
o:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:<br>
&gt;&gt;&gt; On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Many code of kernel fs usually allocate high page and flus=
h.<br>
&gt;&gt;&gt;&gt; But flush_dcache_page of mips checks PageHighMem to avoid =
flush<br>
&gt;&gt;&gt;&gt; so that data consistency is broken, I think.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; What processor and cache configuration?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I found it&#39;s by you and Atsushi-san on 585fa724.<br>
&gt;&gt;&gt;&gt; Why do we need the check?<br>
&gt;&gt;&gt;&gt; Could you elaborte please?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The if statement exists because __flush_dcache_page would cras=
h if a page<br>
&gt;&gt;&gt; is not mapped. =C2=A0This of course isn&#39;t correct but that=
 wasn&#39;t a problem<br>
&gt;&gt;&gt; since highmem still is only supported on machines that don&#39=
;t have aliases.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0Ralf<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Our system is following as.<br>
&gt;&gt;<br>
&gt;&gt; mips 34ke<br>
&gt;&gt; primary i-cache 32kB VIPT 4way 32 byte line size.<br>
&gt;&gt; primary d-cache 32kB 4way =C2=A032 bytes linesize<br>
&gt;&gt;<br>
&gt;&gt; If you have further questions, Namjae, Could you follow question o=
f Ralf?<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Kind regards,<br>
&gt;&gt; Minchan Kim<br>
&gt;&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br>

--f46d0447f28c168b6504b9fd77d8--
