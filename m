Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2009 13:16:12 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:58681 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493054AbZJBLQF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Oct 2009 13:16:05 +0200
Received: by fxm21 with SMTP id 21so893780fxm.33
        for <linux-mips@linux-mips.org>; Fri, 02 Oct 2009 04:15:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=H2sHoB9BKG5T1itKZjbNJSqUpnIOI0mPtXxDOJ+SKSw=;
        b=pXYqxY2SgaCpNZYOih/YdM59urKGSRn2n+tZycx8JFH2NllaEE9LvqpSNWZdGoKK7n
         JJisEHllYvuyBZwAKZtnZS3GhUyCMEkJbHcLldpfJrNU7TnEJ+176LMvm8kS63rK8cT3
         rH5VlK4QZpnXn5EwhjwC/IG9XVu4l4zaDzfoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xmtByGvP04HKAnulglSYplFqveBf8Dz3aOAYDqig7dEYorgVHzn2YeiVulo2oQEzRm
         oYmPFSd/CfCvg3KPVOdlZZ9f4hpOhfxSXcujeEnT5bLp7yT+8H21lTw23k4XXDVnmgl4
         1c3yCVmlKIMUYDVBEI06aSpZ8jPxT/lOIqNNQ=
MIME-Version: 1.0
Received: by 10.103.76.37 with SMTP id d37mr917394mul.99.1254482159673; Fri, 
	02 Oct 2009 04:15:59 -0700 (PDT)
In-Reply-To: <20091002105903.GC3179@pengutronix.de>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
	 <20091002105903.GC3179@pengutronix.de>
Date:	Fri, 2 Oct 2009 13:15:59 +0200
Message-ID: <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Servus Wolfram,

On Fri, Oct 2, 2009 at 12:59 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> Rewritten XXS1500 PCMCIA socket driver, standalone (doesn't
>> depend on au1000_generic.c) and added carddetect IRQ support.
>
> I am not familiar with the details here. Why did you choose to drop the generic
> au1000-part for this and the other driver?

I want to get rid of au1000_generic.[ch] eventually or at least all of
its contents
except the static mapping and resource allocation functions, which are board-
independent.  On the other hand these are so short that I opted to
just duplicate
them into the xxs1500_ss.c and db1xxx_ss.c (other patch) files.  The db1xxx_ss
(for the Alchemy demoboards) is supposed to be an example on how to set up
PCMCIA on Alchemy SoCs.

Danke,
        Manuel Lauss
