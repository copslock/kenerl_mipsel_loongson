Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2010 17:05:54 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:45730 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490960Ab0HQPFv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Aug 2010 17:05:51 +0200
Received: by pxi4 with SMTP id 4so2700517pxi.36
        for <multiple recipients>; Tue, 17 Aug 2010 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=CoQ3kCpQLF2+507Qdbf1yfproC8kw6WbRvkJMCu9drY=;
        b=nfz4GX7ljzOpVL++7LX97PDqbM1LyG+Jk26MoLXRHyPWMTtqsGGx38pOeGNB7sE8bE
         qD2da+0cqFxHifSZ1Kxo0V4joTOrJzNjk5xCq8EaiQ5gpAmK1wsf54Ow9qSXcquGJAQB
         ZOvt399WGNjpHffHGYf74BAZnU8/NeTrP5dhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=qiGLEvYbqFJ9QFKNPcpEVdjAd70JwlOgX2JJLnFm17/DfXIIllbhZOuw/1VHN79qna
         XXF9RTkQowPsThLka4ZncGil/qs2J6P6EYogh+iTYMi35DM6T7W8zC/RYbTrq80K3DHY
         fdpG48KCgUA8UVhXk7GwuVuDKeSNxAecgHGj0=
Received: by 10.142.192.1 with SMTP id p1mr5857196wff.287.1282057542586;
        Tue, 17 Aug 2010 08:05:42 -0700 (PDT)
Received: from [192.168.15.10] ([211.201.183.151])
        by mx.google.com with ESMTPS id w4sm7986017wfd.20.2010.08.17.08.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 08:05:41 -0700 (PDT)
Subject: Re: [PATCH] MIPS: remove RELOC_HIDE on __pa_symbol
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.s.daney@gmail.com>,
        linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
In-Reply-To: <20100817150035.GC17861@linux-mips.org>
References: <1281297456-2711-1-git-send-email-namhyung@gmail.com>
         <4C5F8ED8.90301@gmail.com> <20100809122147.GA23053@linux-mips.org>
         <1281409628.1670.11.camel@leonhard> <20100817150035.GC17861@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 18 Aug 2010 00:05:35 +0900
Message-ID: <1282057535.1635.10.camel@leonhard>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 8bit
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

2010-08-17 (화), 16:00 +0100, Ralf Baechle:
> On Tue, Aug 10, 2010 at 12:07:08PM +0900, Namhyung Kim wrote:
> 
> > I've sent basically same patch to x86 folks [1] and they said there is a
> > possiblility of miscompilation on gcc 3. I am not sure the same goes
> > here on mips but it might be safer to keep it. Sorry for the noise ;-(
> > 
> > [1] http://lkml.org/lkml/2010/8/8/138
> 
> So in a distant future when GCC 3.x will finally be retired we will be
> able to apply this patch, sigh.  I'll drop your patch for the time being
> and add a comment to the code.
> 
> Thanks!
> 
>   Ralf

FYI, the exact version introduced -f[no-]strict-overlow was gcc 4.2.

-- 
Regards,
Namhyung Kim
