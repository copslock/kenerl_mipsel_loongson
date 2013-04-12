Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Apr 2013 16:15:47 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:53218 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816859Ab3DLDIDT-I-j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Apr 2013 05:08:03 +0200
Received: by mail-bk0-f49.google.com with SMTP id w12so1139767bku.22
        for <multiple recipients>; Thu, 11 Apr 2013 20:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=BGuLmSOHjHahGBRnN2jvJx2KEPi8IvhUN0n+M04LptU=;
        b=PeuQS2AB6KnNZnI1D9ybYHdEx1mGDi6L2m7ArqwwWnpZgCaiLdhOkoCBd6LA46zeI0
         OwbDNFuvApEl0knuGFaS6e0ILjsOKG6fMSvbS7/ds7xGWQ0/8xMJuJYoYdNsY2vAFUun
         YQFiOtS0MFKJQnmROUoCKiHFLZCqVrmvQ9EmS6GMeq6kronYY5APwLcVMdPjjPASoZnL
         zHBZ8I8TqHnolhTobeMH/t/8ExY9ZpZJyXIqmFYP3oLZEunWlSn37vZQ8bYHByrrqddY
         FWQtVfYoGBy91+uLpWY9IXenJthLDXj9hFlktzXid0+dXjE5lnRPGmruR12zX3RXabPE
         8Luw==
MIME-Version: 1.0
X-Received: by 10.205.114.195 with SMTP id fb3mr3447298bkc.117.1365736077631;
 Thu, 11 Apr 2013 20:07:57 -0700 (PDT)
Received: by 10.204.24.207 with HTTP; Thu, 11 Apr 2013 20:07:57 -0700 (PDT)
In-Reply-To: <5166ED66.7020307@realitydiluted.com>
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
        <1359527106-22879-4-git-send-email-chenhc@lemote.com>
        <5166ED66.7020307@realitydiluted.com>
Date:   Fri, 12 Apr 2013 11:07:57 +0800
X-Google-Sender-Auth: entioqQ06crbTVru6TxRRCWl4QA
Message-ID: <CAAhV-H6s47NUHzbEX5UKYtkei7=s08PPXCMw39_fP_SV7Hv5Vg@mail.gmail.com>
Subject: Re: [PATCH V9 03/13] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
From:   Huacai Chen <chenhc@lemote.com>
To:     "Steven J. Hill" <sjhill@realitydiluted.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: multipart/alternative; boundary=14dae9473693c3d15904da21351b
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36290
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--14dae9473693c3d15904da21351b
Content-Type: text/plain; charset=ISO-8859-1

Hi, Steven,

Maybe you are misunderstand Loongson-3's "hardware-maintained cache".
Loongson-3's hardware maintain the cache coherency between multi-cores
(also maintain coherency between CPU-core and DMA), but Loongson-3 can
*still* has cache alias (Cache alias in Loongson is sovled by 16K PageSize).

Meanwhile, I know why you misunderstand, because my code is like this:

static inline void local_r4k___flush_cache_all(void * args)
        if (cpu_has_coherent_cache)
                return;

This implies that Loongson-3 has no cache alias, but in fact this is wrong
if Loongson has configured PageSize < 16K.

I think I should make my code in all flush functions like this:
static inline void local_r4k___flush_cache_all(void * args)
        if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
                return;

Am I right?


On Fri, Apr 12, 2013 at 1:05 AM, Steven J. Hill
<sjhill@realitydiluted.com>wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/30/2013 12:24 AM, Huacai Chen wrote:
> > Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
> > feature named cpu_has_coherent_cache and use it to modify MIPS's cache
> > flushing functions.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com> Signed-off-by: Hongliang
> Tao
> > <taohl@lemote.com> Signed-off-by: Hua Yan <yanh@lemote.com> ---
> > arch/mips/include/asm/cacheflush.h                 |    6 +++++
> > arch/mips/include/asm/cpu-features.h               |    3 ++
> > .../asm/mach-loongson/cpu-feature-overrides.h      |    6 +++++
> > arch/mips/mm/c-r4k.c                               |   21
> > ++++++++++++++++++- 4 files changed, 34 insertions(+), 2 deletions(-)
> >
> Hello.
>
> This patch masks the problem that you are not properly probing your L1
> caches
> to start with. For some reason in 'probe_pcache()' you reach the default
> case
> where the primary data cache is marked as having aliases. If your CPU
> truly is
> HW coherent with no aliases, then MIPS_CACHE_ALIASES should never get set.
> Fixing this would eliminate the 'arch/mips/include/asm/cacheflush.h' and
> 'arch/mips/mm/c-r4k.c' changes completely. There is no need to add more CPU
> feature bits for this single platform, thus changes to 'cpu-features.h' and
> 'cpu-features-overrides.h' will not be accepted.
>
> Also, please do not copy the <linux-kernel@vger.kernel.org> mailing list
> unless your patch touches files outside of 'arch/mips' in order to cut down
> traffic on an already busy list. Thanks.
>
> Steve
> - -----
> <sjhill@mips.com>
> <Steven.Hill@imgtec.com>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlFm7WAACgkQgyK5H2Ic36eHuwCeKZjp1+arkoheEpeuzjJkQskN
> /7MAnig14A03hWxRvfqDOMbMFKXpZBO8
> =HRPU
> -----END PGP SIGNATURE-----
>
>

--14dae9473693c3d15904da21351b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi, Steven,<br><br></div>May=
be you are misunderstand Loongson-3&#39;s &quot;hardware-maintained cache&q=
uot;. Loongson-3&#39;s hardware maintain the cache coherency between multi-=
cores (also maintain coherency between CPU-core and DMA), but Loongson-3 ca=
n *still* has cache alias (Cache alias in Loongson is sovled by 16K PageSiz=
e).<br>
<br></div>Meanwhile, I know why you misunderstand, because my code is like =
this:<br><br>static inline void local_r4k___flush_cache_all(void * args)<br=
>=A0=A0=A0=A0=A0=A0=A0 if (cpu_has_coherent_cache)<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 return;<br><br>
</div>This implies that Loongson-3 has no cache alias, but in fact this is =
wrong if Loongson has configured PageSize &lt; 16K.<br></div><br></div>I th=
ink I should make my code in all flush functions like this:<br>static inlin=
e void local_r4k___flush_cache_all(void * args)<br>
=A0=A0=A0=A0=A0=A0=A0 if (cpu_has_coherent_cache &amp;&amp; !cpu_has_dc_ali=
ases)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;<br><br></div=
>Am I right?<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmai=
l_quote">On Fri, Apr 12, 2013 at 1:05 AM, Steven J. Hill <span dir=3D"ltr">=
&lt;<a href=3D"mailto:sjhill@realitydiluted.com" target=3D"_blank">sjhill@r=
ealitydiluted.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<div class=3D"im"><br>
On 01/30/2013 12:24 AM, Huacai Chen wrote:<br>
&gt; Loongson-3 maintains cache coherency by hardware. So we introduce a cp=
u<br>
&gt; feature named cpu_has_coherent_cache and use it to modify MIPS&#39;s c=
ache<br>
&gt; flushing functions.<br>
&gt;<br>
&gt; Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">ch=
enhc@lemote.com</a>&gt; Signed-off-by: Hongliang Tao<br>
&gt; &lt;<a href=3D"mailto:taohl@lemote.com">taohl@lemote.com</a>&gt; Signe=
d-off-by: Hua Yan &lt;<a href=3D"mailto:yanh@lemote.com">yanh@lemote.com</a=
>&gt; ---<br>
&gt; arch/mips/include/asm/cacheflush.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A06 +++++<br>
&gt; arch/mips/include/asm/cpu-features.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A03 ++<br>
&gt; .../asm/mach-loongson/cpu-feature-overrides.h =A0 =A0 =A0| =A0 =A06 ++=
+++<br>
&gt; arch/mips/mm/c-r4k.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 21<br>
&gt; ++++++++++++++++++- 4 files changed, 34 insertions(+), 2 deletions(-)<=
br>
&gt;<br>
</div>Hello.<br>
<br>
This patch masks the problem that you are not properly probing your L1 cach=
es<br>
to start with. For some reason in &#39;probe_pcache()&#39; you reach the de=
fault case<br>
where the primary data cache is marked as having aliases. If your CPU truly=
 is<br>
HW coherent with no aliases, then MIPS_CACHE_ALIASES should never get set.<=
br>
Fixing this would eliminate the &#39;arch/mips/include/asm/cacheflush.h&#39=
; and<br>
&#39;arch/mips/mm/c-r4k.c&#39; changes completely. There is no need to add =
more CPU<br>
feature bits for this single platform, thus changes to &#39;cpu-features.h&=
#39; and<br>
&#39;cpu-features-overrides.h&#39; will not be accepted.<br>
<br>
Also, please do not copy the &lt;<a href=3D"mailto:linux-kernel@vger.kernel=
.org">linux-kernel@vger.kernel.org</a>&gt; mailing list<br>
unless your patch touches files outside of &#39;arch/mips&#39; in order to =
cut down<br>
traffic on an already busy list. Thanks.<br>
<br>
Steve<br>
- -----<br>
&lt;<a href=3D"mailto:sjhill@mips.com">sjhill@mips.com</a>&gt;<br>
&lt;<a href=3D"mailto:Steven.Hill@imgtec.com">Steven.Hill@imgtec.com</a>&gt=
;<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.11 (GNU/Linux)<br>
Comment: Using GnuPG with Thunderbird - <a href=3D"http://www.enigmail.net/=
" target=3D"_blank">http://www.enigmail.net/</a><br>
<br>
iEYEARECAAYFAlFm7WAACgkQgyK5H2Ic36eHuwCeKZjp1+arkoheEpeuzjJkQskN<br>
/7MAnig14A03hWxRvfqDOMbMFKXpZBO8<br>
=3DHRPU<br>
-----END PGP SIGNATURE-----<br>
<br>
</blockquote></div><br></div>

--14dae9473693c3d15904da21351b--
