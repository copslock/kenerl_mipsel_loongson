Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:31:38 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:50021 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491967Ab0GWRbe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:31:34 +0200
Received: by iwn40 with SMTP id 40so455307iwn.36
        for <multiple recipients>; Fri, 23 Jul 2010 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bFHoxsvORXizc2jFnH09Z94WARxVp1J+a/sVj03JI0c=;
        b=CR25wj1v7JZY4+w49CFK1osdG3RH+nvKsCUVRSMoytzZQ8GvlNI57nUxyL8NFD0VwM
         BlhSSqxPI5O6vUw4isX7oKR1DanmuoI9/88ZrsWkqylRSb/KxyuRwS+mURBD75ffhXFP
         6JWxtkSAAj8Tb53wZZRnyLDip5c6mOiABbNfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x8wDihnr5QTuf3sBFcZ0P5i+7DiJ6o4b3QwxE0QSzacxFj/d83Ad1U/lm00eqmb0KU
         rVK7RVc3Lu/g11ywtrHblm7ADhRlKjY/D6KAvck543mpyz1odc2gEjUmvZRD3pNy2eBg
         M/d6mo0OjrA7JTrjqKIGMnOALLplqxQlVcvMI=
MIME-Version: 1.0
Received: by 10.231.190.149 with SMTP id di21mr3947954ibb.27.1279906292736; 
        Fri, 23 Jul 2010 10:31:32 -0700 (PDT)
Received: by 10.231.59.10 with HTTP; Fri, 23 Jul 2010 10:31:32 -0700 (PDT)
In-Reply-To: <20100723170205.GB3923@linux-mips.org>
References: <1279223105-23816-1-git-send-email-manuel.lauss@googlemail.com>
        <1279223105-23816-2-git-send-email-manuel.lauss@googlemail.com>
        <20100723170205.GB3923@linux-mips.org>
Date:   Fri, 23 Jul 2010 19:31:32 +0200
Message-ID: <AANLkTikG_FCh6DgX1Wwn7o6b2+uBRQz9F6JX=vjzba2k@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250: remove SERIAL_8250_AU1X00
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Fri, Jul 23, 2010 at 7:02 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jul 15, 2010 at 09:45:05PM +0200, Manuel Lauss wrote:
>
> Thanks, queued for 2.6.36.
>
> It's probably harmless but there was a fairly large line offset in
> arch/mips/alchemy/common/platform.c so you may want to check that what I
> queued is ok.

It's ok, the offset comes from a few pm-related patches I usually work with.

Thank you!
        Manuel
