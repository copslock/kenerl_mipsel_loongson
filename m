Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 12:45:49 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:49284 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492507Ab0CILpq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Mar 2010 12:45:46 +0100
Received: by fxm27 with SMTP id 27so2641296fxm.28
        for <linux-mips@linux-mips.org>; Tue, 09 Mar 2010 03:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0/N+Q0B8tVce6yQ+0StSKlNCRx/z3hPiNFtXgXL4BWI=;
        b=TtvbrAVsiZVH0jqm7pPojwDUn9jBu8Ml9IPH5d/ez8klTXPFiU+h6B0so5jPimx3pT
         2Cd34CULaVredJWeaPB4PS+qfOGC2mavjN7Wv6+zicKhqcAcCpJiISjoYdxOOHykh+2R
         5/My8lfORRzt7bGYl7XLyBLPQW0KDVzCXxM7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q5Dlj4uGN6i0mDML2vJlUCkwcqsewVgaslPJBBzz/zoAxMdC+HMBtVErzuRNDPsU3W
         z7/UjkOrUHmysL4CyN55IPQ3yXpJERqaoPdygrWMVewaQIDPVunq/JaBXGKjEW9nBazu
         C1LBC5TUaNHdCLl8hPpJW0EtG2Ux+bvKIcGrg=
MIME-Version: 1.0
Received: by 10.223.63.208 with SMTP id c16mr5274178fai.29.1268135140086; Tue, 
        09 Mar 2010 03:45:40 -0800 (PST)
In-Reply-To: <4B963210.7030906@ru.mvista.com>
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
         <1268076181-29642-3-git-send-email-manuel.lauss@gmail.com>
         <4B963210.7030906@ru.mvista.com>
Date:   Tue, 9 Mar 2010 12:45:39 +0100
Message-ID: <f861ec6f1003090345n53570102je68aef14e8b3f3fb@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: move MMC driver registration to board 
        code.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 9, 2010 at 12:33 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> Manuel Lauss wrote:
>
>> Where it really belongs to.
>>
>
>  I disagree (again). SoC platform devices dont belong with the board code.

Figured as much.  However with additional boards the #ifdef mess in
common/platform.c
is only going to get worse. MUCH worse. Just look at the au1000-eth
platform data situation!
I have these platform devices on Au1200/Au1300 even thought they don't have
a built-in MAC.

The board which uses the device should register it.  The UARTs are
kind of a special
case since they need to be fixed up with the correct busclock, but
that too could be
exported to an initialization wrapper.

But, consider the patch withdrawn.

Manuel
