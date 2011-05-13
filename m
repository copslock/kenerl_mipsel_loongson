Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 19:51:55 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:41542 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1EMRvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 19:51:51 +0200
Received: by pwi8 with SMTP id 8so1520716pwi.36
        for <multiple recipients>; Fri, 13 May 2011 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d/1GAyNLhieuOsHfoanEzGx+HAlgm13tzqf7iIZ2vmk=;
        b=OxS8E3V961N1X0gzIJnSoK0UbySOHTbuoZ884W2eiRzqTwPRFCg4VMaoBY37CpBN+T
         grijvty095W+BIg7KWgQ5cxp52y32j73YGXnjPlFRQPp20eIpKdvWCH/aflFGeU2a7n0
         xBAYa1JzFahHDuBMgMO3uBRCtxcFhH4uocTU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YoNQhlG+zmN7++Fp8G+rmmk9mvPC6rCq0+wjxEdDGigETLEioAtEQr06ZvtsauPtBL
         wVCb58omlTK4DO/c7oLNTUzSFGmUUyoq9dyDtAonqgsLw1ilK/tXOCeir2FPakjXiKy+
         lk0nQw6QfIvCD/leS3VFTlrQrbcxT6g7XWDoc=
MIME-Version: 1.0
Received: by 10.68.7.66 with SMTP id h2mr2605634pba.513.1305309104890; Fri, 13
 May 2011 10:51:44 -0700 (PDT)
Received: by 10.68.51.72 with HTTP; Fri, 13 May 2011 10:51:44 -0700 (PDT)
In-Reply-To: <20110513173633.GA14607@jayachandranc.netlogicmicro.com>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
        <20110513150707.GA26389@linux-mips.org>
        <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
        <20110513155605.GA30674@linux-mips.org>
        <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com>
        <20110513173633.GA14607@jayachandranc.netlogicmicro.com>
Date:   Fri, 13 May 2011 10:51:44 -0700
Message-ID: <BANLkTim+z7TSCvNA2duA6LsUzNsiu9OQaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 10:36 AM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> For 32-bit the config is nlm_xlr_defconfig in the source tree. Let me know if
> you need any further info.

Would you be able to dump out the TLB handlers in this configuration,
per David's suggestion?

Thanks.
