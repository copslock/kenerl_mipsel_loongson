Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 06:36:18 +0100 (BST)
Received: from qw-out-1920.google.com ([74.125.92.145]:19361 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025181AbZD1FgM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 06:36:12 +0100
Received: by qw-out-1920.google.com with SMTP id 9so318771qwj.54
        for <multiple recipients>; Mon, 27 Apr 2009 22:36:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SulP5hUtkymxf2Phjd4DtazkoEoPYHXsL8CUDlDO6HE=;
        b=J5f6hZ9cFc3XHyWXRt3qklsWLvehSo0EhSTzE5Q23I/zM4ZnrBBR3xaUw22SBEeIcu
         /GvTmySvqP6tDRsYiFvyU643JiEb//MCAMdALkRF6aa5eJMjvQ8fvppF886k/qlbpK3p
         Ym3d7yEOyNnOwwuBbIM6KyJwi/rszVTnotD4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mlxGEYaWIeFYmVXZj/8LD4iLe5Jq+OUXae9jzjyIpvqnXMhbUvZJy3THSLhrRLZs8H
         qZo07SWHHyfFSF702+q3hd70Oza/tw7LTvSVsLI4hr4AR4CKeGeRKkrktNX5jITjB1F2
         wmdQEYbjnJ8utgw1QsBNiSDkmB5a5/yQ1a4UQ=
MIME-Version: 1.0
Received: by 10.220.76.144 with SMTP id c16mr12527454vck.17.1240896969631; 
	Mon, 27 Apr 2009 22:36:09 -0700 (PDT)
In-Reply-To: <49F5B090.4030801@ru.mvista.com>
References: <E1LyQQX-00047N-6E@localhost>
	 <20090427130952.GA30817@linux-mips.org>
	 <49F5B090.4030801@ru.mvista.com>
Date:	Mon, 27 Apr 2009 23:36:09 -0600
Message-ID: <b2b2f2320904272236l3a925e9at87fc23f1a75c1dac@mail.gmail.com>
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e6470e0c140532046896d7d8
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e6470e0c140532046896d7d8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi:

On Mon, Apr 27, 2009 at 7:18 AM, Sergei Shtylyov <sshtylyov@ru.mvista.com>wrote:

> Hello.
>
> Ralf Baechle wrote:
>
>  There have been a number of compile problems with the msp71xx
>>> configuration ever since it was included in the linux-mips.org
>>> repository.  This patch resolves these problems:
>>> - proper files are included when using a squashfs rootfs
>>> - resetting the board no longer uses non-existent GPIO routines
>>> - create the required plat_timer_setup function
>>>
>>
>   get_c0_compare_int(), you mean?
>

Yes, I should have said, remove the duplicate definition of plat_timer_setup
and add the required definition of get_c0_compare_int.


> This patch has been compile-tested against the current HEAD.
>>
>
 Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
>>
>
 diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>>> b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>>> index c936756..a54e85b 100644
>>> --- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>>> +++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>>> @@ -21,7 +21,6 @@
>>>
>>> #if defined(CONFIG_PMC_MSP7120_GW)
>>> #include <msp_regops.h>
>>> -#include <msp_gpio.h>
>>> #define MSP_BOARD_RESET_GPIO    9
>>> #endif
>>>
>>> @@ -88,11 +87,8 @@ void msp7120_reset(void)
>>>         * as GPIO char driver may not be enabled and it would look up
>>>         * data inRAM!
>>>         */
>>> -       set_value_reg32(GPIO_CFG3_REG,
>>> -                       basic_mode_mask(MSP_BOARD_RESET_GPIO),
>>> -                       basic_mode(MSP_GPIO_OUTPUT,
>>> MSP_BOARD_RESET_GPIO));
>>> -       set_reg32(GPIO_DATA3_REG,
>>> -                       basic_data_mask(MSP_BOARD_RESET_GPIO));
>>> +       set_value_reg32(GPIO_CFG3_REG, 0xf000, 0x8000);
>>> +       set_reg32(GPIO_DATA3_REG, 8);
>>>
>>>        /*
>>>         * In case GPIO9 doesn't reset the board (jumper configurable!)
>>> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c
>>> b/arch/mips/pmc-sierra/msp71xx/msp_time.c
>>> index 7cfeda5..cca64e1 100644
>>> --- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
>>> +++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
>>> @@ -81,10 +81,7 @@ void __init plat_time_init(void)
>>>        mips_hpt_frequency = cpu_rate/2;
>>> }
>>>
>>> -void __init plat_timer_setup(struct irqaction *irq)
>>> +unsigned int __init get_c0_compare_int(void)
>>> {
>>> -#ifdef CONFIG_IRQ_MSP_CIC
>>> -       /* we are using the vpe0 counter for timer interrupts */
>>> -       setup_irq(MSP_INT_VPE0_TIMER, irq);
>>> -#endif
>>> +       return MSP_INT_VPE0_TIMER;
>>> }
>>>
>>
>  The rest seems ok.  Can you fix the issue above and send a new patch?
>>
>
>   Better yet 3 patches as the 3 issues seem totally unrelated.


I will respin as three patches.  It looks like the squashfs part is
controversial, but the other two shouldn't be affected.

 Thanks!
>>
>
>   Ralf
>>
>
> WBR, Sergei


Shane

--0016e6470e0c140532046896d7d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi:<br><br><div class=3D"gmail_quote">On Mon, Apr 27, 2009 at 7:18 AM, Serg=
ei Shtylyov <span dir=3D"ltr">&lt;<a href=3D"mailto:sshtylyov@ru.mvista.com=
">sshtylyov@ru.mvista.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
Hello.<div class=3D"im"><br>
<br>
Ralf Baechle wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

There have been a number of compile problems with the msp71xx<br>
configuration ever since it was included in the <a href=3D"http://linux-mip=
s.org" target=3D"_blank">linux-mips.org</a><br>
repository. =A0This patch resolves these problems:<br>
- proper files are included when using a squashfs rootfs<br>
- resetting the board no longer uses non-existent GPIO routines<br>
- create the required plat_timer_setup function<br>
</blockquote></blockquote>
<br></div>
 =A0 get_c0_compare_int(), you mean?<div class=3D"im"></div></blockquote><d=
iv class=3D"im"><br>Yes, I should have said, remove the duplicate definitio=
n of plat_timer_setup and add the required definition of get_c0_compare_int=
.<br>
=A0<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

This patch has been compile-tested against the current HEAD.<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Signed-off-by: Shane McDonald &lt;<a href=3D"mailto:mcdonald.shane@gmail.co=
m" target=3D"_blank">mcdonald.shane@gmail.com</a>&gt;<br>
</blockquote></blockquote>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div><=
/div><div class=3D"h5"><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierr=
a/msp71xx/msp_setup.c<br>
index c936756..a54e85b 100644<br>
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c<br>
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c<br>
@@ -21,7 +21,6 @@<br>
<br>
#if defined(CONFIG_PMC_MSP7120_GW)<br>
#include &lt;msp_regops.h&gt;<br>
-#include &lt;msp_gpio.h&gt;<br>
#define MSP_BOARD_RESET_GPIO =A0 =A09<br>
#endif<br>
<br>
@@ -88,11 +87,8 @@ void msp7120_reset(void)<br>
 =A0 =A0 =A0 =A0 * as GPIO char driver may not be enabled and it would look=
 up<br>
 =A0 =A0 =A0 =A0 * data inRAM!<br>
 =A0 =A0 =A0 =A0 */<br>
- =A0 =A0 =A0 set_value_reg32(GPIO_CFG3_REG,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 basic_mode_mask(MSP_BOARD_RES=
ET_GPIO),<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 basic_mode(MSP_GPIO_OUTPUT, M=
SP_BOARD_RESET_GPIO));<br>
- =A0 =A0 =A0 set_reg32(GPIO_DATA3_REG,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 basic_data_mask(MSP_BOARD_RES=
ET_GPIO));<br>
+ =A0 =A0 =A0 set_value_reg32(GPIO_CFG3_REG, 0xf000, 0x8000);<br>
+ =A0 =A0 =A0 set_reg32(GPIO_DATA3_REG, 8);<br>
<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * In case GPIO9 doesn&#39;t reset the board (jumper config=
urable!)<br>
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra=
/msp71xx/msp_time.c<br>
index 7cfeda5..cca64e1 100644<br>
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c<br>
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c<br>
@@ -81,10 +81,7 @@ void __init plat_time_init(void)<br>
 =A0 =A0 =A0 =A0mips_hpt_frequency =3D cpu_rate/2;<br>
}<br>
<br>
-void __init plat_timer_setup(struct irqaction *irq)<br>
+unsigned int __init get_c0_compare_int(void)<br>
{<br>
-#ifdef CONFIG_IRQ_MSP_CIC<br>
- =A0 =A0 =A0 /* we are using the vpe0 counter for timer interrupts */<br>
- =A0 =A0 =A0 setup_irq(MSP_INT_VPE0_TIMER, irq);<br>
-#endif<br>
+ =A0 =A0 =A0 return MSP_INT_VPE0_TIMER;<br>
}<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
The rest seems ok. =A0Can you fix the issue above and send a new patch?<br>
</blockquote>
<br></div></div>
 =A0 Better yet 3 patches as the 3 issues seem totally unrelated.</blockquo=
te><div><br>I will respin as three patches.=A0 It looks like the squashfs p=
art is controversial, but the other two shouldn&#39;t be affected. <br><br>

</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote=
 class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); =
margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Thanks!<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
 =A0Ralf<br>
</blockquote>
<br>
WBR, Sergei</blockquote><div><br>Shane <br></div></div><br>

--0016e6470e0c140532046896d7d8--
