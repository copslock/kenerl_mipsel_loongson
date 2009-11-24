Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 07:36:17 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:56093 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1491960AbZKXGgO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 07:36:14 +0100
Received: by fxm8 with SMTP id 8so6557906fxm.27
        for <multiple recipients>; Mon, 23 Nov 2009 22:36:08 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=5dynzYV19RvLdJgeAscN0MhR+YlrK8dajRYZ0Ygu8UI=;
        b=sMH+DYrh255pyKPEKivZf94bs0Ps5g5jon/+v+VW+3z+nrZ4Y3OkQCCrY+PZkrUbRs
         VZdNx9kV6NTysQoxpepJSsV+NNFEdfWmCgn7paslDxsWAwL0/XKg5mBGPvDJe6boOYTT
         2LXax8Bg4YGdRlx+tHCVvY3c0RCkmApBU0HNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Pwilx3OgIVh1sc2S97asEc5nKlLN9IWx68pAveimGi9nZ0mBS2QxafPOTEhGDQZy5e
         IEhfxDz3oCzz/S/A7tuOMPWz2Zk+vt9A+Pk/xBDyeSj/XYVjlfpabZfeJllkPRS9eK3c
         79euDZCz7pYBNWHyCgNu6prAd+f3i1JzCPwTY=
MIME-Version: 1.0
Received: by 10.103.21.24 with SMTP id y24mr2618655mui.110.1259044568689; Mon, 
	23 Nov 2009 22:36:08 -0800 (PST)
In-Reply-To: <20091123231740.GC27817@linux-mips.org>
References: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com>
	 <1259005202-7771-2-git-send-email-manuel.lauss@gmail.com>
	 <1259005202-7771-3-git-send-email-manuel.lauss@gmail.com>
	 <20091123231740.GC27817@linux-mips.org>
Date:	Tue, 24 Nov 2009 07:36:08 +0100
Message-ID: <f861ec6f0911232236u2e3f49eqae6c1605c5a0f48@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: Alchemy: irq: use runtime CPU type detection
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 12:17 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Nov 23, 2009 at 08:40:02PM +0100, Manuel Lauss wrote:
>
>> Use runtime CPU detection instead of relying on preprocessor symbols.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> Thanks, queued for 2.6.33.

Thank you.  Could you also please rename the file from "irq.c" to "irq-au1000.c"
(and fix the Makefile).  The new name better reflects what type of CPU it is
supposed to work with. I'd send a patch, but I figure doing a "git mv" on your
end is faster and preserves the history of the file.

Thanks!
     Manuel Lauss
