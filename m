Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 16:39:53 +0200 (CEST)
Received: from mail-yk0-f174.google.com ([209.85.160.174]:41759 "EHLO
        mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6901529AbaHNOjoEcLq3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2014 16:39:44 +0200
Received: by mail-yk0-f174.google.com with SMTP id q9so1011270ykb.5
        for <multiple recipients>; Thu, 14 Aug 2014 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EE5Auwnh4VxN869sjdRLnCFVwrmAiPlLRn6Z1a4iZRI=;
        b=F/n+JoUfYpbVsLo8QXZ5b/h9fGyfHMul9ja5dTdq0UMRfDeN3HZzuNALohBu2GHEsH
         mBr9eN28WZnsKAqtJT5bzmbH1CVXr91VcxdbY6oB34y8dKnUWYzzPrCTCCfoaHQCO8IZ
         ClFs5bvcomgGLvAFxGaYyCiD0cDsUEBtdGP/DYS2szitJyNLhA4r7lOl8UNYFrH/t5G4
         RUUcuvqcbe7Rww0gi0aqZzcusEuWGamhQsRntwtc8sGTHAzaWg09GZULX0GdvVY9bH2r
         861x5HvArmotyoue3ReqVVv7VEHJ4rUmkJHn2ipHdgJefSr9sLjQ5u4+Rh37LGsKdmZG
         IYzA==
X-Received: by 10.236.139.2 with SMTP id b2mr16149144yhj.125.1408027177645;
 Thu, 14 Aug 2014 07:39:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.147.87 with HTTP; Thu, 14 Aug 2014 07:39:17 -0700 (PDT)
In-Reply-To: <20140814124652.GE21008@linux-mips.org>
References: <1407967776-7320-1-git-send-email-ryazanov.s.a@gmail.com>
 <1407967776-7320-2-git-send-email-ryazanov.s.a@gmail.com> <20140814124652.GE21008@linux-mips.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Thu, 14 Aug 2014 18:39:17 +0400
Message-ID: <CAHNKnsQ2DcqG3ABGPj=2bLY74XRxouPkFLqGFbZ9MBnQDPfsVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: MSP71xx: remove unused plat_irq_dispatch() argument
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42097
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

2014-08-14 16:46 GMT+04:00 Ralf Baechle <ralf@linux-mips.org>:
> On Thu, Aug 14, 2014 at 02:09:35AM +0400, Sergey Ryazanov wrote:
>
>> Remove unused argument to make the plat_irq_dispatch() function
>> declaration similar to the realization of other platforms.
>
> The issue may be harmless but the regs argument of the false argument
> isn't even being passed in!
>
IMHO, this argument can't cause smth terrible, until nobody tries to
access it, but I can mistake.

-- 
Sergey
