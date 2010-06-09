Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:47:43 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:46340 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab0FILrg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:47:36 +0200
Received: by iwn34 with SMTP id 34so6492837iwn.36
        for <multiple recipients>; Wed, 09 Jun 2010 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=lDIBrE8CzCQzWP2RmuQogKNhBGw8RqjE3Z0JVXnxZ/0=;
        b=YO9NPxa6+IKrna0hl1aM9WPga1L7zbjD8rkCiZl9/cQFEtRUc7ywcScakmyD3andA3
         cWGQQZoVOtVZu9S5OlvAfrkqX6l49F7siwS22oHx6qNg3tA+PJbDKnarryARo9nIVJ2c
         Arf9hBnM79QENj5xZHIknqPITv8LilJoUtjy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R31TXdyvZS88J77bTXoLhngS+5I9fakit8CrjqQzvTCcR2Rgk/IUFXtutjVYbhPeTE
         hjxIfkiC/TvimljDHFh+3DSr855Clwl8LHKXKp+tVryAfnspiDz3qTUD5lvN2hf2Ct1e
         EIM2KRfkBOMxMfUvI85o6QnX2YggbKTLGfUIM=
MIME-Version: 1.0
Received: by 10.42.3.135 with SMTP id 7mr7178316ico.21.1276084053604; Wed, 09 
        Jun 2010 04:47:33 -0700 (PDT)
Received: by 10.231.183.74 with HTTP; Wed, 9 Jun 2010 04:47:33 -0700 (PDT)
In-Reply-To: <e58860bae0d4571f3932df24fb6db0757bc260fe.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
        <e58860bae0d4571f3932df24fb6db0757bc260fe.1275925108.git.siccegge@cs.fau.de>
Date:   Wed, 9 Jun 2010 13:47:33 +0200
Message-ID: <AANLkTind_RjQ5X2zR1fhTgKuLOU4Kbve3uQlgGMI559X@mail.gmail.com>
Subject: Re: [PATCH 6/9] Removing dead CONFIG_I2C_PNX0105
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6362

On Wed, Jun 9, 2010 at 1:22 PM, Christoph Egger <siccegge@cs.fau.de> wrote:
> CONFIG_I2C_PNX0105 doesn't exist in Kconfig, therefore removing all
> references for it from the source code.

The code should probably just be adjusted to use the i2c-pnx driver.  According
to the comments it supports the pnx0105 i2c cell.

Manuel
