Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 21:42:21 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:40795 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492655Ab0EDTa0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 21:30:26 +0200
Received: by fxm17 with SMTP id 17so3384724fxm.36
        for <multiple recipients>; Tue, 04 May 2010 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YwN/iRmqlQBB529NSRsACEofVTOtdPct2yos23QS+3o=;
        b=hU6EJn2VIZ+kd1z3VB0IIOtfWfWmvbIhc3IOPiwzb34Gr8OxWDwiUu/GlvroFp1PrH
         AdZSMkPW6niMuS9Q3qUvN4nM4uMIa2ccwRr3UR1fFPLm6SuzSccVEruzb+xOIH13MUFv
         zM+ecRFqt9C3SBjz9J1QH5mrRIeV3HaEA583Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NZINp62MQJTyht6bOpdU56F1RWNYGEEkb9/so3kWcBKNEX7mLb7ieu2OmFXXFPcyWD
         o8xiK7MDvMR1YIVhsGL6U/el1fXxdR+JZUrmzrJMyf9C0lIYplISdGHEJCzavzdZC7sK
         ralm+/SypRNKhCw5OBCqt0RlL2WIsKTWtjOOw=
MIME-Version: 1.0
Received: by 10.223.5.13 with SMTP id 13mr4529691fat.68.1273001420361; Tue, 04 
        May 2010 12:30:20 -0700 (PDT)
Received: by 10.223.106.12 with HTTP; Tue, 4 May 2010 12:30:20 -0700 (PDT)
In-Reply-To: <k2s10f740e81005041228pea323400u89dfcefd4a5047d0@mail.gmail.com>
References: <E1O8lDn-0000Sk-86@localhost> <4BDF8092.1060401@paralogos.com>
         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
         <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
         <4BE00207.6030506@paralogos.com>
         <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>
         <4BE0479E.6060506@paralogos.com>
         <20100504184457.GA21929@linux-mips.org>
         <k2s10f740e81005041228pea323400u89dfcefd4a5047d0@mail.gmail.com>
Date:   Tue, 4 May 2010 21:30:20 +0200
Message-ID: <h2yf861ec6f1005041230p80a664e6o51296c106853d3fc@mail.gmail.com>
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26585
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, May 4, 2010 at 9:28 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, May 4, 2010 at 20:44, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Tue, May 04, 2010 at 09:13:18AM -0700, Kevin D. Kissell wrote:
>>
>>> What we used to use was what I *thought* was an old public domain
>>> program whose name was an English word that had something to do with
>>> being exacting.  Googling with obvious keywords didn't turn it up.
>>
>> Is it paranoia by any chance?  Paranoia is available as single files at:
>>
>>  http://www.math.utah.edu/~beebe/software/ieee/paranoia.c
>>  http://www.math.utah.edu/~beebe/software/ieee/paranoia.h
>
> You also need
>
> http://www.math.utah.edu/~beebe/software/ieee/args.h
>
> Ran fine on:
>  - Toshiba RBTX4927 (with FPU :-)
>  - Mikrotik RouterBOARD 150 (without FPU), using an older 2.6.x OpenWRT kernel

and runs into an endless loop around line 806 when built with
a softfloat toolchain (gcc-4.4.3).

Manuel
