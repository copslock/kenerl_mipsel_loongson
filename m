Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 19:49:49 +0200 (CEST)
Received: from mail-yb0-x22c.google.com ([IPv6:2607:f8b0:4002:c09::22c]:33258
        "EHLO mail-yb0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993887AbdFORtmi2dci (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2017 19:49:42 +0200
Received: by mail-yb0-x22c.google.com with SMTP id 84so6161553ybe.0
        for <linux-mips@linux-mips.org>; Thu, 15 Jun 2017 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BZSzYAycHpgUUVsHpFyI8l+8OQOyR5IEINOmLXdArfo=;
        b=tu9iKfybNzs4GahbOrA+wT2FbhVaQwBYL0I6Bb6YJHPBxfyRdgboItp1Ft632lJ70+
         q5AL1o9JCb5oSXzkR+Cl8dYSjjGpnyVZYixvPUBjoKMKNo17Xrqv3UXn16eiyqObjd8D
         bf61uJxY1G8x3ioM8XmTc5aY+m4G5BKZBcPNRIR4zf1AAy4tkSxDdO1+XSnpCm0ewtp5
         XEVaI2E4Sy5NmZeRObIbXDujnGvCv+Grut5Li8FT1aT/S24QrOMy4yLWX215l2QUE2N4
         +21zu4/HOFqnef+k9Np6EX73CAr9mosHn07mK45Cc8l/UfZUfxWeVyjX91Zo+PGlJyLn
         th8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BZSzYAycHpgUUVsHpFyI8l+8OQOyR5IEINOmLXdArfo=;
        b=NzDLR8DJNufWvJG7Q51gJwf4MiE3pPum45rieHLp8tNaYA8oR7Rx2/HlcuiNHHXCwe
         D7qtq6+p0T+kTJfM0T/2OYNIgCMdF4rFNagU4eealdwbhB+kBZGjctB4BQcw7jw+Rgjp
         77wvTpcRV1LwHwchbIJSNB3Jg0umcGd55OJvyvalxLKcIMqT0a+nrx1HtLFr735mwkyE
         osWIK0gGxdmzRo+DK3JEXEconmd/bmeud72OZ6gTNdkEn7SvFXj2C+st0/xCTYIwFoyy
         jYEpPR0gb10KHi+7ZdGzlAUW6xvyvGXVcZFrtKOJCfme1Q8+Z0++TSJzHsRKTMMoCSkx
         k8Ww==
X-Gm-Message-State: AKS2vOyaDUd/se8AQTxLj1w1Ek4jjEQeyDbebjaT9J8jVs/pxz2h1/Dc
        drkJt8K3cf9XQAx2QdcX0nq/S1xorA==
X-Received: by 10.37.218.5 with SMTP id n5mr5617391ybf.83.1497548976589; Thu,
 15 Jun 2017 10:49:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.128.200 with HTTP; Thu, 15 Jun 2017 10:49:16 -0700 (PDT)
In-Reply-To: <ba54aeb4-3b6d-c959-93a4-b94328865dd3@bethel-hill.org>
References: <ba54aeb4-3b6d-c959-93a4-b94328865dd3@bethel-hill.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 15 Jun 2017 10:49:16 -0700
Message-ID: <CAEdQ38HXhD29HSb3TJerPYqadQw6pKt7xRgo9kLFpWDVZkJJcQ@mail.gmail.com>
Subject: Re: Free MIPS hardware....you pay shipping.
To:     "Steven J. Hill" <sjhill@bethel-hill.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        port-sgimips@netbsd.org, port-mips@netbsd.org,
        port-hpcmips@netbsd.org, sibyte-users@bitmover.com,
        sibyte-users <sibyte-users@mcvoy.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Thu, Jun 15, 2017 at 10:02 AM, Steven J. Hill <sjhill@bethel-hill.org> wrote:
> Hello.
>
> It is time to get rid of more hardware. If you pay shipping, you
> can have it. Here is the first batch:
>
>   (1) SiByte SWARM board in ATX case
>   (1) R8000 SGI Indigo2
>   (4) Philips Nino (Windows CE) handheld PCs. Three of them are
>       the monochrome units and one of them is color.
>
> I have a ton, in the literal sense, of more SGI hardware that I
> need to go through in the next couple of months. Email me if
> interested.

I'm interested. My SWARM had been doing lots of Gentoo things, but has
become unstable.

I'll email you off list.

Thanks!
