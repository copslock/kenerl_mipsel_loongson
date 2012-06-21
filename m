Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2012 11:11:37 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:42688 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903612Ab2FUJLa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2012 11:11:30 +0200
Received: by ghbf11 with SMTP id f11so282917ghb.36
        for <multiple recipients>; Thu, 21 Jun 2012 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+XOWrqOBsSEqmAhSlNiFbtdhZquoKKzDhdtk+f/B918=;
        b=xHQZbCDsBn7+qTPhn1oIc0kG4PddVNW9dz4ALjMXYOd4iIJuLeiUTqH4b4JKgYRZ/s
         93yxzfFGgMRxX/0zsTi0ORtLc0rzRpUDkCj4gXm0t/0yec8xtztw1YpwP4O53PBoOk8O
         r9BuEB1Jc0zQPMxBX1waJW38vawB156ANsDEmRwhiGYDKbyLeq7EDmRfry+FK2V8sj5K
         VxOk8pRkx5uzrBltBwjLMv6ll/O/4TCAP3RL/5fmnWiFuWAQMkRVLd8Pe/vf7bEvMJ61
         iV3lEw9xm1f1Kr+qMAf4Xn4RQ3PdCE8rhtStsnQ4EblfaExIvnCrGT06BhJKMqiH5V92
         KQcA==
Received: by 10.50.216.234 with SMTP id ot10mr6786084igc.51.1340269884395;
 Thu, 21 Jun 2012 02:11:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.42.197 with HTTP; Thu, 21 Jun 2012 02:11:04 -0700 (PDT)
In-Reply-To: <5405989.s3J3Yyxttn@flexo>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
 <20120620192551.GC29446@linux-mips.org> <CAJhJPsV2D3xVbA93OpaB8mN6Vs64EmWjxhCbpCMBA5r+wx8mnQ@mail.gmail.com>
 <5405989.s3J3Yyxttn@flexo>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 21 Jun 2012 17:11:04 +0800
Message-ID: <CAJhJPsVaK4dRbxhB_3QKhrgF3=tYXWwOcppH9V=a871UMRxRew@mail.gmail.com>
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        wuzhangjin@gmail.com, zhzhl555@gmail.com
Content-Type: multipart/alternative; boundary=f46d040167a95ccf5e04c2f7e6c3
X-archive-position: 33753
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

--f46d040167a95ccf5e04c2f7e6c3
Content-Type: text/plain; charset=ISO-8859-1

2012/6/21 Florian Fainelli <florian@openwrt.org>

> On Thursday 21 June 2012 15:34:54 Kelvin Cheung wrote:
> > 2012/6/21 Ralf Baechle <ralf@linux-mips.org>
> [snip]
> > >
> > > And the final plug - take a look at FDT for a future revision of this
> > > code :)
> > >
> > >
> > Yes, I am aware that the FDT is the final target.
> > But PMON which is the bootloader of Loongson CPU does not support FDT at
> > present.
> > I will remember this.
>
> Your bootloader does not need to support FDT, as long as you can provide a
> FDT
> by other means, such as appending a FDT at the end of your kernel.
>

But how can I verify these code without support of bootloader?


> --
> Florian
>



-- 
Best Regards!
Kelvin

--f46d040167a95ccf5e04c2f7e6c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/21 Florian Fainelli <span dir=3D"=
ltr">&lt;<a href=3D"mailto:florian@openwrt.org" target=3D"_blank">florian@o=
penwrt.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

On Thursday 21 June 2012 15:34:54 Kelvin Cheung wrote:<br>
&gt; 2012/6/21 Ralf Baechle &lt;<a href=3D"mailto:ralf@linux-mips.org">ralf=
@linux-mips.org</a>&gt;<br>
[snip]<br>
<div class=3D"im">&gt; &gt;<br>
&gt; &gt; And the final plug - take a look at FDT for a future revision of =
this<br>
&gt; &gt; code :)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Yes, I am aware that the FDT is the final target.<br>
&gt; But PMON which is the bootloader of Loongson CPU does not support FDT =
at<br>
&gt; present.<br>
&gt; I will remember this.<br>
<br>
</div>Your bootloader does not need to support FDT, as long as you can prov=
ide a FDT<br>
by other means, such as appending a FDT at the end of your kernel.<br></blo=
ckquote><div><br>But how can I verify these code without support of bootloa=
der?<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt =
0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">


--<br>
Florian<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Best Regards!<br>Kelvin=
<br><br><img src=3D"http://ubuntucounter.geekosophical.net/img/ubuntu-blogg=
er.php?user=3D26540"><br><br>

--f46d040167a95ccf5e04c2f7e6c3--
