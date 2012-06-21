Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2012 09:38:30 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:39507 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903465Ab2FUHiX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2012 09:38:23 +0200
Received: by ghbf11 with SMTP id f11so232747ghb.36
        for <multiple recipients>; Thu, 21 Jun 2012 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GwYXTsc1Upa8Fsp8dmcnBix6wk5Rmz4fKUjlEs5gcrc=;
        b=PiYsWAtMpEU4fpQ/77Gw6R9PVBS/zaorxSJFPKUQk6iWLmB3ZamaAlr7OZlG8RZaX1
         vikK8twnUTZYaxOz4SStD17EgVmNvuh94Iw5UfcL4Pt4CFc9Cdg01cnVRTeJe9AD4WDj
         j/5FUFeMyYucdybK9NxYZsS/3yBLAe6qmBfSdHD9vItT9HcWNwhMPbSS31u7Hl0qnHY7
         qteDggi4AKCi1cwT38RgKS0cg1xfcN7kG80sG9K5x7qsglz3L+TIOeLkrmkamZ3yPdwD
         2l1dj/6zeU+rZPsXgzkhZ9ptueoj1uQ9LKQ6bhCfe60Il1RFj3sZDAWmgmM69bE7Pmm1
         k4Eg==
Received: by 10.50.197.194 with SMTP id iw2mr6683652igc.31.1340264296584; Thu,
 21 Jun 2012 00:38:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.42.197 with HTTP; Thu, 21 Jun 2012 00:37:56 -0700 (PDT)
In-Reply-To: <4FE225F3.4080806@mvista.com>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
 <1339757617-2187-3-git-send-email-keguang.zhang@gmail.com>
 <20120620192551.GC29446@linux-mips.org> <4FE225F3.4080806@mvista.com>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 21 Jun 2012 15:37:56 +0800
Message-ID: <CAJhJPsXg-AepTg8fVrvnnFY8SsBdccubF9WSKJy9hM_BSBV5Aw@mail.gmail.com>
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, wuzhangjin@gmail.com,
        zhzhl555@gmail.com
Content-Type: multipart/alternative; boundary=14dae93404cd4d975004c2f699ab
X-archive-position: 33751
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

--14dae93404cd4d975004c2f699ab
Content-Type: text/plain; charset=ISO-8859-1

2012/6/21 Sergei Shtylyov <sshtylyov@mvista.com>

> Hello.
>
>
> On 06/20/2012 11:25 PM, Ralf Baechle wrote:
>
>  +#include <linux/clk.h>
>>>
>>
>  +static LIST_HEAD(clocks);
>>> +static DEFINE_MUTEX(clocks_mutex);
>>> +
>>> +struct clk *clk_get(struct device *dev, const char *name)
>>> +{
>>> +       struct clk *c;
>>> +       struct clk *ret = NULL;
>>> +
>>> +       mutex_lock(&clocks_mutex);
>>> +       list_for_each_entry(c, &clocks, node) {
>>> +               if (!strcmp(c->name, name)) {
>>> +                       ret = c;
>>> +                       break;
>>> +               }
>>> +       }
>>> +       mutex_unlock(&clocks_mutex);
>>> +
>>> +       return ret;
>>> +}
>>> +EXPORT_SYMBOL(clk_get);
>>>
>>
>  This redefines a function that already is declared in <linux/clk.h> and
>> defined in drivers/clk/clkdev.c.  Why?
>>
>
>   Because he doesn't support clkdev? clkdev support is optional.
>
>
Yes, that's what I mean.


>
>  +int clk_register(struct clk *clk)
>>> +{
>>> +       mutex_lock(&clocks_mutex);
>>> +       list_add(&clk->node, &clocks);
>>> +       if (clk->ops->init)
>>> +               clk->ops->init(clk);
>>> +       mutex_unlock(&clocks_mutex);
>>> +
>>> +       return 0;
>>> +}
>>> +EXPORT_SYMBOL(clk_register);
>>>
>>
>  Same here.
>>
>
>    Ralf
>>
>
> WBR, Sergei
>



-- 
Best Regards!
Kelvin

--14dae93404cd4d975004c2f699ab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/21 Sergei Shtylyov <span dir=3D"l=
tr">&lt;<a href=3D"mailto:sshtylyov@mvista.com" target=3D"_blank">sshtylyov=
@mvista.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Hello.<div class=3D"im"><br>
<br>
On 06/20/2012 11:25 PM, Ralf Baechle wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+#include &lt;linux/clk.h&gt;<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+static LIST_HEAD(clocks);<br>
+static DEFINE_MUTEX(clocks_mutex);<br>
+<br>
+struct clk *clk_get(struct device *dev, const char *name)<br>
+{<br>
+ =A0 =A0 =A0 struct clk *c;<br>
+ =A0 =A0 =A0 struct clk *ret =3D NULL;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;clocks_mutex);<br>
+ =A0 =A0 =A0 list_for_each_entry(c, &amp;clocks, node) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(c-&gt;name, name)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D c;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;clocks_mutex);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+EXPORT_SYMBOL(clk_get);<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This redefines a function that already is declared in &lt;linux/clk.h&gt; a=
nd<br>
defined in drivers/clk/clkdev.c. =A0Why?<br>
</blockquote>
<br></div>
 =A0 Because he doesn&#39;t support clkdev? clkdev support is optional.<div=
 class=3D"im"><br></div></blockquote><div><br>Yes, that&#39;s what I mean.<=
br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">

<div class=3D"im">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+int clk_register(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 mutex_lock(&amp;clocks_mutex);<br>
+ =A0 =A0 =A0 list_add(&amp;clk-&gt;node, &amp;clocks);<br>
+ =A0 =A0 =A0 if (clk-&gt;ops-&gt;init)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk-&gt;ops-&gt;init(clk);<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;clocks_mutex);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+EXPORT_SYMBOL(clk_register);<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Same here.<br>
</blockquote>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
 =A0 Ralf<br>
</blockquote>
<br>
WBR, Sergei<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Best Regards!<br>Kelvin=
<br><br><img src=3D"http://ubuntucounter.geekosophical.net/img/ubuntu-blogg=
er.php?user=3D26540"><br><br>

--14dae93404cd4d975004c2f699ab--
