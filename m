Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2009 16:32:24 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:35247 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492713AbZJBOcS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Oct 2009 16:32:18 +0200
Received: by bwz4 with SMTP id 4so1066938bwz.0
        for <linux-mips@linux-mips.org>; Fri, 02 Oct 2009 07:32:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jGcaZjK99XtaNrUPzqLCxKHSfVzbSKAwn0DaXatuYqs=;
        b=Zk/NIQvMoZYSIEZ6y416eRxQfofvVo/eynCv/v44QkAkSxX/m/6TNtgIW9EjCMp0fM
         3jNUFrzu0xbzxK5z44bae8Er56WtSV0Fb4WAACSch/gLfxc2eZZOydctJioPNHI5HYcR
         lRNRgphAjEkRiAv4yJGED0ai7BDuJxZYtzQqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TDCWZhOmddN0QTlO+H63fErWZ3UsgGbqn2q6UaA13iebTq3g/v74Kbei/xKPtgt9EQ
         A22fYr2ZdgcsjlMZ1lNXnMRcP0OMKnu7M4yR3k+w2ngbvMs/boa0IyaptHK4GZK0Zg0K
         Fg74tV+J7VXmANIKu1aUx6DPOIG25adsO3hLo=
MIME-Version: 1.0
Received: by 10.102.226.17 with SMTP id y17mr463581mug.67.1254493931746; Fri, 
	02 Oct 2009 07:32:11 -0700 (PDT)
In-Reply-To: <20091002125423.GD3179@pengutronix.de>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
	 <20091002105903.GC3179@pengutronix.de>
	 <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com>
	 <20091002125423.GD3179@pengutronix.de>
Date:	Fri, 2 Oct 2009 16:32:11 +0200
Message-ID: <f861ec6f0910020732p2ff76990q1e7a2bca16e52e64@mail.gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 2, 2009 at 2:54 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> >> Rewritten XXS1500 PCMCIA socket driver, standalone (doesn't
>> >> depend on au1000_generic.c) and added carddetect IRQ support.
>> >
>> > I am not familiar with the details here. Why did you choose to drop the generic
>> > au1000-part for this and the other driver?
>>
>> I want to get rid of au1000_generic.[ch] eventually or at least all of its
>> contents except the static mapping and resource allocation functions, which
>> are board- independent.  On the other hand these are so short that I opted to
>> just duplicate them into the xxs1500_ss.c and db1xxx_ss.c (other patch)
>> files.  The db1xxx_ss (for the Alchemy demoboards) is supposed to be an
>> example on how to set up PCMCIA on Alchemy SoCs.
>
> Yeah, I saw that you want to remove it, still I don't know why :) Is it feature
> incomplete and updating is impossible? Is the concept outdated? Could you
> enlighten me on that?

I started out with the intention to fix its styling issues, add carddetect irq
support, etc.  In the end it was easier to write a quick-and-dirty standalone
full-features socket driver for the DB1200 and extend it to support the
other DB/PB boards. While I was at it I modified my driver for the xxs1500,
that's all.

The only *technical* reason I have is a personal dislike for how the current
one works: it forces every conceivable board to add dozens of cpp macros
for mem/io ranges and gets registered by board-independent code.
Hardly convincing, I know.

        Manuel Lauss
