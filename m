Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 15:04:11 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33726 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010589AbbDFNEJEwJ42 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 15:04:09 +0200
Received: by iebmp1 with SMTP id mp1so20219416ieb.0;
        Mon, 06 Apr 2015 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JGfsLObtDd0HITV//CwEkxx7bLa1uZp/cjcJ7kU4Jas=;
        b=aNmKAAzl0R893muLpIcovBpG9tk0JFwkWXEi2UlTl/S+HmNbJjlq/AHR+/MiiH3l/l
         4IfWR2+1N0MBxZYLblkNEwEV9jB3dRkZq13pTOFDRAgkuCEzmmtwiOndC5sgF9VwMQZ2
         b2H/1dJ/9E5Xz6N1o+RS2lW3NbOr85qq6qkMoqT5DaMWY7gsPo50AxuBmr2Kyx2/kbOe
         K5s3/MvXjfiPc9pRb7YbBA4utz7rmmV5tgdpFLQoDeYQL8NrMSmnkVDr6c4L42HV4orL
         oMw5xLcI5HSWgxFuwQ3TvI6ohQxw6nxGulHMowQZ5f2NXGjOgRIutcSNZ70ViGceKcF/
         Z1Tw==
X-Received: by 10.42.132.200 with SMTP id e8mr15860737ict.86.1428325444114;
 Mon, 06 Apr 2015 06:04:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.239.38 with HTTP; Mon, 6 Apr 2015 06:03:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1504021342130.5791@eddie.linux-mips.org>
References: <1427389644-92793-1-git-send-email-fykcee1@gmail.com>
 <20150330201015.GA3757@linux-mips.org> <CAGXxSxU_fCvUqkrFDU64MOgsyOW3XkcrSuB7DjcBMODG-B8=xw@mail.gmail.com>
 <alpine.LFD.2.11.1504021342130.5791@eddie.linux-mips.org>
From:   cee1 <fykcee1@gmail.com>
Date:   Mon, 6 Apr 2015 21:03:43 +0800
Message-ID: <CAGXxSxUD_CPuN-YA9aWDzumZHF1HU8NStyCDSBadmUpz4VTc3Q@mail.gmail.com>
Subject: Re: [v5] MIPS: lib: csum_partial: more instruction paral
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Chen Jie <chenj@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

2015-04-02 20:59 GMT+08:00 Maciej W. Rozycki <macro@linux-mips.org>:
>  I'm not sure if any such other superscalar MIPS pipeline implementation
> exists, but if written correctly then at worst it won't hurt anyone else,
> so just make sure your change does not regress scalar MIPS pipelines.  I
> hope you have a way to verify it.
>
>   Maciej

It seems the P-Class of Warrior generation of MIPS CPU has a
superscalar MIPS pipeline(http://imgtec.com/mips/warrior/pclass.asp).

Anyway, I've written a small benchmark at
http://dev.lemote.com/files/upload/software/csum-opti/csum-test.tar.gz

Someone can download and modify it:
1. config.h
2. change NR_ITERATION to a proper value in bench.c

And run 'make run_bench', which will: 1) run a benchmark; 2) generate
the result of `before-opti vs after-opti'; 3) invoke a python
script(parse.py) to preprocess the result.

Then paste the content of benchresult.txt to Calc / Excel / Numeric,
etc and analyze it.



-- 
Regards,

- cee1
