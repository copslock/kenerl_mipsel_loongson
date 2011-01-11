Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2011 05:05:46 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:43913 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491770Ab1AKEFn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jan 2011 05:05:43 +0100
Received: by fxm19 with SMTP id 19so18953399fxm.36
        for <linux-mips@linux-mips.org>; Mon, 10 Jan 2011 20:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h1Tr5WXw5F8OYHT8qu4gqNA0GgqEWvOePQ6iTG411MU=;
        b=qADD8E9Bm1fJgObsem0mQ5ZlYcbx96BZcavVByW1JvMHLdBMETTVLoXc+q/hHIow4E
         zP4L2vDm5MAGbPF9Am7Z4wcvYt03T/wlvUEzHsa9S8FAuNCLUNIbIn1oTXSHidI2mLEr
         IDiuXFRPEY11ZsFkXa040imAegW2qMJ5iql9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a8lr6krEtwINMSpfepHTtl+/OI/husC7qmU4sb+K2Z52ZtFTFQ7DZejvuQsQGvfmyi
         JvbRDHK7EJI26LsEDM2Cn0fnYjm5i6/pWqL+yxLGHQseZrJ2s9IULvsmJf0xruWjrb5a
         RAD+H3jxvxreyXSZWYL3Z1C9P4KSKonvFJa2o=
MIME-Version: 1.0
Received: by 10.223.74.15 with SMTP id s15mr629334faj.28.1294718738161; Mon,
 10 Jan 2011 20:05:38 -0800 (PST)
Received: by 10.223.74.136 with HTTP; Mon, 10 Jan 2011 20:05:37 -0800 (PST)
In-Reply-To: <4D2B5E46.3070609@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
        <1293470392.27661.202.camel@paanoop1-desktop>
        <1293524389.27661.210.camel@paanoop1-desktop>
        <4D19A31E.1090905@paralogos.com>
        <1293798476.27661.279.camel@paanoop1-desktop>
        <4D1EE913.1070203@paralogos.com>
        <1294067561.27661.293.camel@paanoop1-desktop>
        <4D21F5D3.50604@paralogos.com>
        <1294082426.27661.330.camel@paanoop1-desktop>
        <4D22D7B3.2050609@paralogos.com>
        <1294146165.27661.361.camel@paanoop1-desktop>
        <1294151822.27661.375.camel@paanoop1-desktop>
        <4D235717.1000603@paralogos.com>
        <1294163657.27661.386.camel@paanoop1-desktop>
        <4D2367EE.7000702@paralogos.com>
        <1294233097.27661.391.camel@paanoop1-desktop>
        <4D24C525.5000306@paralogos.com>
        <1294345396.27661.422.camel@paanoop1-desktop>
        <4D2650D6.4030102@paralogos.com>
        <1294387019.27661.458.camel@paanoop1-desktop>
        <4D2B5E46.3070609@paralogos.com>
Date:   Tue, 11 Jan 2011 09:35:37 +0530
Message-ID: <AANLkTinA6Qk-h--wos__u1tW_pMUman6wjoectK-xinV@mail.gmail.com>
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 11, 2011 at 1:00 AM, Kevin D. Kissell <kevink@paralogos.com> wrote:
>
> Would this still be with a "tickful" kernel?  I was able to run some
> experiments on a Malta over the weekend, using mostly default
> Malta defconfig options including tickless operation.  The 2.6.32.27
> build comes up with both VPEs and all TCs firing.  2.6.36.2 with
> the stackframe.h patch boots all the way up on a single VPE, but
> VERY slowly - as if the Clock/Compare setups weren't being done
> correctly and timer intervals were waiting the full Count register
> rollover cycle.  I've been looking at diffs, and merged one change
> that was made to cevt-r4k.c into the analogous routine in cevt-smtc.c
> (no change), but there's clearly more breakage to the SMTC/Malta
> configuration post-2.6.32 than just the stackframe.h patch.  Going
> tickful may work around it, but tickful+SMTC is grossly inefficient.

Yes that is true my configuration is using tickful . I had reported this
issue with tickless kernel . I think you missed my last email. I will
resend.

Thanks
Anoop
>
>            Regards,
>
>            Kevin K.
>
>
>
>
>
