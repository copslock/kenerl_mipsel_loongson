Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2009 23:28:25 +0200 (CEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:62182 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492138AbZFLV2S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2009 23:28:18 +0200
Received: by fxm23 with SMTP id 23so2915827fxm.0
        for <linux-mips@linux-mips.org>; Fri, 12 Jun 2009 14:28:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JiEqwo1LAB+vaywj527K87t8zoF7nbJdRWREL/Tdzoc=;
        b=nZ8Vkn/M2N6W78gaOshjqgDupTmKnWLEsQN4Q7r10FakhVsHvo4ns18nW26UWkvmCo
         00rsQ7DBwfdN8PcrUHKpk8fEYCxRbrBkfkUHS2EiXo59yM+XrWzXQyjnzJHzcHQzQirB
         UhORJ9S2AGMyt9gtJXaF5Yt0u8uvD8X7sL8AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZesbT5eDoqznkLrP+dTZ54yfWzyIGqeL3cdtCmN3fkGLiL+gaPsu9ovzJVM5f1FnDK
         beDpWvTeWnHf4/0dInfjbRvKd+P6/jVsoxH0qFWK5NgvwfS54mUj+9AYXmsTfZQbMVSB
         8nNz+54LBdTr26554OsHDmu8sdKTUXvBafrJs=
MIME-Version: 1.0
Received: by 10.204.103.203 with SMTP id l11mr4044788bko.71.1244842091829; 
	Fri, 12 Jun 2009 14:28:11 -0700 (PDT)
In-Reply-To: <4A32C3EC.4060606@paralogos.com>
References: <eefc325c0906121335i6b575864kd10ca52948c36bd8@mail.gmail.com>
	 <4A32C3EC.4060606@paralogos.com>
Date:	Sat, 13 Jun 2009 02:58:11 +0530
Message-ID: <eefc325c0906121428y53a969eahe4f194eae58b8ebb@mail.gmail.com>
Subject: Re: smtc support
From:	Anoop P A <an4linu@gmail.com>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e6d7dff4af5953046c2d62b9
Return-Path: <an4linu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: an4linu@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e6d7dff4af5953046c2d62b9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks for your inputs.

My platforms support is not available in lmo kernel.( So I am free to use
any version of kernel :) )

Since you are the guy who wrote SMTC stuff , I think you are the right
person to answer few of my queries. How much performance improvement you are
getting in SMTC mode. Will it give us any reasonable performance
improvements.( As I could see some other negaive comments . just curious!).
Does it make sence to use SMP ( my SOC is having 2 VPE each with couple of
threads).

Thanks
An



On Sat, Jun 13, 2009 at 2:39 AM, Kevin D. Kissell <kevink@paralogos.com>wrote:

> As the guy who wrote the SMTC stuff, I'd recommend picking up something
> newer.  Ralf has merged some of the subsequent improvements and fixes into
> 2.6.18, but not the patches that I made last year to allow tickless support,
> which is actually a very, very good thing to have for SMTC.  That support
> was initially available in 2.6.24, but subsequently got broken by some
> changes to control register manipulation APIs that I identified and fixed a
> few months ago.  Ralf back-merged them into several recent baselines, but
> I'm not sure which ones. 2.6.29-stable seems to have all the right patches
> applied for SMTC, but of course I can't tell whether there would be other
> issues for your platform.
>
>         Regards,
>
>         Kevin K.
>
>
> Anoop P A wrote:
>
>> Hi List,
>>
>> I have got a reference board with mips 34k core SOC.I am planning to
>> enable smtc/smp support . The reference kernel I am having is linux-2.6.18
>> which is in uniprocessor mode.
>>
>>  Could any of you suggest me in which way i have to proceed?. Does it make
>> sense to continue using 2.6.18 or port newer kernel version ( which might be
>> having better SMTC/SMP support)?
>> Thanks
>> An
>>
>
>

--0016e6d7dff4af5953046c2d62b9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div><br></div><div>Thanks for your inputs.=A0</div><div><br></div><div=
>My platforms support is not available in lmo kernel.( So I am free to use =
any version of kernel :) )=A0</div><div><br></div><div>Since you are the gu=
y who wrote SMTC stuff , I think you are the right person to answer few of =
my queries. How much performance improvement you are getting in SMTC mode. =
Will it give us any reasonable performance improvements.( As I could see so=
me other negaive comments . just curious!). Does it make sence to use SMP (=
 my SOC is having 2 VPE each with couple of threads).=A0</div>
<div><br></div><div>Thanks</div><div>An</div><div><br></div><div><br><br><d=
iv class=3D"gmail_quote">On Sat, Jun 13, 2009 at 2:39 AM, Kevin D. Kissell =
<span dir=3D"ltr">&lt;<a href=3D"mailto:kevink@paralogos.com">kevink@paralo=
gos.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">As the guy who wrote the SMTC stuff, I&#39;=
d recommend picking up something newer. =A0Ralf has merged some of the subs=
equent improvements and fixes into 2.6.18, but not the patches that I made =
last year to allow tickless support, which is actually a very, very good th=
ing to have for SMTC. =A0That support was initially available in 2.6.24, bu=
t subsequently got broken by some changes to control register manipulation =
APIs that I identified and fixed a few months ago. =A0Ralf back-merged them=
 into several recent baselines, but I&#39;m not sure which ones. 2.6.29-sta=
ble seems to have all the right patches applied for SMTC, but of course I c=
an&#39;t tell whether there would be other issues for your platform.<br>

<br>
 =A0 =A0 =A0 =A0 Regards,<br>
<br>
 =A0 =A0 =A0 =A0 Kevin K.<div><div></div><div class=3D"h5"><br>
<br>
Anoop P A wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi List,<br>
<br>
I have got a reference board with mips 34k core SOC.I am planning to enable=
 smtc/smp support . The reference kernel I am having is linux-2.6.18 which =
is in uniprocessor mode.<br>
<br>
=A0Could any of you suggest me in which way i have to proceed?. Does it mak=
e sense to continue using 2.6.18 or port newer kernel version ( which might=
 be having better SMTC/SMP support)? <br>
Thanks<br>
An<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div>

--0016e6d7dff4af5953046c2d62b9--
