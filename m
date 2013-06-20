Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 17:54:52 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55944 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820510Ab3FTJumSNqOu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 11:50:42 +0200
Received: by mail-ie0-f171.google.com with SMTP id qd12so16026629ieb.2
        for <multiple recipients>; Thu, 20 Jun 2013 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E9W0oZMcs2PH09NC7CYGtJnuOx7sB5cu7mN2QTtoH0M=;
        b=maoTThYUiLqYug+4V78BivHDaovP56rEMaxWqt+nETIQpXRLKzfR2nLt7yrSZ4FzYI
         Tee7YQN3suQexdMMg9f3Wf/PsahI4IioGfDWfb6CBKXXiOJeRu8CB1M4umFeCuEsJ3mT
         k5VgpcSwfUWut0lMGQgR7Yw+5orOE+ZNykgWg+kBK0R61oBiP01wRZkB2nk7lQaapB+i
         BdoNS/pd8B+8wX0kb780VL9YDFZJX0dUFH4Rq2tNfAfXFmeIkDMY5NR936oE0o1UHN2X
         M1FckHPY4AoT7k6Y9Y+N6YUMQwXtzJnu8lbO0gcngs+wDPk5XxB2qD7wUKqmWSyjcOxT
         UAnw==
MIME-Version: 1.0
X-Received: by 10.50.23.108 with SMTP id l12mr11782484igf.45.1371721835196;
 Thu, 20 Jun 2013 02:50:35 -0700 (PDT)
Received: by 10.50.164.227 with HTTP; Thu, 20 Jun 2013 02:50:35 -0700 (PDT)
In-Reply-To: <51C22901.7050709@imgtec.com>
References: <20130527124421.GA32322@hades>
        <20130527124557.GB32322@hades>
        <51A36EE6.3040901@cogentembedded.com>
        <51C22901.7050709@imgtec.com>
Date:   Thu, 20 Jun 2013 17:50:35 +0800
Message-ID: <CA+zhxNk+KguZYbHFOEU2xXU5E7zuc7RbHGzRHG_W1q3=3=RL=g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] MIPS: microMIPS: Add kernel_uses_mmips in cpu-features.h
From:   Tony Wu <tung7970@gmail.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>, david.daney@cavium.com,
        linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=089e0149cbe8b7b81b04df92e07e
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37064
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

--089e0149cbe8b7b81b04df92e07e
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jun 20, 2013 at 5:56 AM, Steven J. Hill <Steven.Hill@imgtec.com>wrote:

> On 05/27/2013 09:34 AM, Sergei Shtylyov wrote:
>
>> Hello.
>>
>> On 27-05-2013 16:45, Tony Wu wrote:
>>
>>  Add kernel_uses_mmips to denote whether CONFIG_CPU_MICROMIPS
>>> is set or not. This variable can help cut down #ifdef usage.
>>>
>>
>>     You can avoid #ifdef usage with using IS_BUILTIN() macro, not
>> defining extra macros.
>>
>>  Signed-off-by: Tony Wu <tung7970@gmail.com>
>>> Cc: David Daney <david.daney@cavium.com>
>>> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
>>>
>>
>> WBR, Sergei
>>
>>
>>  I think this patch is not needed with <http://patchwork.linux-mips.**
> org/patch/5327/ <http://patchwork.linux-mips.org/patch/5327/>> being used
> instead?
>
> -Steve
>
>
I think cpu_has_mmips does not necessary mean kernel is compiled using
microMIPS ISA, so I added kernel_uses_mmips for that purpose. We can remove
this patch, but the third patch of this patch set will need some
modifications. I will send new patches later.

Thanks,
Tony

--089e0149cbe8b7b81b04df92e07e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Jun 20, 2013 at 5:56 AM, Steven J. Hill <span dir=
=3D"ltr">&lt;<a href=3D"mailto:Steven.Hill@imgtec.com" target=3D"_blank">St=
even.Hill@imgtec.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D""><div class=3D"h5">On 05/27/2013 09:34 AM, =
Sergei Shtylyov wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Hello.<br>
<br>
On 27-05-2013 16:45, Tony Wu wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Add kernel_uses_mmips to denote whether CONFIG_CPU_MICROMIPS<br>
is set or not. This variable can help cut down #ifdef usage.<br>
</blockquote>
<br>
=A0 =A0 You can avoid #ifdef usage with using IS_BUILTIN() macro, not<br>
defining extra macros.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Signed-off-by: Tony Wu &lt;<a href=3D"mailto:tung7970@gmail.com" target=3D"=
_blank">tung7970@gmail.com</a>&gt;<br>
Cc: David Daney &lt;<a href=3D"mailto:david.daney@cavium.com" target=3D"_bl=
ank">david.daney@cavium.com</a>&gt;<br>
Cc: Steven J. Hill &lt;<a href=3D"mailto:Steven.Hill@imgtec.com" target=3D"=
_blank">Steven.Hill@imgtec.com</a>&gt;<br>
</blockquote>
<br>
WBR, Sergei<br>
<br>
<br>
</blockquote></div></div>
I think this patch is not needed with &lt;<a href=3D"http://patchwork.linux=
-mips.org/patch/5327/" target=3D"_blank">http://patchwork.linux-mips.<u></u=
>org/patch/5327/</a>&gt; being used instead?<br>
<br>
-Steve<br>
<br>
</blockquote></div><br></div><div class=3D"gmail_extra" style>I think cpu_h=
as_mmips does not necessary mean kernel is compiled using microMIPS ISA, so=
 I added kernel_uses_mmips for that purpose. We can remove this patch, but =
the third patch of this patch set will need some modifications. I will send=
 new patches later.</div>
<div class=3D"gmail_extra" style><br></div><div class=3D"gmail_extra"><div =
class=3D"gmail_extra" style>Thanks,</div><div class=3D"gmail_extra" style>T=
ony</div></div></div>

--089e0149cbe8b7b81b04df92e07e--
