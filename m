Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 23:28:10 +0200 (CEST)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:50448 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493575AbZJTV2D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2009 23:28:03 +0200
Received: by bwz21 with SMTP id 21so147477bwz.24
        for <multiple recipients>; Tue, 20 Oct 2009 14:27:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yAyQJ4Q1QRqp67DoPTaU4e8Wkxqxk8+mKYCmNxjf2Po=;
        b=PDAhNPTA6PobneKJrfFPZ4MuKgwO7s8dQ56WME+oDO3NwVmGM1fWVDCUKLN2KlF4ZM
         3PQ2xa7ydEEnxq9d18BqFolTYAqeqLBHpP4pMWMZxy5hXGiT0KN2QdCRJAK3mPv/uoJh
         3QNtMdghe35MZ/9n+MTXMfuLIF1U4T7AHJdkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DX0PiqghZrxHucjX46fJJ6bGZl26H0pbfSASllJq3plSywOmHs9Blc69PeT63RlmXV
         GrpJJMxw04K1EOagRV1VnC4d/0Mwz7nVXuUsAYDKgEJ4CflJIJFoRy57eFcFXLlSUb7V
         ejEgrxrrnmd971eV7rBissfmd8xLAVJFXHgig=
MIME-Version: 1.0
Received: by 10.204.34.13 with SMTP id j13mr6981986bkd.32.1256074076017; Tue, 
	20 Oct 2009 14:27:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
	 <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
Date:	Tue, 20 Oct 2009 23:27:55 +0200
Message-ID: <63386a3d0910201427i1dd8c789i1c9bceeea250d98c@mail.gmail.com>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code 
	generic
From:	Linus Walleij <linus.ml.walleij@gmail.com>
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	Linus Walleij <linus.walleij@stericsson.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.ml.walleij@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.ml.walleij@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/20 Thomas Gleixner <tglx@linutronix.de>:

> On Sun, 18 Oct 2009, Linus Walleij wrote:
>> This moves the clocksource_set_clock() and clockevent_set_clock()
>> from the MIPS timer code into clockchips and clocksource where
>> it belongs.
> (...)
> Please do not make that functions inline. They are too large and there
> is no benefit of inlining them.

I think there is, because these functions in MIPS if I'm not misreading it, are
used once each in one and one spot only in the clocksource/clockevent
set-up at boot time for each platform in which they are currently used.

Further these spots tend to be __init or even __cpuinit code segments,
so they will be discarded and if we inline the code it will be discarded
after boot as well.

If you foresee that the code will be used in other ways under other
circumstances, I will make them non-inlined of course, but I have a
hard time seeing that.

OK?

Linus Walleij
