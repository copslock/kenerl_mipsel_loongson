Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2012 17:28:54 +0200 (CEST)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:41055 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903463Ab2G3P2u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2012 17:28:50 +0200
Received: by qcsu28 with SMTP id u28so2954986qcs.36
        for <linux-mips@linux-mips.org>; Mon, 30 Jul 2012 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GbUDvh5aLbwIDZ0bhuOyK8WXMUuX+NyjrTTgAYgyXFw=;
        b=ZCqhF3UA4RQ3CsDRccrgZuc1DihldYWSrPEG84lxxfUe0i4i1ER6HPiGVcMIhJmWes
         5pnxidXZ1+5YN+Ex1GvQ82O72jNWk8FZWS8yMa+jzTM4sr3jMZ8NgOLiieQ7im5phc49
         MNpccU0RCynw8Qzs1kTw+yH0fY+4O14ky20AtIJPICQgbN5hyS2V22c2nzoXinhW2yJi
         qvT6zcY6/yxNLHEOM4bCqYEGhAAvCDnS4aTrLBnC0QA5YjPwHu2jMnuqlH4kXbvE/j7C
         EgDkk4oWWG/6dc5dIJuVAuxBOIEDRThf4hhmzVsbnlk1GsppISPY6yW82tpmE8Kj7h/P
         G2Gg==
Received: by 10.50.89.130 with SMTP id bo2mr8693578igb.19.1343662124173; Mon,
 30 Jul 2012 08:28:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.17.197 with HTTP; Mon, 30 Jul 2012 08:28:23 -0700 (PDT)
In-Reply-To: <50169FA7.8010603@realitydiluted.com>
References: <34219711.post@talk.nabble.com> <5012CDA4.5000008@realitydiluted.com>
 <34230427.post@talk.nabble.com> <50169FA7.8010603@realitydiluted.com>
From:   Jeffin <jeffinmammen@gmail.com>
Date:   Mon, 30 Jul 2012 20:58:23 +0530
Message-ID: <CAB4dzwWWCizOmQ=kGxCz1f6smjdMVXbUJ9+35EUckygEoG_ebQ@mail.gmail.com>
Subject: Re: SMVP Support on MIPS34KC (linux-2.6.35)
To:     "Steven J. Hill" <sjhill@realitydiluted.com>
Cc:     JoeJ <tttechmail@gmail.com>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=e89a8f2351ab9c080b04c60db72e
X-archive-position: 33999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeffinmammen@gmail.com
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

--e89a8f2351ab9c080b04c60db72e
Content-Type: text/plain; charset=ISO-8859-1

Hi Steve,

    CONFIG_CSRC_R4K is defined . However,  I have not
enabled CONFIG_CSRC_GIC and gic_present is initialized to 'zero' . I am a
bit confused about CONFIG_SRC_GIC macros. I am not sure if GIC is an
external timer outside the mips 34Kc core (specific to malta reference
board)? In that case, we might have to replace to GIC source code with our
own General purpose timer code. Can you please confirm if i am missing
something here? It will be verfy helpful if you can explain a bit about the
significance of CSRC_R4K & CSRC_GIC macros definitions in SMVP model.

 We have been stuck with this issue for quiet sometime and looking for ways
to resolve this at the best possible way. Your suggestions are really
helpful in this regard.

Regards,
Jeffin



On Mon, Jul 30, 2012 at 8:22 PM, Steven J. Hill
<sjhill@realitydiluted.com>wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 07/30/2012 08:20 AM, JoeJ wrote:
> >
> > Synchronize counters across 2 CPUs: done. NET: Registered protocol family
> > 16 bio: create slab <bio-0> at 0 Switching to clocksource MIPS
> >
> >
> > As mentioned in my previous post, even with 3.4.2 kernel, the control
> > loops in stop_machine_cpu_stop function. Do you suspect anything here?
> btw,
> > if we set "clocksource=jiffies" in the bootargs, the system boot goes
> fine.
> > The issue is observed only during switching from default clocksource to
> > MIPS clocksource. Also, the boot works fine with 'nosmp=1' option & MIPS
> > clocksource.
> >
> Make user that you select both CONFIG_CSRC_R4K ad CONFIG_CSRC_GIC for your
> clock sources. The GIC counter will be used from synchronization across the
> CPUs. Secondly, the hang is not actually a hard hang. Wait 50 seconds and I
> bet you will see the boot complete.
>
> - -Steve
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAlAWn6cACgkQgyK5H2Ic36f47wCbBM7J8Bl0iEyELwxx2sYHBRxZ
> SukAniQlkEwYyNdolwPhi1vOJgxNrba+
> =NW6E
> -----END PGP SIGNATURE-----
>

--e89a8f2351ab9c080b04c60db72e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Steve,<div><br><div>=A0 =A0
CONFIG_CSRC_R4K=A0is defined . However,=A0=A0I have not enabled=A0CONFIG_CS=
RC_GIC and gic_present is initialized to &#39;zero&#39;=A0. I am a bit conf=
used about CONFIG_SRC_GIC macros. I am not sure if GIC is an external timer=
 outside the mips 34Kc core (specific to malta reference board)? In that ca=
se, we might have to replace to GIC source code with our own General purpos=
e timer code. Can you please confirm if i am missing something here? It wil=
l be verfy helpful if you can explain a bit about the significance of CSRC_=
R4K &amp; CSRC_GIC macros definitions in SMVP model.</div>

<div><br></div><div>=A0We have been stuck with this issue for quiet sometim=
e and looking for ways to resolve this at the best possible way. Your sugge=
stions are really helpful in this regard.=A0</div><div><br></div><div>Regar=
ds,</div>

<div>Jeffin</div><div><br></div><div><br><br><div class=3D"gmail_quote">On =
Mon, Jul 30, 2012 at 8:22 PM, Steven J. Hill <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sjhill@realitydiluted.com" target=3D"_blank">sjhill@realitydilut=
ed.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">-----BEGIN PGP SIGNED MESS=
AGE-----<br>
Hash: SHA1<br>
<br>
</div>On 07/30/2012 08:20 AM, JoeJ wrote:<br>
&gt;<br>
&gt; Synchronize counters across 2 CPUs: done. NET: Registered protocol fam=
ily<br>
&gt; 16 bio: create slab &lt;bio-0&gt; at 0 Switching to clocksource MIPS<b=
r>
&gt;<br>
&gt;<br>
&gt; As mentioned in my previous post, even with 3.4.2 kernel, the control<=
br>
&gt; loops in stop_machine_cpu_stop function. Do you suspect anything here?=
 btw,<br>
&gt; if we set &quot;clocksource=3Djiffies&quot; in the bootargs, the syste=
m boot goes fine.<br>
&gt; The issue is observed only during switching from default clocksource t=
o<br>
&gt; MIPS clocksource. Also, the boot works fine with &#39;nosmp=3D1&#39; o=
ption &amp; MIPS<br>
&gt; clocksource.<br>
&gt;<br>
Make user that you select both CONFIG_CSRC_R4K ad CONFIG_CSRC_GIC for your<=
br>
clock sources. The GIC counter will be used from synchronization across the=
<br>
CPUs. Secondly, the hang is not actually a hard hang. Wait 50 seconds and I=
<br>
bet you will see the boot complete.<br>
<br>
- -Steve<br>
<div class=3D"im">-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.11 (GNU/Linux)<br>
Comment: Using GnuPG with Mozilla - <a href=3D"http://enigmail.mozdev.org/"=
 target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
</div>iEYEARECAAYFAlAWn6cACgkQgyK5H2Ic36f47wCbBM7J8Bl0iEyELwxx2sYHBRxZ<br>
SukAniQlkEwYyNdolwPhi1vOJgxNrba+<br>
=3DNW6E<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div></div>

--e89a8f2351ab9c080b04c60db72e--
