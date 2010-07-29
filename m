Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2010 03:24:19 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:39170 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492196Ab0G2BYO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jul 2010 03:24:14 +0200
Received: by pzk3 with SMTP id 3so25830pzk.36
        for <multiple recipients>; Wed, 28 Jul 2010 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0bi+7STJbxWM6UN1d5SkpF6YhBCp1jTFMq2iQh1BrCY=;
        b=qL12zKR82S7FGI1Jq6FO/R5wWtxnE81YNessALyKWuBkUfjLmFxcBGeGXmJKkdqmdO
         qZnCIpGdNfLoHh+tVimRwRooBIiRe48PR5PsjBhIVII3bZzj93/OYJsweSVOSzjlvSNy
         S7riRZK+YAdWKuXprGOH43WcATQAa/ByZDy5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mg/px9v3QVYKnRhGzpsNzBG4cTbhwhpF5DP9l+MFE8OsxiJe2NmR+v4APS4vG6X7KG
         CIO4oU8nwx4xR5OUMfFtM6Iyy84In1YGzK2iyk8qqnOh6K66aWLYgwvndwU2n477n/Ki
         CXozJ6wFVnC2ulXjpb1L3vexbof8vLln+0FME=
MIME-Version: 1.0
Received: by 10.142.231.14 with SMTP id d14mr12531490wfh.129.1280366647578; 
        Wed, 28 Jul 2010 18:24:07 -0700 (PDT)
Received: by 10.142.232.14 with HTTP; Wed, 28 Jul 2010 18:24:07 -0700 (PDT)
In-Reply-To: <503ec883993ca4be3a5680bf52091bf0fcf37357.1270655886.git.wuzhangjin@gmail.com>
References: <cover.1270655886.git.wuzhangjin@gmail.com>
        <cover.1270653461.git.wuzhangjin@gmail.com>
        <503ec883993ca4be3a5680bf52091bf0fcf37357.1270655886.git.wuzhangjin@gmail.com>
Date:   Thu, 29 Jul 2010 09:24:07 +0800
Message-ID: <AANLkTikq5_XDmtOz9T9txzfF1nr2bFDXJCvRXiG4_g5r@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] MIPS: cavium-octeon: rewrite the sched_clock() 
        based on mips_cyc2ns()
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>,
        =?ISO-8859-1?Q?Ralf_R=F6sch?= <roesch.ralf@web.de>
Content-Type: multipart/alternative; boundary=000e0cd29c9c3610be048c7c97de
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

--000e0cd29c9c3610be048c7c97de
Content-Type: text/plain; charset=ISO-8859-1

Hi, Ralf

This may be not applicable for the original version is changed by

[PATCH] OCTEON: workaround linking failures with gcc-4.4.x 32-bits
toolchains

from Florian Fainelli.

Regards,
Wu Zhangjin

On Thu, Apr 8, 2010 at 12:05 AM, Wu Zhangin <wuzhangjin@gmail.com> wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
>
> Changes from v1:
>
>  o use the new interface mips_cyc2ns() intead of the old
>  mips_sched_clock().
>
> The commit "MIPS: add a common mips_cyc2ns()" have abstracted the
> solution of the 64bit calculation's overflow problem into a common
> mips_cyc2ns() function in arch/mips/include/asm/time.h, This patch just
> rewrites the sched_clock() for cavium-octeon on it.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/cavium-octeon/csrc-octeon.c |   29 ++---------------------------
>  1 files changed, 2 insertions(+), 27 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/csrc-octeon.c
> b/arch/mips/cavium-octeon/csrc-octeon.c
> index 0bf4bbe..bca0004 100644
> --- a/arch/mips/cavium-octeon/csrc-octeon.c
> +++ b/arch/mips/cavium-octeon/csrc-octeon.c
> @@ -52,34 +52,9 @@ static struct clocksource clocksource_mips = {
>
>  unsigned long long notrace sched_clock(void)
>  {
> -       /* 64-bit arithmatic can overflow, so use 128-bit.  */
> -#if (__GNUC__ < 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ <= 3))
> -       u64 t1, t2, t3;
> -       unsigned long long rv;
> -       u64 mult = clocksource_mips.mult;
> -       u64 shift = clocksource_mips.shift;
> -       u64 cnt = read_c0_cvmcount();
> +       u64 cyc = read_c0_cvmcount();
>
> -       asm (
> -               "dmultu\t%[cnt],%[mult]\n\t"
> -               "nor\t%[t1],$0,%[shift]\n\t"
> -               "mfhi\t%[t2]\n\t"
> -               "mflo\t%[t3]\n\t"
> -               "dsll\t%[t2],%[t2],1\n\t"
> -               "dsrlv\t%[rv],%[t3],%[shift]\n\t"
> -               "dsllv\t%[t1],%[t2],%[t1]\n\t"
> -               "or\t%[rv],%[t1],%[rv]\n\t"
> -               : [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3]
> "=&r" (t3)
> -               : [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
> -               : "hi", "lo");
> -       return rv;
> -#else
> -       /* GCC > 4.3 do it the easy way.  */
> -       unsigned int __attribute__((mode(TI))) t;
> -       t = read_c0_cvmcount();
> -       t = t * clocksource_mips.mult;
> -       return (unsigned long long)(t >> clocksource_mips.shift);
> -#endif
> +       return mips_cyc2ns(cyc, clocksource_mips.mult,
> clocksource_mips.shift);
>  }
>
>  void __init plat_time_init(void)
> --
> 1.7.0.1
>
>


-- 
MSN+Gtalk: wuzhangjin@gmail.com
Blog: http://falcon.oss.lzu.edu.cn
Tel:+86-18710032278

--000e0cd29c9c3610be048c7c97de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, Ralf<br><br>This may be not applicable for the original version is chan=
ged by<br><br>[PATCH] OCTEON: workaround linking failures with gcc-4.4.x 32=
-bits toolchains<br><br>from <span class=3D"gI">Florian Fainelli.<br><br>Re=
gards,<br>
Wu Zhangjin<br></span><br><div class=3D"gmail_quote">On Thu, Apr 8, 2010 at=
 12:05 AM, Wu Zhangin <span dir=3D"ltr">&lt;<a href=3D"mailto:wuzhangjin@gm=
ail.com">wuzhangjin@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">
From: Wu Zhangjin &lt;<a href=3D"mailto:wuzhangjin@gmail.com">wuzhangjin@gm=
ail.com</a>&gt;<br>
<br>
Changes from v1:<br>
<br>
 =A0o use the new interface mips_cyc2ns() intead of the old<br>
 =A0mips_sched_clock().<br>
<br>
The commit &quot;MIPS: add a common mips_cyc2ns()&quot; have abstracted the=
<br>
solution of the 64bit calculation&#39;s overflow problem into a common<br>
mips_cyc2ns() function in arch/mips/include/asm/time.h, This patch just<br>
rewrites the sched_clock() for cavium-octeon on it.<br>
<br>
Signed-off-by: Wu Zhangjin &lt;<a href=3D"mailto:wuzhangjin@gmail.com">wuzh=
angjin@gmail.com</a>&gt;<br>
---<br>
=A0arch/mips/cavium-octeon/csrc-octeon.c | =A0 29 ++-----------------------=
----<br>
=A01 files changed, 2 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeo=
n/csrc-octeon.c<br>
index 0bf4bbe..bca0004 100644<br>
--- a/arch/mips/cavium-octeon/csrc-octeon.c<br>
+++ b/arch/mips/cavium-octeon/csrc-octeon.c<br>
@@ -52,34 +52,9 @@ static struct clocksource clocksource_mips =3D {<br>
<br>
=A0unsigned long long notrace sched_clock(void)<br>
=A0{<br>
- =A0 =A0 =A0 /* 64-bit arithmatic can overflow, so use 128-bit. =A0*/<br>
-#if (__GNUC__ &lt; 4) || ((__GNUC__ =3D=3D 4) &amp;&amp; (__GNUC_MINOR__ &=
lt;=3D 3))<br>
- =A0 =A0 =A0 u64 t1, t2, t3;<br>
- =A0 =A0 =A0 unsigned long long rv;<br>
- =A0 =A0 =A0 u64 mult =3D clocksource_mips.mult;<br>
- =A0 =A0 =A0 u64 shift =3D clocksource_mips.shift;<br>
- =A0 =A0 =A0 u64 cnt =3D read_c0_cvmcount();<br>
+ =A0 =A0 =A0 u64 cyc =3D read_c0_cvmcount();<br>
<br>
- =A0 =A0 =A0 asm (<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;dmultu\t%[cnt],%[mult]\n\t&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;nor\t%[t1],$0,%[shift]\n\t&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;mfhi\t%[t2]\n\t&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;mflo\t%[t3]\n\t&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;dsll\t%[t2],%[t2],1\n\t&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;dsrlv\t%[rv],%[t3],%[shift]\n\t&quot;<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;dsllv\t%[t1],%[t2],%[t1]\n\t&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;or\t%[rv],%[t1],%[rv]\n\t&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [rv] &quot;=3D&amp;r&quot; (rv), [t1] &quot=
;=3D&amp;r&quot; (t1), [t2] &quot;=3D&amp;r&quot; (t2), [t3] &quot;=3D&amp;=
r&quot; (t3)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [cnt] &quot;r&quot; (cnt), [mult] &quot;r&q=
uot; (mult), [shift] &quot;r&quot; (shift)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 : &quot;hi&quot;, &quot;lo&quot;);<br>
- =A0 =A0 =A0 return rv;<br>
-#else<br>
- =A0 =A0 =A0 /* GCC &gt; 4.3 do it the easy way. =A0*/<br>
- =A0 =A0 =A0 unsigned int __attribute__((mode(TI))) t;<br>
- =A0 =A0 =A0 t =3D read_c0_cvmcount();<br>
- =A0 =A0 =A0 t =3D t * clocksource_mips.mult;<br>
- =A0 =A0 =A0 return (unsigned long long)(t &gt;&gt; clocksource_mips.shift=
);<br>
-#endif<br>
+ =A0 =A0 =A0 return mips_cyc2ns(cyc, clocksource_mips.mult, clocksource_mi=
ps.shift);<br>
=A0}<br>
<br>
=A0void __init plat_time_init(void)<br>
<font color=3D"#888888">--<br>
1.7.0.1<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>MSN+Gtalk: <a hr=
ef=3D"mailto:wuzhangjin@gmail.com">wuzhangjin@gmail.com</a><br>Blog: <a hre=
f=3D"http://falcon.oss.lzu.edu.cn">http://falcon.oss.lzu.edu.cn</a><br>Tel:=
+86-18710032278<br>


--000e0cd29c9c3610be048c7c97de--
