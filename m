Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 11:08:51 +0200 (CEST)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:60054 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903827Ab2HAJIo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2012 11:08:44 +0200
Received: by vcbfl13 with SMTP id fl13so6810782vcb.36
        for <multiple recipients>; Wed, 01 Aug 2012 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Bj60G/UZlMc2ZsqiubipID2IyLdVrHQ16esi6Z6uk9Y=;
        b=mBZvRyCKjAqF94jMgFwVrwtHtYSJg6u4T0HsJDdcXhwtk7kXiGsf+UgQTf+WDZRLE3
         3zGH8tCKKVgWdu3b+MtHlOxX4HAae2RqzN6yqsX+bOCprsyV1T4a0Q/LMqlyKrIhBkYu
         fqH/ah8QctLqwEFogPCrDNYo/awugZEN8AHdoNn7WeMnnpE5YUBgxTE3vo/hGheBEsq2
         1veJwgd56hs009YByjlXzb977kbQNdVMOBWs47sYhwgKd8KGCGjiBGrkunKA7JtRdDB1
         ZokM9kMZkE6/WrcbN7kKT7/eiHRF1Xqxym/VHqM1haaaKIav1D1c5ooZowbIaG0XIj0f
         VP8w==
Received: by 10.52.22.50 with SMTP id a18mr14412827vdf.60.1343812117555; Wed,
 01 Aug 2012 02:08:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.204.200 with HTTP; Wed, 1 Aug 2012 02:08:17 -0700 (PDT)
In-Reply-To: <20120801154216.294110ab8af9f733752e85f3@linux-mips.org>
References: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org> <20120801154216.294110ab8af9f733752e85f3@linux-mips.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Wed, 1 Aug 2012 17:08:17 +0800
Message-ID: <CAJhJPsULK+K2S=i1F8X9QY86sU4L2E=Q1CaJjYQAV2PzkMF63w@mail.gmail.com>
Subject: Re: [PATCH 4/4] MIPS: loongson1: more clk support and add select HAVE_CLK
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=bcaec5015e77e969b404c630a3a8
X-archive-position: 34012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

--bcaec5015e77e969b404c630a3a8
Content-Type: text/plain; charset=ISO-8859-1

Hi Yoichi,

Thanks for fixing this problem.
I kind of regretted that I did not follow Ralf's advice.

Now, I'm tring to use common clock framework in drivers/clk.

2012/8/1 Yoichi Yuasa <yuasa@linux-mips.org>

> fix redefinition of clk_*
>
> arch/mips/loongson1/common/clock.c:23:13: error: redefinition of 'clk_get'
> include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
> arch/mips/loongson1/common/clock.c:41:15: error: redefinition of
> 'clk_get_rate'
> include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate'
> was here
> make[3]: *** [arch/mips/loongson1/common/clock.o] Error 1
>
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/loongson1/Kconfig        |    1 +
>  arch/mips/loongson1/common/clock.c |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
> index 237fa21..a9a14d6 100644
> --- a/arch/mips/loongson1/Kconfig
> +++ b/arch/mips/loongson1/Kconfig
> @@ -15,6 +15,7 @@ config LOONGSON1_LS1B
>         select SYS_SUPPORTS_LITTLE_ENDIAN
>         select SYS_SUPPORTS_HIGHMEM
>         select SYS_HAS_EARLY_PRINTK
> +       select HAVE_CLK
>
>  endchoice
>
> diff --git a/arch/mips/loongson1/common/clock.c
> b/arch/mips/loongson1/common/clock.c
> index 2d98fb0..1bbbbec 100644
> --- a/arch/mips/loongson1/common/clock.c
> +++ b/arch/mips/loongson1/common/clock.c
> @@ -38,12 +38,28 @@ struct clk *clk_get(struct device *dev, const char
> *name)
>  }
>  EXPORT_SYMBOL(clk_get);
>
> +int clk_enable(struct clk *clk)
> +{
> +       return 0;
> +}
> +EXPORT_SYMBOL(clk_enable);
> +
> +void clk_disable(struct clk *clk)
> +{
> +}
> +EXPORT_SYMBOL(clk_disable);
> +
>  unsigned long clk_get_rate(struct clk *clk)
>  {
>         return clk->rate;
>  }
>  EXPORT_SYMBOL(clk_get_rate);
>
> +void clk_put(struct clk *clk)
> +{
> +}
> +EXPORT_SYMBOL(clk_put);
> +
>  static void pll_clk_init(struct clk *clk)
>  {
>         u32 pll;
> --
> 1.7.0.4
>
>
>


-- 
Best Regards!
Kelvin

--bcaec5015e77e969b404c630a3a8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Yoichi,<br><br>Thanks for fixing this problem.<br>I kind of regretted th=
at I did not follow Ralf&#39;s advice.<br><br>Now, I&#39;m tring to use com=
mon clock framework in drivers/clk.<br><br><div class=3D"gmail_quote">2012/=
8/1 Yoichi Yuasa <span dir=3D"ltr">&lt;<a href=3D"mailto:yuasa@linux-mips.o=
rg" target=3D"_blank">yuasa@linux-mips.org</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">fix redefinition of clk_*<br>
<br>
arch/mips/loongson1/common/clock.c:23:13: error: redefinition of &#39;clk_g=
et&#39;<br>
include/linux/clk.h:281:27: note: previous definition of &#39;clk_get&#39; =
was here<br>
arch/mips/loongson1/common/clock.c:41:15: error: redefinition of &#39;clk_g=
et_rate&#39;<br>
include/linux/clk.h:302:29: note: previous definition of &#39;clk_get_rate&=
#39; was here<br>
make[3]: *** [arch/mips/loongson1/common/clock.o] Error 1<br>
<br>
Signed-off-by: Yoichi Yuasa &lt;<a href=3D"mailto:yuasa@linux-mips.org">yua=
sa@linux-mips.org</a>&gt;<br>
---<br>
=A0arch/mips/loongson1/Kconfig =A0 =A0 =A0 =A0| =A0 =A01 +<br>
=A0arch/mips/loongson1/common/clock.c | =A0 16 ++++++++++++++++<br>
=A02 files changed, 17 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig<br>
index 237fa21..a9a14d6 100644<br>
--- a/arch/mips/loongson1/Kconfig<br>
+++ b/arch/mips/loongson1/Kconfig<br>
@@ -15,6 +15,7 @@ config LOONGSON1_LS1B<br>
=A0 =A0 =A0 =A0 select SYS_SUPPORTS_LITTLE_ENDIAN<br>
=A0 =A0 =A0 =A0 select SYS_SUPPORTS_HIGHMEM<br>
=A0 =A0 =A0 =A0 select SYS_HAS_EARLY_PRINTK<br>
+ =A0 =A0 =A0 select HAVE_CLK<br>
<br>
=A0endchoice<br>
<br>
diff --git a/arch/mips/loongson1/common/clock.c b/arch/mips/loongson1/commo=
n/clock.c<br>
index 2d98fb0..1bbbbec 100644<br>
--- a/arch/mips/loongson1/common/clock.c<br>
+++ b/arch/mips/loongson1/common/clock.c<br>
@@ -38,12 +38,28 @@ struct clk *clk_get(struct device *dev, const char *nam=
e)<br>
=A0}<br>
=A0EXPORT_SYMBOL(clk_get);<br>
<br>
+int clk_enable(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+EXPORT_SYMBOL(clk_enable);<br>
+<br>
+void clk_disable(struct clk *clk)<br>
+{<br>
+}<br>
+EXPORT_SYMBOL(clk_disable);<br>
+<br>
=A0unsigned long clk_get_rate(struct clk *clk)<br>
=A0{<br>
=A0 =A0 =A0 =A0 return clk-&gt;rate;<br>
=A0}<br>
=A0EXPORT_SYMBOL(clk_get_rate);<br>
<br>
+void clk_put(struct clk *clk)<br>
+{<br>
+}<br>
+EXPORT_SYMBOL(clk_put);<br>
+<br>
=A0static void pll_clk_init(struct clk *clk)<br>
=A0{<br>
=A0 =A0 =A0 =A0 u32 pll;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.0.4<br>
<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Best Rega=
rds!<br>Kelvin<br><br><img src=3D"http://ubuntucounter.geekosophical.net/im=
g/ubuntu-blogger.php?user=3D26540"><br><br>

--bcaec5015e77e969b404c630a3a8--
