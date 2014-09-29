Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 21:37:20 +0200 (CEST)
Received: from mail-yk0-f177.google.com ([209.85.160.177]:56411 "EHLO
        mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009967AbaI2ThRY5k8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 21:37:17 +0200
Received: by mail-yk0-f177.google.com with SMTP id q200so1210842ykb.36
        for <multiple recipients>; Mon, 29 Sep 2014 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rKXv1n4uvzseN9ERKHCDhJA2L2kqnivd0lUmvnvUars=;
        b=ry+E4+ds70rp/UQPfTXqtaYJQpxH0FaIsDHoeTYKYFvY+nA8L12LIn0JO9JoYk3obz
         y+wCMJw1ANx7fijJvO1cusOSvjCBNGC1P5OB/eXkD+g7YA6lgVyzLYamMLoYCDRV4JRt
         KBEEBTpBDYdzld6371Ie3SRYfTyO/0c9ElDQp9mpkad/HM5bLxd89MIwmq1VGSOTh20o
         Gpzv/XRnqUdeJnqygEnUX03KTai/WTyNg1lzBY9xk0IpkCHBInWKZq+0CRqtNO4kkM3k
         E/jjH1a1sUuFnH4cKPCol2yM82Xqt4R3H0VCrLJr7mTNQjWnjrBApRXEW03vR9eDwlUp
         MRLw==
X-Received: by 10.236.31.4 with SMTP id l4mr3334649yha.158.1412019431235; Mon,
 29 Sep 2014 12:37:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.135 with HTTP; Mon, 29 Sep 2014 12:36:51 -0700 (PDT)
In-Reply-To: <CAOiHx==peRWkQjSOJvtJVKoiRdiugiu6-hmrEsafWw3K8HS1Ww@mail.gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
 <1411929195-23775-6-git-send-email-ryazanov.s.a@gmail.com> <CAOiHx==peRWkQjSOJvtJVKoiRdiugiu6-hmrEsafWw3K8HS1Ww@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Mon, 29 Sep 2014 23:36:51 +0400
Message-ID: <CAHNKnsTFm83PjQXK-45hjXgWSragzJr60L5sFA2CWKwTJ6mSVA@mail.gmail.com>
Subject: Re: [PATCH 05/16] MIPS: ar231x: add early printk support
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-09-29 16:47 GMT+04:00 Jonas Gorski <jogo@openwrt.org>:
> Have you tried using EARLY_PRINTK_8250 instead? Since this is a 8250 anyway.
>
I plan to do that a bit later.

-- 
BR,
Sergey
