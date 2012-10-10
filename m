Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 11:06:42 +0200 (CEST)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61241 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab2JJJG3K3hyc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 11:06:29 +0200
Received: by mail-vc0-f177.google.com with SMTP id p16so458820vcq.36
        for <multiple recipients>; Wed, 10 Oct 2012 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Nq5A9keX9USU5YiYXCHM5lPpjnr1AKZY0pdh2/R6iB0=;
        b=i8BTx2mBoAgh2HI19QlfdzFdY7wC4ivvvvEAg5Yztoamx6YeI+/dM6FM898Cdgd9AJ
         T/BdFqJt/IATDdXzO1AAE8GyPuyJJ9vMAm6a3huD1K8w4Un+j/rd+vvHs4OQmyxAneFk
         9SNx/w8FvdER+trspjYmqDDvxa8fjaFwggJpk4QPTTQtC35llDiYUTMnGSSt+nbs0r/M
         UWJoW/R/5MJzMbMD6huIW2vEqc/ejf/9c2EaaC+Rd3dQZm/SXAsk9hWe0eSwSpjFE4dD
         iHJHdxz0AYKV4QqIrnSfYxE5gTQWLlazj0cnAKLWqSe3Q+Z1IWn6/Y39sWME8Gb7A9eG
         tBuA==
MIME-Version: 1.0
Received: by 10.52.179.231 with SMTP id dj7mr3637641vdc.108.1349859982766;
 Wed, 10 Oct 2012 02:06:22 -0700 (PDT)
Received: by 10.58.1.201 with HTTP; Wed, 10 Oct 2012 02:06:22 -0700 (PDT)
In-Reply-To: <20121010073826.GB6740@linux-mips.org>
References: <1349821203-23083-1-git-send-email-sjhill@mips.com>
        <20121010073826.GB6740@linux-mips.org>
Date:   Wed, 10 Oct 2012 14:36:22 +0530
Message-ID: <CAJMXqXYQC6L3iS92p9R7FuQkuwJWN7SEZy2+E_v-0UKTp7SaSw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: kspd: Remove kspd support.
From:   Suprasad Mutalik Desai <suprasad.desai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        Chris Dearman <chris@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/alternative; boundary=bcaec5014c71c4f1fa04cbb0c4c9
X-archive-position: 34669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: suprasad.desai@gmail.com
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

--bcaec5014c71c4f1fa04cbb0c4c9
Content-Type: text/plain; charset=ISO-8859-1

Hi Ralf,

 AFAIK, the "CONFIG_MIPS_VPE_APSP_API" was used to get the console dump of
the SP program running on the VPE1 (usually a bare-iron program compiled
with MIPS provided toolchain) . This option was useful on the MALTA
platform during the initial evaluation of the APRP or APSP mode.

Now if this support is removed then is there any alternative provided by
MIPS ?.

Thanks and Regards,
Suprasad.

On Wed, Oct 10, 2012 at 1:08 PM, Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Oct 09, 2012 at 05:20:03PM -0500, Steven J. Hill wrote:
>
> > From: "Steven J. Hill" <sjhill@mips.com>
> >
> > There are no users of the kspd functionality anymore.
>
> Thanks.  I've already applied a probably identical patch.
>
> With kspd gone, the question is if there is still any point in keeping
> CONFIG_MIPS_VPE_APSP_API and MIPS_VPE_LOADER?  I've nuked those also but
> I'm holding back for others to get a fair chance to speak up against.
> But the fuse is now lit.
>
>   Ralf
>
>

--bcaec5014c71c4f1fa04cbb0c4c9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi Ralf,</p><p>=A0AFAIK, the &quot;CONFIG_MIPS_VPE_APSP_API&quot; was us=
ed to get the console dump of the SP program running on the VPE1 (usually a=
 bare-iron program compiled with MIPS provided toolchain) . This option was=
 useful on the MALTA platform during the initial evaluation of the APRP or =
APSP mode. </p>
<p>Now if this support is removed then is there any alternative provided by=
 MIPS ?.</p><p>Thanks and Regards,<br>Suprasad.<br><br></p><div class=3D"gm=
ail_quote">On Wed, Oct 10, 2012 at 1:08 PM, Ralf Baechle <span dir=3D"ltr">=
&lt;<a href=3D"mailto:ralf@linux-mips.org" target=3D"_blank">ralf@linux-mip=
s.org</a>&gt;</span> wrote:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;padding-left:1ex;border-left-=
color:rgb(204,204,204);border-left-width:1px;border-left-style:solid" class=
=3D"gmail_quote"><div class=3D"im">On Tue, Oct 09, 2012 at 05:20:03PM -0500=
, Steven J. Hill wrote:<br>

<br>
&gt; From: &quot;Steven J. Hill&quot; &lt;<a href=3D"mailto:sjhill@mips.com=
">sjhill@mips.com</a>&gt;<br>
&gt;<br>
&gt; There are no users of the kspd functionality anymore.<br>
<br>
</div>Thanks. =A0I&#39;ve already applied a probably identical patch.<br>
<br>
With kspd gone, the question is if there is still any point in keeping<br>
CONFIG_MIPS_VPE_APSP_API and MIPS_VPE_LOADER? =A0I&#39;ve nuked those also =
but<br>
I&#39;m holding back for others to get a fair chance to speak up against.<b=
r>
But the fuse is now lit.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=A0 Ralf<br>
<br>
</font></span></blockquote></div><br>

--bcaec5014c71c4f1fa04cbb0c4c9--
