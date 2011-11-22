Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 10:17:54 +0100 (CET)
Received: from mail-pz0-f45.google.com ([209.85.210.45]:35599 "EHLO
        mail-pz0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903706Ab1KVJRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 10:17:45 +0100
Received: by pzd13 with SMTP id 13so14475580pzd.4
        for <multiple recipients>; Tue, 22 Nov 2011 01:17:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.0.193 with SMTP id 1mr43735196pbg.110.1321953458674; Tue,
 22 Nov 2011 01:17:38 -0800 (PST)
Received: by 10.143.37.5 with HTTP; Tue, 22 Nov 2011 01:17:38 -0800 (PST)
In-Reply-To: <4EC55B4A.7050001@qca.qualcomm.com>
References: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org>
        <4EC29534.7010502@adurom.com>
        <CADPsn1YDOu9Xyu1yDfs5Z0LjGzBL-Rx6Fk35AT8n-8oOPhPzHA@mail.gmail.com>
        <4EC55B4A.7050001@qca.qualcomm.com>
Date:   Tue, 22 Nov 2011 09:17:38 +0000
Message-ID: <CADPsn1aSL6eWnKHp3y3O6ibNhQ7PePJh9Lw4-oo_TeHy-xx9FQ@mail.gmail.com>
Subject: Re: [PATCH] ath9k: rename ath9k_platform.h to ath_platform.h
From:   Sangwook Lee <sangwook.lee@linaro.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     mcgrof@frijolero.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        ath9k-devel@lists.ath9k.org, ralf@linux-mips.org,
        juhosg@openwrt.org, rodrigue@qca.qualcomm.com,
        linville@tuxdriver.com, rmanohar@qca.qualcomm.com,
        patches@linaro.org
Content-Type: multipart/alternative; boundary=bcaec5314b61505cd504b24f46b5
X-archive-position: 31918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sangwook.lee@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18346

--bcaec5314b61505cd504b24f46b5
Content-Type: text/plain; charset=ISO-8859-1

Hi Kalle

On 17 November 2011 19:06, Kalle Valo <kvalo@qca.qualcomm.com> wrote:

> Hi Sangwook,
>
> On 11/16/2011 01:34 PM, Sangwook Lee wrote:
>
> >
> > On 15 November 2011 16:37, Kalle Valo <kvalo@adurom.com
> > <mailto:kvalo@adurom.com>> wrote:
> >
> >     Hi Sangwook,
> >
> >     On 11/15/2011 01:23 PM, Sangwook Lee wrote:
> >     > The patch series proposes to rename ath9k_platform.h to
> >     "ath_platform.h
> >     > This header file handles platform data used only for ath9k,
> >     > but it can used by ath6k as well. We can take "wl12xx.h" as
> >     > as a example. Please let us change this file name so that
> >     > other Atheors WLANs use this file for their own platform data
> >
> >     ath9k and ath6kl are very different devices, I'm not sure if sharing
> a
> >     platfrom struct between the two is really a good idea. Most likely
> there
> >     is very little the two drivers can share. What are your plans here?
> >
> >
> >
> > As you know, if ath6kl is not SDIO powered (in most of cases, including
> > mine)
> > we need to use platform struct in order to control reset/power line,
> > because ath6k is designed for mobile and embedded devices.
>
> We have been actually planning to do the same, but it's still on our
> todo list. If you can do this it would be awesome.
>

I did it but because my hw2.0 AR6003 has another problem, I couldn't go
further.
Simply I copied the same method from wl12xx wlan driver.
(Maybe you might have know it)

You can run "grep" the following definition, which is used by Panda board.
CONFIG_WL12XX_PLATFORM_DATA

It will increase small bits in WLAN driver but discard platform data from
init section  at booting time.


Also we need to provide some clock configuration from the board file and
> I'm sure there will be more in the future. But let's start with the
> power control.
>
> > so I found out that there is already header file for ath9k's platform
> > struct. How about using the one header file instead of
> > "include/linux/ath9k_platform.h"
> > , and "include/linux/ath6k_platform.h" ?
> >
> >
> >     I myself was thinking that we would have include/linux/ath6kl.h
> >     dedicated just for ath6kl. That would makes things simpler.
> >
> > But since I don't know much about ath9k, if you want to make the
> > separate header file for ath6kl's own struct, It would be fine as well.
>
> Yeah, I really would like to use separate file for ath6kl.
>
> Kalle
>

--bcaec5314b61505cd504b24f46b5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Kalle<br><br><div class=3D"gmail_quote">On 17 November 2011 19:06, Kalle=
 Valo <span dir=3D"ltr">&lt;<a href=3D"mailto:kvalo@qca.qualcomm.com">kvalo=
@qca.qualcomm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Hi Sangwook,<br>
<div class=3D"im"><br>
On 11/16/2011 01:34 PM, Sangwook Lee wrote:<br>
<br>
&gt;<br>
&gt; On 15 November 2011 16:37, Kalle Valo &lt;<a href=3D"mailto:kvalo@adur=
om.com">kvalo@adurom.com</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:kvalo@adurom.com"=
>kvalo@adurom.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 Hi Sangwook,<br>
&gt;<br>
&gt; =A0 =A0 On 11/15/2011 01:23 PM, Sangwook Lee wrote:<br>
&gt; =A0 =A0 &gt; The patch series proposes to rename ath9k_platform.h to<b=
r>
&gt; =A0 =A0 &quot;ath_platform.h<br>
&gt; =A0 =A0 &gt; This header file handles platform data used only for ath9=
k,<br>
&gt; =A0 =A0 &gt; but it can used by ath6k as well. We can take &quot;wl12x=
x.h&quot; as<br>
&gt; =A0 =A0 &gt; as a example. Please let us change this file name so that=
<br>
&gt; =A0 =A0 &gt; other Atheors WLANs use this file for their own platform =
data<br>
&gt;<br>
&gt; =A0 =A0 ath9k and ath6kl are very different devices, I&#39;m not sure =
if sharing a<br>
&gt; =A0 =A0 platfrom struct between the two is really a good idea. Most li=
kely there<br>
&gt; =A0 =A0 is very little the two drivers can share. What are your plans =
here?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; As you know, if ath6kl is not SDIO powered (in most of cases, includin=
g<br>
&gt; mine)<br>
&gt; we need to use platform struct in order to control reset/power line,<b=
r>
&gt; because ath6k is designed for mobile and embedded devices.<br>
<br>
</div>We have been actually planning to do the same, but it&#39;s still on =
our<br>
todo list. If you can do this it would be awesome.<br></blockquote><div><br=
>I did it but because my hw2.0 AR6003 has another problem, I couldn&#39;t g=
o further.<br>Simply I copied the same method from wl12xx wlan driver.<br>
(Maybe you might have know it)<br><br>You can run &quot;grep&quot; the foll=
owing definition, which is used by Panda board.<br>CONFIG_WL12XX_PLATFORM_D=
ATA<br><br>It will increase small bits in WLAN driver but discard platform =
data from init section=A0 at booting time.=A0 <br>
</div><div>=A0<br><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-l=
eft: 1ex;">
Also we need to provide some clock configuration from the board file and<br=
>
I&#39;m sure there will be more in the future. But let&#39;s start with the=
<br>
power control.<br>
<div class=3D"im"><br>
&gt; so I found out that there is already header file for ath9k&#39;s platf=
orm<br>
&gt; struct. How about using the one header file instead of<br>
&gt; &quot;include/linux/ath9k_platform.h&quot;<br>
&gt; , and &quot;include/linux/ath6k_platform.h&quot; ?<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 I myself was thinking that we would have include/linux/ath6kl.=
h<br>
&gt; =A0 =A0 dedicated just for ath6kl. That would makes things simpler.<br=
>
&gt;<br>
&gt; But since I don&#39;t know much about ath9k, if you want to make the<b=
r>
&gt; separate header file for ath6kl&#39;s own struct, It would be fine as =
well.<br>
<br>
</div>Yeah, I really would like to use separate file for ath6kl.<br>
<font color=3D"#888888"><br>
Kalle<br>
</font></blockquote></div><br>

--bcaec5314b61505cd504b24f46b5--
