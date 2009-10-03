Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Oct 2009 16:36:28 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:49172 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097287AbZJCOgW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Oct 2009 16:36:22 +0200
Received: by bwz4 with SMTP id 4so1676734bwz.0
        for <multiple recipients>; Sat, 03 Oct 2009 07:36:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jQjrYN6MJleuIniaRMJ0hyOg2m1VGHvok9W5B3F6LtA=;
        b=FtS7jAez6jn23rrBFMdlPMwxYtz7oppFZd0Rk5tPb1kHWSjCNfFAqn9WMbPPCCsPw8
         spYesWLElNmiWv+QRGIt+bmEWPx4ecuv/SRTFzpM0vfFiorB2uIJOBC9aqmy3nTQu2r9
         IHzZJ/BnbJSY7SKNohhXopFHb8bGUFT+tL3P0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x2uKyLn5T91ueS6fW2utTRHHJAwigB1OTv/rwLw/EXOw+VamvX5TX305q5oflVDKPU
         8oH3BmEybEiTFA2cnrDHbyPJZiVwk8jSxn9bF1/CPmWPJqwFMzfxfISGXEa4M8Vd+RkJ
         +r3DiAXSpL7VTSgpSthwhhkphBoQR1FbLg2p4=
MIME-Version: 1.0
Received: by 10.103.126.3 with SMTP id d3mr914588mun.101.1254580576804; Sat, 
	03 Oct 2009 07:36:16 -0700 (PDT)
In-Reply-To: <20091003140349.GA11381@linux-mips.org>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
	 <20091002105903.GC3179@pengutronix.de>
	 <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com>
	 <20091002125423.GD3179@pengutronix.de>
	 <f861ec6f0910020732p2ff76990q1e7a2bca16e52e64@mail.gmail.com>
	 <20091003102221.GB24206@pengutronix.de>
	 <f861ec6f0910030449q635360ct12d6c47cfb24670d@mail.gmail.com>
	 <20091003140349.GA11381@linux-mips.org>
Date:	Sat, 3 Oct 2009 16:36:16 +0200
Message-ID: <f861ec6f0910030736m25a230edq4fb8665844237813@mail.gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Wolfram Sang <w.sang@pengutronix.de>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

> Deending on the urgency you assign to these patches I can keep them in
> my queue for 2.6.33 and push them upstream for linux-next.

No hurry; 2.6.33 is fine. I've fixed a few typos and thinkos in them and will
resend soon.  I'd just like to get these in your queue first, so I can base my
DB1300 work on it.

Thanks!
        Manuel Lauss
