Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Aug 2010 05:07:26 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:51510 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490956Ab0HJDHW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Aug 2010 05:07:22 +0200
Received: by pwi9 with SMTP id 9so1893624pwi.36
        for <multiple recipients>; Mon, 09 Aug 2010 20:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=OJ1dGkoJee+9dW6WkbFF6bBKwwa0ssIwvgFhEXrnlBg=;
        b=eZynmNr+PuvwG1GgZIzVPWy2s6jyLhoVYPrbVeir2N0yxFfu7aJWR9STdgMA4enayX
         u5YYEDwbviib+NRVEmZHwQ/OZEM4NABYHW0aumbx+ksZSOi9G4hlg6YYL/4Lp5oh3vij
         bSi0zUQqS4YVWvxElG2PGgmsaXXSS6mt+fdk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=u0mUZfVKMfjQMCMlTQUtYrZnrXYF7+g6iTLdj7fENDi8QUvJIZIHD9qS/VJKVrI3OI
         4sbW3B9PahnkpHw2Y+/0DyD2tLfDc+3JMQUT9c8x8rbOHy1uXM5dNb+un0WVqAmAeNT+
         dUMwzEhqY78u7y8p0BsBtRUJGA+HqBEIwiP1Y=
Received: by 10.142.194.15 with SMTP id r15mr14445963wff.306.1281409634291;
        Mon, 09 Aug 2010 20:07:14 -0700 (PDT)
Received: from [192.168.15.10] ([211.178.117.190])
        by mx.google.com with ESMTPS id n2sm7232496wfl.1.2010.08.09.20.07.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 20:07:13 -0700 (PDT)
Subject: Re: [PATCH] MIPS: remove RELOC_HIDE on __pa_symbol
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.s.daney@gmail.com>,
        linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
In-Reply-To: <20100809122147.GA23053@linux-mips.org>
References: <1281297456-2711-1-git-send-email-namhyung@gmail.com>
         <4C5F8ED8.90301@gmail.com>  <20100809122147.GA23053@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 10 Aug 2010 12:07:08 +0900
Message-ID: <1281409628.1670.11.camel@leonhard>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 8bit
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

2010-08-09 (월), 13:21 +0100, Ralf Baechle:
> On Sun, Aug 08, 2010 at 10:15:04PM -0700, David Daney wrote:
> > Maybe you could explain in more detail the problems you are having
> > with the current definition of __pa_symbol().  I would be hesitant
> > to change this bit of black magic unless there is a concrete problem
> > you are trying to solve.
> 
> RELOC_HIDE was originally added by 6007b903dfe5f1d13e0c711ac2894bdd4a61b1ad
> (lmo) rsp. 8431fd094d625b94d364fe393076ccef88e6ce18 (kernel.org).  A
> discussion can be found in lkml posting
> a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com> which is
> archived at
> 
>     http://lists.linuxcoding.com/kernel/2006-q3/msg17360.html
> 
> I felt this was dubious by the time it was added and probably should go?
> 
>   Ralf

Hi,

I've sent basically same patch to x86 folks [1] and they said there is a
possiblility of miscompilation on gcc 3. I am not sure the same goes
here on mips but it might be safer to keep it. Sorry for the noise ;-(

[1] http://lkml.org/lkml/2010/8/8/138


-- 
Regards,
Namhyung Kim
