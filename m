Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 14:14:42 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:58694 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491019Ab1EPMOj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 14:14:39 +0200
Received: by wwb17 with SMTP id 17so4176439wwb.24
        for <linux-mips@linux-mips.org>; Mon, 16 May 2011 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c3sUpqxzThHGzczXxjbrSpPf2ozxP1sfp6/U+WHumCI=;
        b=ez78XPPQwace9RGkTkeeU6w1XhTxw0fLf9BgRJZkNqYvQi8xif145XlkRCHIUByYWJ
         17bppUj5wmxd59MwIFh5aA6vce8jeX8qAjZgIIgoDf9Too8z39iFFjebWs/msx3al16t
         HLwnuJxVRILYIicrSIIJxHrIJg6E3FchyXqNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z9nJFrPM9+AZwAc66FCTWpkUXqkwgetiTtPpRmbrZsyCiJqYsJyWsyU+NrE4MYYh5b
         hTCTkY+vkzNQHeNYMLCTSbdcAGvK5JiVvxomdjHH63xt8Bdc6DqAAEyLdZcWSwaJuvjM
         pQdaYxArqklyRYY4aoMhJS57xLYRa5aj2NQqI=
MIME-Version: 1.0
Received: by 10.216.237.217 with SMTP id y67mr468436weq.1.1305548073612; Mon,
 16 May 2011 05:14:33 -0700 (PDT)
Received: by 10.216.35.205 with HTTP; Mon, 16 May 2011 05:14:33 -0700 (PDT)
In-Reply-To: <201105161333.20981.florian@openwrt.org>
References: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6>
        <201105161023.33072.florian@openwrt.org>
        <alpine.DEB.2.00.1105160533590.7414@localhost6.localdomain6>
        <201105161333.20981.florian@openwrt.org>
Date:   Mon, 16 May 2011 14:14:33 +0200
Message-ID: <BANLkTikcU8fBrNEYBXX2=hyWqJ0Yw+69pw@mail.gmail.com>
Subject: Re: reference to non-existent CONFIG_HAVE_GPIO_LIB variable?
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Mon, May 16, 2011 at 1:33 PM, Florian Fainelli <florian@openwrt.org> wrote:
> Hello,
>
> On Monday 16 May 2011 11:36:46 Robert P. J. Day wrote:
>> On Mon, 16 May 2011, Florian Fainelli wrote:
>> > Hello,
>> >
>> > On Sunday 15 May 2011 01:05:58 Robert P. J. Day wrote:
>> > >   the current kernel source contains a Makefile reference to the above
>> > >
>> > > Kconfig variable that does not appear to be defined anywhere.
>> >
>> > It would help if you mention which Makefile references this Kconfig
>> > variable along with the changeset which introduced it.
>>
>>   quite so, my bad.  here's the changeset:
>
> Thank you. I think the author rather meant ARCH_WANT_OPTIONAL_GPIOLIB instead,
> can you build test a patch with this and submit it if you are happy with it?

Looking at the sources of the two files, I think they can only be
built when CONFIG_GPIOLIB=y, so the following plus a
"select ARCH_WANT_OPTIONAL_GPIOLIB" entry to
arch/mips/pmc-sierra/Kconfig  should do the right thing:

-obj-$(CONFIG_HAVE_GPIO_LIB) += gpio.o gpio_extended.o
+obj-$(CONFIG_GPIOLIB) += gpio.o gpio_extended.o

Manuel
