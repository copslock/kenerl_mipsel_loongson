Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2011 22:16:16 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:57160 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492062Ab1HVUQM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Aug 2011 22:16:12 +0200
Received: by vxj2 with SMTP id 2so5414377vxj.36
        for <linux-mips@linux-mips.org>; Mon, 22 Aug 2011 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=YZRyJECMbbJdvCryhQcUjtpe29lE2AAgeX02VZAGDmo=;
        b=jtC1/OEDGlLUVTqRSIvwUbBfnjexsHWMzbQ6BDdzBgeaJmHy87eFqCzPQMMy0XDGx1
         rbXfI1UtAN/r9YdHY59gUPnThpjPkEPv4TlRS3/IwVcyIyYOG7m0jxoDPKGof3TrIVbv
         tqzBUqq7vwPIVrqt7jepw/xMfP2oebR7ZiPi4=
Received: by 10.52.65.240 with SMTP id a16mr2624253vdt.490.1314044166202; Mon,
 22 Aug 2011 13:16:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Mon, 22 Aug 2011 13:15:45 -0700 (PDT)
In-Reply-To: <20110822080658.GA2657@mails.so.argh.org>
References: <20110821010513.GZ2657@mails.so.argh.org> <CAEdQ38G8VEh+Q0gOZb7_YgvQK6n2f3u=Bep59tZ9hGJfz+C08Q@mail.gmail.com>
 <20110822080658.GA2657@mails.so.argh.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 22 Aug 2011 16:15:45 -0400
Message-ID: <CAEdQ38HEm-==pvo8egWoy234tAFpYvgc98Muveh+C5P_R8qtog@mail.gmail.com>
Subject: Re: [PATCH] mips/loongson: unify compiler flags and load location for
 Loongson 2E and 2F
To:     Andreas Barth <aba@not.so.argh.org>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16216

On Mon, Aug 22, 2011 at 4:06 AM, Andreas Barth <aba@not.so.argh.org> wrote:
> * Matt Turner (mattst88@gmail.com) [110822 02:20]:
>> On Sat, Aug 20, 2011 at 9:05 PM, Andreas Barth <aba@not.so.argh.org> wrote:
>> > diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
>> > index 29692e5..d6471a5 100644
>> > --- a/arch/mips/loongson/Platform
>> > +++ b/arch/mips/loongson/Platform
>> > @@ -4,10 +4,8 @@
>> >
>> >  # Only gcc >= 4.4 have Loongson specific support
>> >  cflags-$(CONFIG_CPU_LOONGSON2) += -Wa,--trap
>> > -cflags-$(CONFIG_CPU_LOONGSON2E) += \
>> > -       $(call cc-option,-march=loongson2e,-march=r4600)
>> > -cflags-$(CONFIG_CPU_LOONGSON2F) += \
>> > -       $(call cc-option,-march=loongson2f,-march=r4600)
>> > +cflags-$(CONFIG_CPU_LOONGSON2) += \
>> > +       $(call cc-option,-march=r4600)
>> >  # Enable the workarounds for Loongson2f
>> >  ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
>> >   ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
>>
>> ... but I don't understand this one.
>>
>> So, in the name of simplification, let's just remove the ability to
>> compile with -march=loongson2{e,f}? What?
>
> I want to build a kernel that works on both 2e and 2f. Such a kernel
> must not be built with 2e or 2f specific code (which are incompatible
> to each other).

I understand the desire, but this is removing the ability to build the
kernel with -march=loongson2e or -march=loongson2f.

A Kconfig option should be added to allow building the kernel with
-march=r4600 for generic Loongson2 compatibility if you want to build
one kernel for 2e and 2f.

Matt
