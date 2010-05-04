Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 21:28:22 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:59402 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492722Ab0EDT2R convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 21:28:17 +0200
Received: by wwf26 with SMTP id 26so78931wwf.36
        for <multiple recipients>; Tue, 04 May 2010 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=0VTDwgDTaaEGPuDDOZAM+X/ZrEo6ISvLqhtc9Xgs1SU=;
        b=rnZCo+TreQ65ogQyZib0YL8r3Qf1fm0c5G2vZ90SGH44IbJq3poqNgDtsk4xdLcS/u
         0dzXLlkZoIgXxavIr1GXdKxyWxX8sW2kFuP77C72axU5nTJmFg8C4kZ89ZqURVUEyE+2
         i775IH9KKRSncpLRpzcLDxei3Y/2+eqyL9Xrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ets14hXEy8WzMNIHgDWucwAgf+jpKWpg5C0zpdQce2cJSdgUbJBiXM5CcwtEOgzkAs
         iecJGNfC/D7J+0oqKYXJ0sTSy/c9elLMuH30j2nqwv+9rzKwr5/KR33aTv9rvGqUvc8A
         qLIgS1Y6asUUmCqP+6TqB9ZzwqP+VJad8oNws=
MIME-Version: 1.0
Received: by 10.216.178.148 with SMTP id f20mr1337746wem.43.1273001290942; 
        Tue, 04 May 2010 12:28:10 -0700 (PDT)
Received: by 10.216.93.131 with HTTP; Tue, 4 May 2010 12:28:09 -0700 (PDT)
In-Reply-To: <20100504184457.GA21929@linux-mips.org>
References: <E1O8lDn-0000Sk-86@localhost>
         <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
         <4BDF8092.1060401@paralogos.com>
         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
         <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
         <4BE00207.6030506@paralogos.com>
         <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>
         <4BE0479E.6060506@paralogos.com>
         <20100504184457.GA21929@linux-mips.org>
Date:   Tue, 4 May 2010 21:28:09 +0200
X-Google-Sender-Auth: 40a425a0cc9ede97
Message-ID: <k2s10f740e81005041228pea323400u89dfcefd4a5047d0@mail.gmail.com>
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Kevin D. Kissell" <kevink@paralogos.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, May 4, 2010 at 20:44, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, May 04, 2010 at 09:13:18AM -0700, Kevin D. Kissell wrote:
>
>> What we used to use was what I *thought* was an old public domain
>> program whose name was an English word that had something to do with
>> being exacting.  Googling with obvious keywords didn't turn it up.
>
> Is it paranoia by any chance?  Paranoia is available as single files at:
>
>  http://www.math.utah.edu/~beebe/software/ieee/paranoia.c
>  http://www.math.utah.edu/~beebe/software/ieee/paranoia.h

You also need

http://www.math.utah.edu/~beebe/software/ieee/args.h

Ran fine on:
  - Toshiba RBTX4927 (with FPU :-)
  - Mikrotik RouterBOARD 150 (without FPU), using an older 2.6.x OpenWRT kernel

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
