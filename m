Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 19:33:54 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:44095 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491141Ab0JVRdv convert rfc822-to-8bit
        (ORCPT <rfc822;Linux-mips@linux-mips.org>);
        Fri, 22 Oct 2010 19:33:51 +0200
Received: by fxm15 with SMTP id 15so147825fxm.36
        for <Linux-mips@linux-mips.org>; Fri, 22 Oct 2010 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PPl4EXRJkYiE1HSmFEWTBV3qOaV1uf8+4dP8PcsZ2mA=;
        b=jzXqGZW3qWEuy/ff0Vf8WEnqBsnJd+UuZ63awaKBVvOmAcSp4HrDTCNTZMt21b0vGK
         bGkk2lI4leUnQORgGwRSAdXkDNDQ+rAvMNJpSOZGvc+b/uhu1dw5hJqsD3BHn3MVFw2W
         928ua9tLImjvyhJZuAW4+EDgwoaoW6pCek7yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HMmuGT15lKSH72COTZY7Rcwu8/rEEji7BfDbbn1hIE2DVvlhXCWPZWe0yOwja7Zmf0
         X8aUfId1Dd87TiwWCzIhXSHXdne1ctJQN3356aewjywq28WKEcXwyNi9eAVabQ+aa2R+
         03Tdm4bhbWN60a3LELPPt+mRoKEnQiVAlm2kk=
Received: by 10.204.121.84 with SMTP id g20mr1374314bkr.37.1287768826131; Fri,
 22 Oct 2010 10:33:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.204.47.147 with HTTP; Fri, 22 Oct 2010 10:33:25 -0700 (PDT)
In-Reply-To: <AANLkTinGrdowGtdxvNp5YAFZNFkW7ZgxrP2CsYs+vWZ-@mail.gmail.com>
References: <AANLkTinGrdowGtdxvNp5YAFZNFkW7ZgxrP2CsYs+vWZ-@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 22 Oct 2010 13:33:25 -0400
Message-ID: <AANLkTi=E57W_hA2Mqgf8eRHY7ukxOKKyb+r-rbFq0A-g@mail.gmail.com>
Subject: Re: Evaluation boards with 74K/24k
To:     Anoop P A <an4linu@gmail.com>
Cc:     Linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 28200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 22, 2010 at 1:29 PM, Anoop P A <an4linu@gmail.com> wrote:
> Hi list,
>
> can anybody suggest me an eval board running 74k / 24k core.  we are
> not much intrested in fpga solution .would be happy to see something
> runs @ 1 Ghz
>
> Thanks
> Ans

Hi,
There's the "MIPS® Linux Starter Kit" [1] that has a 680 MHz
(overclockable to 800MHz) 24Kc CPU and 128MB RAM.

I don't have one myself, so I can't comment beyond "it exists."

Matt

[1] http://www.mips.com/products/development-kits/linux-starter-kit/
