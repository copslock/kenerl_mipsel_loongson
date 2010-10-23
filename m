Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2010 02:28:30 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:55806 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491145Ab0JWA21 convert rfc822-to-8bit
        (ORCPT <rfc822;Linux-mips@linux-mips.org>);
        Sat, 23 Oct 2010 02:28:27 +0200
Received: by wwb39 with SMTP id 39so846894wwb.24
        for <Linux-mips@linux-mips.org>; Fri, 22 Oct 2010 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w0TR1Hzll/o1svRVhQt+as0icouENqwvxjQljx7Vv5k=;
        b=MUzYAHug8qeQ7EgsrIWVzJYq8g0lEYcMR6ebU00yFbrOwzSKc6Xrh01yfXqGEQFsxN
         R8vdCskWa0RA1Jsckp9sdFqHX32Bjz2c5HeOZlXBCicogArsvmcHSgjmEB0L1LP+3b6a
         LnR0MjDNpW+xAz4t8hgdh0heUnMcpzV2Y7wNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RwsmhrlnGua+CCJlMc5gGBO8828kx5EXv2JltNgU+8ZkIyrjGOUqJzSNQLFZeg1Czb
         f+YbLDAd6qefE7YaHfZxnHyMP3+1ZukoGdqftImIheuqBt2AtHdb7dfWyL2UmLjaf/2L
         gGt42Scuc97OSXlKS2NO2bhKR3lx0GPwVd4sU=
MIME-Version: 1.0
Received: by 10.216.7.210 with SMTP id 60mr144857wep.30.1287793701082; Fri, 22
 Oct 2010 17:28:21 -0700 (PDT)
Received: by 10.216.169.135 with HTTP; Fri, 22 Oct 2010 17:28:21 -0700 (PDT)
In-Reply-To: <AANLkTi=E57W_hA2Mqgf8eRHY7ukxOKKyb+r-rbFq0A-g@mail.gmail.com>
References: <AANLkTinGrdowGtdxvNp5YAFZNFkW7ZgxrP2CsYs+vWZ-@mail.gmail.com>
        <AANLkTi=E57W_hA2Mqgf8eRHY7ukxOKKyb+r-rbFq0A-g@mail.gmail.com>
Date:   Sat, 23 Oct 2010 08:28:21 +0800
Message-ID: <AANLkTikaPjTeFwGcugCAsqxoxWX4qrfQmZNrZQU1e9a3@mail.gmail.com>
Subject: Re: Evaluation boards with 74K/24k
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Anoop P A <an4linu@gmail.com>, Linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 28210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

How about this one:

800MHz 74Kf
http://www.sigmadesigns.com/uploads/documents/SMP8640_br.pdf

500MHz 24Kf
http://www.sigmadesigns.com/uploads/documents/SMP8650_br.pdf


Deng-Cheng



2010/10/23 Matt Turner <mattst88@gmail.com>:
> On Fri, Oct 22, 2010 at 1:29 PM, Anoop P A <an4linu@gmail.com> wrote:
>> Hi list,
>>
>> can anybody suggest me an eval board running 74k / 24k core.  we are
>> not much intrested in fpga solution .would be happy to see something
>> runs @ 1 Ghz
>>
>> Thanks
>> Ans
>
> Hi,
> There's the "MIPS® Linux Starter Kit" [1] that has a 680 MHz
> (overclockable to 800MHz) 24Kc CPU and 128MB RAM.
>
> I don't have one myself, so I can't comment beyond "it exists."
>
> Matt
>
> [1] http://www.mips.com/products/development-kits/linux-starter-kit/
>
>
