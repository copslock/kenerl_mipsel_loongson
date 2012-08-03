Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 00:30:04 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57394 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903712Ab2HCW35 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Aug 2012 00:29:57 +0200
Received: by pbbrq13 with SMTP id rq13so2126777pbb.36
        for <multiple recipients>; Fri, 03 Aug 2012 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=hEa2fdtreexOJGzcnSPEwr5bvMhPe4q6tybK0MLqOZ8=;
        b=TrmAIoXHjWns3jlGA8b1VKkw+j33n7dgcfonzIpBDqWnp6luYNkVIH/D2oDurl/0Dp
         rDXHdQX4DNXVkUaL77IkNs0L7RWa6+3jqxyL9vyKfnyERWW9MfYuCIEbbvhL8g+WqkHq
         Shr49Rms7qqGlmBJ3ZlVJHZ0KNbJ3Szs8MuVVI5mmW/jmSb2tlW1yMXxeZkuvGkkmKWc
         uh3ScHmXQGKfuzwYPSbKkrKyBLvO9dIE9/+YFkYF0G4wbUmQjPZQ/A7WBQcRiOmM/6ms
         gdv+RAk7z0VT2Z1rj46C4MsXtJ48ChhBncMHhzljDsUeZUCj1Scpn44ON7mkfovijJUU
         O7NA==
MIME-Version: 1.0
Received: by 10.68.238.68 with SMTP id vi4mr796986pbc.123.1344032990725; Fri,
 03 Aug 2012 15:29:50 -0700 (PDT)
Received: by 10.67.14.106 with HTTP; Fri, 3 Aug 2012 15:29:50 -0700 (PDT)
Date:   Sat, 4 Aug 2012 03:59:50 +0530
Message-ID: <CADArhcAOaYLVk2MU3aExBNumgKeUTC7WKHKSL3kZ-O82028vAw@mail.gmail.com>
Subject: [Memory leak]: memory leak in apply_r_mips_lo16_rel
From:   Akhilesh Kumar <akhilesh.lxr@gmail.com>
To:     ralf@linux-mips.org
Cc:     paul.gortmaker@windriver.com, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=047d7b339601fa864c04c664102f
X-archive-position: 34052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akhilesh.lxr@gmail.com
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
X-Status: A

--047d7b339601fa864c04c664102f
Content-Type: text/plain; charset=ISO-8859-1

Hi Ralf,

I found some memory leak in
arch/mips/kernel/module.c file

Please review below patch and share your review comments,

Thanks,
Akhilesh


>From 77b8cae374a95000a1fd7e75bcda6694b8180fe9 Mon Sep 17 00:00:00 2001
From: Akhilesh Kumar <akhilesh.lxr@gmail.com>
Date: Sat, 4 Aug 2012 03:34:06 +0530
Subject:  [Memory leak]: memory leak in  apply_r_mips_lo16_rel
 module.c

if (v != l->value)
             goto out_danger ;
out_danger:
  pr_err("module %s: dangerous R_MIPS_LO16 REL relocation\n", me->name);
  return -ENOEXEC;

in case goto_out_danger kfree(l) is missing

Signed-off-by: Akhilesh Kumar <akhilesh.lxr@gmail.com>
---
 arch/mips/kernel/module.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index a5066b1..b1dce44 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -202,7 +202,7 @@ static int apply_r_mips_lo16_rel(struct module *me, u32
*location, Elf_Addr v)

 out_danger:
  pr_err("module %s: dangerous R_MIPS_LO16 REL relocation\n", me->name);
-
+ kfree(l);
  return -ENOEXEC;
 }

-- 
1.7.8.4

--047d7b339601fa864c04c664102f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi Ralf,</div><div><br></div><div>I found some memory leak in <br>arch=
/mips/kernel/module.c file=A0</div><div><br></div><div>Please review below =
patch and share your review comments,</div><div><br></div><div>Thanks,</div=
>
<div>Akhilesh=A0</div><div><br></div><div><br></div><div>From 77b8cae374a95=
000a1fd7e75bcda6694b8180fe9 Mon Sep 17 00:00:00 2001</div><div>From: Akhile=
sh Kumar &lt;<a href=3D"mailto:akhilesh.lxr@gmail.com">akhilesh.lxr@gmail.c=
om</a>&gt;</div>
<div>Date: Sat, 4 Aug 2012 03:34:06 +0530</div><div>Subject: =A0[Memory lea=
k]: memory leak in =A0apply_r_mips_lo16_rel</div><div>=A0module.c</div><div=
><br></div><div>if (v !=3D l-&gt;value)</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0goto out_danger ;</div>
<div>out_danger:</div><div>=A0 pr_err(&quot;module %s: dangerous R_MIPS_LO1=
6 REL relocation\n&quot;, me-&gt;name);</div><div>=A0 return -ENOEXEC;</div=
><div><br></div><div>in case goto_out_danger kfree(l) is missing</div><div>
<br></div><div>Signed-off-by: Akhilesh Kumar &lt;<a href=3D"mailto:akhilesh=
.lxr@gmail.com">akhilesh.lxr@gmail.com</a>&gt;</div><div>---</div><div>=A0a=
rch/mips/kernel/module.c | =A0 =A02 +-</div><div>=A01 files changed, 1 inse=
rtions(+), 1 deletions(-)</div>
<div><br></div><div>diff --git a/arch/mips/kernel/module.c b/arch/mips/kern=
el/module.c</div><div>index a5066b1..b1dce44 100644</div><div>--- a/arch/mi=
ps/kernel/module.c</div><div>+++ b/arch/mips/kernel/module.c</div><div>
@@ -202,7 +202,7 @@ static int apply_r_mips_lo16_rel(struct module *me, u32=
 *location, Elf_Addr v)</div><div>=A0</div><div>=A0out_danger:</div><div>=
=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>pr_err(=
&quot;module %s: dangerous R_MIPS_LO16 REL relocation\n&quot;, me-&gt;name)=
;</div>
<div>-</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>kfree(l);</div><div>=A0<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>return -ENOEXEC;</div><div>=A0}</div><div>=A0</div><di=
v>--=A0</div>
<div>1.7.8.4</div>

--047d7b339601fa864c04c664102f--
