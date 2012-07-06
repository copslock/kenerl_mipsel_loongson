Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2012 12:26:29 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:52884 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903548Ab2GFK0Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jul 2012 12:26:25 +0200
Received: by wibhq4 with SMTP id hq4so515363wib.6
        for <linux-mips@linux-mips.org>; Fri, 06 Jul 2012 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Q46MwWBCkV2SJzJzwn5Eenfn+2DZYEMz54e9nl3KusE=;
        b=pw+BZe+gMhud2yGJcGbMkgccNJ5TP85yxyWsC/Yz51VtvBN5i56xt234FI8I3h1AUT
         CjC19kSerspnxth99bjHFKE7r5fd10p4W5URI1Nv/JDpIFS3xvP89H9LpNU2Hx7DBJaX
         uLZhwUoB3oDzJvs6V1Jo5uhcmgtGRE/t8FZxS455wNwq2CC2sJGmg2K7w4HK8SEukkfO
         6lgSTVpwVPss6XOg6luu0QZBVxEUbnzfcuXBtWbBJgX+ikq9L6GiuytpcwGuAm7UqkVd
         R8yWMzT+Q8gmQcswlNsAwzdtahUnc2esWvbQCgyhDcXHM8irItL9POec2mvbzvJAVJme
         ZAgw==
MIME-Version: 1.0
Received: by 10.216.80.212 with SMTP id k62mr7592044wee.18.1341570380074; Fri,
 06 Jul 2012 03:26:20 -0700 (PDT)
Received: by 10.194.60.20 with HTTP; Fri, 6 Jul 2012 03:26:20 -0700 (PDT)
Date:   Fri, 6 Jul 2012 15:56:20 +0530
Message-ID: <CAJMXqXapmxX+N7_FC5Lj_Rb9b93i3UjQ2R11pK4toTMSn47cYA@mail.gmail.com>
Subject: Bypass "find_busiest_queue" in VSMP (SMVP) mode
From:   Suprasad Mutalik Desai <suprasad.desai@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00504502d296f20cf404c426b1a2
X-archive-position: 33878
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

--00504502d296f20cf404c426b1a2
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

Currently i am running SMVP mode (2 VPEs each having one TC) on MIPS 34Kc
.

W.r.t load balancing logic,
load_balance --> find_busiest_group (find the busiest group in the domain)
--> find_busiest_queue (find the busiest runqueue among the cpus in group)

In SMVP mode, each VPE is referred as groups and these VPEs (groups) have
*ONLY* one TC (CPU) so do we still need to run "find_busiest_queue" to get
the busiest runqueue among the cpus of a particular group .

Instead of "find_busiest_queue" , can we use below code in
"linux-2.6.32.42/kernel/sched.c" ,

+#ifdef CONFIG_MIPS_MT_SMP
+       cpu = cpumask_first(sched_group_cpus(group))  / * get the first CPU
in the busiest group */
+       busiest = cpu_rq (cpu)                        /* assign the
runqueue of the cpu to busiest */
+#else
        busiest = find_busiest_queue(group, idle, imbalance, cpus);
+#endif

Please let me know your views .

Thanks and Regards,
Suprasad.

--00504502d296f20cf404c426b1a2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<br><br>Currently i am running SMVP mode (2 VPEs each having one TC)=
 on MIPS 34Kc .=A0 <br><br>W.r.t load balancing logic,<br>load_balance --&g=
t; find_busiest_group (find the busiest group in the domain) --&gt; find_bu=
siest_queue (find the busiest runqueue among the cpus in group)<br>
<br>In SMVP mode, each VPE is referred as groups and these VPEs (groups) ha=
ve *ONLY* one TC (CPU) so do we still need to run &quot;find_busiest_queue&=
quot; to get the busiest runqueue among the cpus of a particular group . <b=
r>
<br>Instead of &quot;find_busiest_queue&quot; , can we use below code in &q=
uot;linux-2.6.32.42/kernel/sched.c&quot; ,<br><br>+#ifdef CONFIG_MIPS_MT_SM=
P<br>+=A0=A0=A0=A0=A0=A0 cpu =3D cpumask_first(sched_group_cpus(group))=A0 =
/ * get the first CPU in the busiest group */<br>
+=A0=A0=A0=A0=A0=A0 busiest =3D cpu_rq (cpu)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* assign the runqueue of the cpu t=
o busiest */<br>+#else<br>=A0=A0=A0=A0=A0=A0=A0 busiest =3D find_busiest_qu=
eue(group, idle, imbalance, cpus);<br>+#endif<br><br>Please let me know you=
r views .<br>
<br>Thanks and Regards,<br>Suprasad.<br>

--00504502d296f20cf404c426b1a2--
