Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2012 08:46:03 +0200 (CEST)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:40094 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6872823Ab2JKGpqcrVtK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2012 08:45:46 +0200
Received: by mail-vc0-f177.google.com with SMTP id p16so1818397vcq.36
        for <multiple recipients>; Wed, 10 Oct 2012 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W5kPw3iEv4uo/hF7Shlc8pnEGPC44jF8HLbC7D3OV4I=;
        b=BY3Z8KQ6kvFJz7o30kAmJUXIBX7B8VFLD5tEUTljKnw9IEuNpMboXNPpLpd9BLAMP0
         a2ks5s0oIzDdMF8yxcjWa3bhHvoP4t41g8+NRZTbmozCfO+gmFqvj3uFLx5W2QEou42C
         dmvDGkdtdZ3hD2LXkD2n30biJaWlTuMaJlrILtmGqGg6sb9wgtDSOXVE8EcNcDOix8em
         iQg+EowTC6AT6/2rLDSGzl9UHBHQ9G8vB4FFvzPRN4BmsOYpkbPStDyyf0clRM+VErwv
         t7ozorhHsYnloGsFsW+arFbwraOs/8QWfp4+Au7hnu/kGBBopreXP3I7yisL//TuG6NW
         /vsA==
MIME-Version: 1.0
Received: by 10.220.228.131 with SMTP id je3mr15350455vcb.73.1349937940201;
 Wed, 10 Oct 2012 23:45:40 -0700 (PDT)
Received: by 10.58.1.201 with HTTP; Wed, 10 Oct 2012 23:45:40 -0700 (PDT)
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146A3B97@exchdb03.mips.com>
References: <1349821203-23083-1-git-send-email-sjhill@mips.com>
        <20121010073826.GB6740@linux-mips.org>
        <CAJMXqXYQC6L3iS92p9R7FuQkuwJWN7SEZy2+E_v-0UKTp7SaSw@mail.gmail.com>
        <31E06A9FC96CEC488B43B19E2957C1B801146A3B97@exchdb03.mips.com>
Date:   Thu, 11 Oct 2012 12:15:40 +0530
Message-ID: <CAJMXqXaAKOdz3yxz1qJ1Xbd581bD1w3pZpb+qy_1zj9B_ahV9w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: kspd: Remove kspd support.
From:   Suprasad Mutalik Desai <suprasad.desai@gmail.com>
To:     "Hill, Steven" <sjhill@mips.com>
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Dearman, Chris" <chris@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/alternative; boundary=14dae9ccd5a265025f04cbc2eb0a
X-archive-position: 34682
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

--14dae9ccd5a265025f04cbc2eb0a
Content-Type: text/plain; charset=ISO-8859-1

Hi Steven,

      We are not using KSPD and we are more concerned about RTLX framework
which was provided by CONFIG_MIPS_VPE_APSP_API .

Thanks and Regards,
Suprasad.

On Wed, Oct 10, 2012 at 8:06 PM, Hill, Steven <sjhill@mips.com> wrote:

> Hello Suprasad.
>
> Certainly the AP/SP API can be left in. We wish to remove the kspd
> support. Do you or anyone on your team use kspd? Thanks.
>
> -Steve

--14dae9ccd5a265025f04cbc2eb0a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi Steven,</div><div>=A0=A0=A0=A0 </div><div>=A0=A0=A0=A0=A0 We are no=
t using KSPD and we are more concerned about RTLX framework which was provi=
ded by CONFIG_MIPS_VPE_APSP_API .</div><div>=A0</div><div>Thanks and Regard=
s,</div><div>Suprasad.<br>
<br></div><div class=3D"gmail_quote">On Wed, Oct 10, 2012 at 8:06 PM, Hill,=
 Steven <span dir=3D"ltr">&lt;<a href=3D"mailto:sjhill@mips.com" target=3D"=
_blank">sjhill@mips.com</a>&gt;</span> wrote:<br><blockquote style=3D"margi=
n:0px 0px 0px 0.8ex;padding-left:1ex;border-left-color:rgb(204,204,204);bor=
der-left-width:1px;border-left-style:solid" class=3D"gmail_quote">
Hello Suprasad.<br>
<br>
Certainly the AP/SP API can be left in. We wish to remove the kspd support.=
 Do you or anyone on your team use kspd? Thanks.<br>
<br>
-Steve</blockquote></div><br>

--14dae9ccd5a265025f04cbc2eb0a--
