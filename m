Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 12:00:16 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37136 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822680Ab3EWUBuserWR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 22:01:50 +0200
Received: by mail-wi0-f178.google.com with SMTP id hj6so1081246wib.11
        for <multiple recipients>; Thu, 23 May 2013 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pfl+RgwFovOvmniw6pmqbiy0sSBk+5RMvKYd5BPZ0/I=;
        b=a9JA7JrOLkRrPygiq6leE0vyJpZpkC8iMrmuq6VjQAdtwP+qJDUdWNFT/RXNEqK+TO
         bwwuG/eDR18qLW2oFDiDKuZhTfkwwZnzFHEHErVJ4jMYancuzrxZ1cPGCAsMBD3OiFg3
         ExxOEw0zX6G3Wg3usi/KJ3hCfi0iCizr2v51jrygmcavMuNdMW8AawdRE1T7u6euG9/g
         0x2SmtBkO4PlpL8jK5IX8/Kj20nLY55r2Xt6YK4ZnlEQY04DfJrNJRWpAqmHNheDhBSe
         iJ6f/6odOUaFDZERcOQY8F+l4sOJFoEIq3qJ6110SLuAaWOrN6jMvl5GqekKg5bhzKp4
         WkGA==
MIME-Version: 1.0
X-Received: by 10.180.188.141 with SMTP id ga13mr47179517wic.9.1369339114825;
 Thu, 23 May 2013 12:58:34 -0700 (PDT)
Received: by 10.181.13.44 with HTTP; Thu, 23 May 2013 12:58:34 -0700 (PDT)
In-Reply-To: <519E4C3C.7010400@gmail.com>
References: <519DDF8D.70700@gmail.com>
        <519E4C3C.7010400@gmail.com>
Date:   Thu, 23 May 2013 23:58:34 +0400
Message-ID: <CAJGZr0KRAJty5+hY77e8s50NmK5jLq8zNQ_r6fz9LOVpPo_WCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] MIPS: Octeon: fix for held reboot_mutex lock at
 task exit time
From:   Maxim Uvarov <muvarov@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Wladislav Wiebe <wladislav.kw@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, david.daney@cavium.com,
        davem@davemloft.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11c37f5a842e7e04dd681b4b
Return-Path: <muvarov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37193
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@gmail.com
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

--001a11c37f5a842e7e04dd681b4b
Content-Type: text/plain; charset=ISO-8859-1

2013/5/23 David Daney <ddaney.cavm@gmail.com>

> On 05/23/2013 02:21 AM, Wladislav Wiebe wrote:
>
>> When kernel halt's will reboot_mutex lock still hold at exit.
>> It will issue with 'halt' command:
>> $ halt
>> ..
>> Sent SIGKILL to all processes
>> Requesting system halt
>> [66.729373] System halted.
>> [66.733244]
>> [66.734761] ==============================**=======
>> [66.739473] [ BUG: lock held at task exit time! ]
>> [66.744188] 3.8.7-0-sampleversion-fct #49 Tainted: G           O
>> [66.750202] ------------------------------**-------
>> [66.754913] init/21479 is exiting with locks still held!
>> [66.760234] 1 lock held by init/21479:
>> [66.763990]  #0:  (reboot_mutex){+.+...}, at: [<ffffffff801776c8>]
>> SyS_reboot+0xe0/0x218
>> [66.772165]
>> [66.772165] stack backtrace:
>> [66.776532] Call Trace:
>> [66.778992] [<ffffffff805780a8>] dump_stack+0x8/0x34
>> [66.783972] [<ffffffff801618b0>] do_exit+0x610/0xa70
>> [66.788948] [<ffffffff801777a8>] SyS_reboot+0x1c0/0x218
>> [66.794186] [<ffffffff8013d6a4>] handle_sys64+0x44/0x64
>>
>>
>>  [...]
>
>>
>> Acked-by: Maxim Uvarov <muvarov@gmail.com>
>> Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
>> ---
>>   arch/mips/cavium-octeon/setup.**c |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/mips/cavium-octeon/**setup.c b/arch/mips/cavium-octeon/
>> **setup.c
>> index b0baa29..04ce396 100644
>> --- a/arch/mips/cavium-octeon/**setup.c
>> +++ b/arch/mips/cavium-octeon/**setup.c
>> @@ -457,6 +457,10 @@ static void octeon_halt(void)
>>         }
>>
>>         octeon_kill_core(NULL);
>> +
>> +       /* We stop here */
>> +       while (1)
>> +               ;
>>
>
> I want to put a WAIT here so we don't burn so much power.
>
> I will send a patch to do that instead.
>
>
what about adding wait for other mips boards where is while (1) is used?

Maxim.


>    }
>>
>>   /**
>>
>>
>


-- 
Best regards,
Maxim Uvarov

--001a11c37f5a842e7e04dd681b4b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">2013/5/23 David Daney <span dir=3D"ltr">&lt;<a href=3D"mailto:ddane=
y.cavm@gmail.com" target=3D"_blank">ddaney.cavm@gmail.com</a>&gt;</span><br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
On 05/23/2013 02:21 AM, Wladislav Wiebe wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
When kernel halt&#39;s will reboot_mutex lock still hold at exit.<br>
It will issue with &#39;halt&#39; command:<br>
$ halt<br>
..<br>
Sent SIGKILL to all processes<br>
Requesting system halt<br>
[66.729373] System halted.<br>
[66.733244]<br>
[66.734761] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<u></u>=3D=3D=3D=3D=3D=3D=3D<br>
[66.739473] [ BUG: lock held at task exit time! ]<br>
[66.744188] 3.8.7-0-sampleversion-fct #49 Tainted: G =A0 =A0 =A0 =A0 =A0 O<=
br>
[66.750202] ------------------------------<u></u>-------<br>
[66.754913] init/21479 is exiting with locks still held!<br>
[66.760234] 1 lock held by init/21479:<br>
[66.763990] =A0#0: =A0(reboot_mutex){+.+...}, at: [&lt;ffffffff801776c8&gt;=
] SyS_reboot+0xe0/0x218<br>
[66.772165]<br>
[66.772165] stack backtrace:<br>
[66.776532] Call Trace:<br>
[66.778992] [&lt;ffffffff805780a8&gt;] dump_stack+0x8/0x34<br>
[66.783972] [&lt;ffffffff801618b0&gt;] do_exit+0x610/0xa70<br>
[66.788948] [&lt;ffffffff801777a8&gt;] SyS_reboot+0x1c0/0x218<br>
[66.794186] [&lt;ffffffff8013d6a4&gt;] handle_sys64+0x44/0x64<br>
<br>
<br>
</blockquote>
[...]<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Acked-by: Maxim Uvarov &lt;<a href=3D"mailto:muvarov@gmail.com" target=3D"_=
blank">muvarov@gmail.com</a>&gt;<br>
Signed-off-by: Wladislav Wiebe &lt;<a href=3D"mailto:wladislav.kw@gmail.com=
" target=3D"_blank">wladislav.kw@gmail.com</a>&gt;<br>
---<br>
=A0 arch/mips/cavium-octeon/setup.<u></u>c | =A0 =A04 ++++<br>
=A0 1 file changed, 4 insertions(+)<br>
<br>
diff --git a/arch/mips/cavium-octeon/<u></u>setup.c b/arch/mips/cavium-octe=
on/<u></u>setup.c<br>
index b0baa29..04ce396 100644<br>
--- a/arch/mips/cavium-octeon/<u></u>setup.c<br>
+++ b/arch/mips/cavium-octeon/<u></u>setup.c<br>
@@ -457,6 +457,10 @@ static void octeon_halt(void)<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 octeon_kill_core(NULL);<br>
+<br>
+ =A0 =A0 =A0 /* We stop here */<br>
+ =A0 =A0 =A0 while (1)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;<br>
</blockquote>
<br>
I want to put a WAIT here so we don&#39;t burn so much power.<br>
<br>
I will send a patch to do that instead.<br>
<br></blockquote><div><br></div><div>what about adding wait for other mips =
boards where is while (1) is used?<br><br></div><div>Maxim.<br></div><div>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=A0 }<br>
<br>
=A0 /**<br>
<br>
</blockquote>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Best regards,<br>Maxim =
Uvarov
</div></div>

--001a11c37f5a842e7e04dd681b4b--
