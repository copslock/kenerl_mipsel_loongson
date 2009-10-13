Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 22:30:44 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:58564 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493622AbZJMUag convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 22:30:36 +0200
Received: by fxm21 with SMTP id 21so8581806fxm.33
        for <multiple recipients>; Tue, 13 Oct 2009 13:30:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pPpu352WqORY/kg0HNK8LARDU2MJBFqUtKi2XsHQUB8=;
        b=iXUCleNp1kjdJwZoHamgy0lNk9r0GeJrIkDkDOWtYBnGbcywyYlnNh0BB1Q1fXRU6F
         rGIDURreMJi23l4kWKy5uPWkly99hm1vfy/QF3kIoowq41QNeXf0B/KwEUpe4SiOE9Wa
         RGhP1OAb+hnTVS9kCJ1ptyNWKI/TzI4EPKA0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lVwyB3KSuu8P1Ku0Yw2EJaPIpLMlIl/hYDpRQFz4JzkzFpQ4gJPHrHiS+tOXEv9jIj
         CBkwRNjL+CcKjb4EADoN0BEY83uG5F5J0DW0d9tYID3bKRc7hyWbu3Q4NZQKnMhVQleQ
         ua/W1NQAZdIvcrU3QGrN9Q9Pq9EUMqG0mx0eI=
MIME-Version: 1.0
Received: by 10.223.4.214 with SMTP id 22mr711050fas.34.1255465829750; Tue, 13 
	Oct 2009 13:30:29 -0700 (PDT)
In-Reply-To: <20091013195822.GA2686@linux-mips.org>
References: <90edad820910131055t3cb46d39t87fa568c001634cf@mail.gmail.com>
	 <20091013195822.GA2686@linux-mips.org>
Date:	Tue, 13 Oct 2009 23:30:29 +0300
Message-ID: <90edad820910131330t67d6b293o150bef62aec0c5eb@mail.gmail.com>
Subject: Re: [RFC] [IP22] parsing PROM variables at startup
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 10:58 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Oct 13, 2009 at 08:55:12PM +0300, Dmitri Vorobiev wrote:
>
>> I tried booting a few kernels, ranging from 2.2.1 to the current Linus
>> Git, on my IP22s using an ecoff image directly, without the help of
>> arcboot or tip22. It turns out that during many years (at least, since
>> the times of late 2.4 series) the sizes of ecoff images have been so
>> big that ARCS was not capable of reading the kernel images. Therefore,
>> I'd like to claim that it's safe to assume that at least from now on,
>> nobody is ever going to boot ecoffs on IP22 whatsoever, and arcboot
>> and tip22 remain the only way to load Linux on an IP22 machine.
>
> Only the very oldest IP22 firmware does not support ELF files.  In practice
> those seem to be very rare - I never encountered one - and Linux
> distributions are shipping a 2nd stage bootloader, so there never has
> been much of a need for booting ECOFF, at least not on Indy.

That is, it's safe to assume that it's either a 32-bit ELF or a 2nd
stage bootloader that gets loaded by the firmware.

>
>> I'm leading to the following thing. Currently we have the
>> arch/mips/fw/arc/cmdline.c, which assumes that the kernel could
>> receive command-line parameters directly from PROM, including such
>> variables as OSLoadPartition, OSLoadFilename, etc. Both arcboot and
>> tip22 handle those parameters by themselves, never exposing them to
>> the kernel. The latter fact is easy to see from the sources of the
>> arcboot and tip22 loaders. That said, I would like to simplify
>> arch/mips/fw/arc/cmdline.c::prom_init_cmdline() so that the PROM
>> variables do not get any special treatment.
>
> But keep kernels usable without a 2nd stage bootloader.  I for example
> have never ever used one on my SGI hardware.

OK, thanks for the notice. I'll see to it that the kernels are usable
if loaded directly by the firmware.

Thanks,
Dmitri
