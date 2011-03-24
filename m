Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 10:28:08 +0100 (CET)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:60097 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491045Ab1CXJ2F convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Mar 2011 10:28:05 +0100
Received: by wwi18 with SMTP id 18so6678561wwi.0
        for <linux-mips@linux-mips.org>; Thu, 24 Mar 2011 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=85Yu3+83TSZsUS7/3Y6B5V2Pqq094w0YX60AddR64Mo=;
        b=GEUNQyEGxPXXBLgxo7Dn5K5VBEp/N3Y58V3jvrZdYTMFXXZyC0+KfjQyMy6ElYQEcf
         b5ZclzxnnQl4WCM4KDL2BQ7AKMhgawiSoqn8yGerrv+uB0TTNCn1Tew8E37q2rkfXOCm
         88P8e087qxTKJRBmvXfhDqqprE+SXWyVKGA7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AwzWzevY7RKaCsOFcZaM+myobOMW1Ovfcz3EtCg4cWCb1kQE+ll6WBgweszejyYz72
         n6y99LKeVaLI/7UoSEZjHi+VxshFuvNDbgexpU/g+hRtbzB8oaVRc1JBV/DdqvOXk0dn
         7gGrFsFvA1jj8j4Fc9p515CEmqTWWWDLW+rVU=
MIME-Version: 1.0
Received: by 10.216.254.39 with SMTP id g39mr6822373wes.108.1300958879902;
 Thu, 24 Mar 2011 02:27:59 -0700 (PDT)
Received: by 10.216.172.72 with HTTP; Thu, 24 Mar 2011 02:27:59 -0700 (PDT)
In-Reply-To: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
Date:   Thu, 24 Mar 2011 11:27:59 +0200
X-Google-Sender-Auth: BOc2EWpaREj4kO9KqMW76MTZL7E
Message-ID: <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Daniel Baluta <dbaluta@ixiacom.com>
To:     naveen yadav <yad.naveen@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <daniel.baluta@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dbaluta@ixiacom.com
Precedence: bulk
X-list: linux-mips

> I want to check kmemleak for both ARM/MIPS. i am able to find kernel
> patch for ARM at
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-04/msg11830.html.
> But I could not able to trace patch for MIPS.

It seems that kmemleak is not supported on MIPS.

According to 'depends on' config entry it is supported on:
x86, arm, ppc, s390, sparc64, superh, microblaze and tile.

Cătălin, can you confirm this? I will send a patch to update
Documentation/kmemleak.txt.

Also, looking forward to work on making kmemleak available on MIPS.

thanks,
Daniel.
