Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 00:40:21 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:36439
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990468AbeECWkO1P02v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 00:40:14 +0200
Received: by mail-qt0-x244.google.com with SMTP id q6-v6so25104869qtn.3;
        Thu, 03 May 2018 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PKnXhs05Z/cvp+tdY8NqgifaWSZch/rtjwbGXZNtkFw=;
        b=r087GcyMbxDpe2Bg+MzpaXIA0nfXHpbGt2zViOtgJl+mhM8GViuSKDVpoHFxM5iDNO
         ti9eTsVc9FciW4cSNJGRk465SZRkG29cN8O4ULaoeoM9l+2tebRE7s5MuZhlBM5ehVx9
         ZoPxsfDt1PAiiQB2wXHWv4kWXrrcP41Oikaz7jgQQ12IBFlHPDgMeWfR970yKrhg2cgY
         5kf3psK8b3n96/85kaJABPEKpT8ORFfvIOvfIFCPfsr35R4PrfQq3tfb0V+Za7iuyJ/r
         +MFezGgKeskWdoTnK6sPheyC/aA1jLekLoAMEZwmKM3ho/ln2ZeBLLgj882TqICydlAH
         +6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PKnXhs05Z/cvp+tdY8NqgifaWSZch/rtjwbGXZNtkFw=;
        b=A2YY4k/n53mUreOmk0PnGFduWbXAK7oBIA73rPtsCOunfanMiIuA6AYJjCWpc0w3uB
         TPb5nKylvBtWGYo17pv3iWA2bEuy8EfRyoC6MPFpVbzSDcfUzaiDzYekfHpL1K+IQATB
         YRl1LNA4fEHTPvkj+ZsOjCMqmnduFZgSgUNhoOdlDknfocNt05lGOLpDx3/UPsc644qM
         klIBUSelBPFeW7qOZazvmKdVbhLuA6us91zsxpE+uwW0MYMWAmVNZAiLHyYDL6J41oGz
         7evmxguSS6eCWKGkF3a1QnPymjb6+Zkq7fpbPQGt4tquAfxcU6FEQ1hrJz9ekmWFDSFh
         kGvA==
X-Gm-Message-State: ALQs6tDcugbae6QRou8haDoeTz10/JjR//SA9atmhuH/ZmeFi/n3UHDa
        4ad59bV1xABieuF9+Am/aYjj3w7qMA6kmBNqOEs=
X-Google-Smtp-Source: AB8JxZpwC/dbzbv3DiguOedF1ndr0K3sl6t/LOnYqxFG2v7dTrICbkzY6CLxVxE575Yui8Y1C38uyo5LbEeiTOIP4DU=
X-Received: by 2002:ac8:1c12:: with SMTP id a18-v6mr22314023qtk.280.1525387208210;
 Thu, 03 May 2018 15:40:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.3 with HTTP; Thu, 3 May 2018 15:40:07 -0700 (PDT)
In-Reply-To: <20180502215107.GA9884@saruman>
References: <20180502215107.GA9884@saruman>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 3 May 2018 18:40:07 -0400
X-Google-Sender-Auth: zGWEe4vkoxJ789wYH7_oUbrkXyI
Message-ID: <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
Subject: Re: Introducing a nanoMIPS port for Linux
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Matthew Fortune <Matthew.Fortune@mips.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:

> Due to the binary incompatibility between previous MIPS architecture
> generations and nanoMIPS, and the significantly revamped compiler ABI,
> where for the first time, a single Linux kernel would not be expected to
> handle both old and new ABIs, we have decided to also take the
> opportunity to modernise the Linux user ABI for nanoMIPS, making as much
> use of generic interfaces as possible and modernising the true
> architecture specific parts.
>
> This is similar to what a whole new kernel architecture would be
> expected to adopt, but has been done within the existing MIPS
> architecture port to allow reuse of the existing MIPS code, most of
> which does not depend on these ABI specifics. Details of the proposed
> Linux user ABI changes for nanoMIPS can be found here:

While I haven't looked at the individual changes, I wonder whether
it would be useful to make this new ABI use 64-bit time_t from
the start, using the new system calls that Deepa and I have been
posting recently. There are still a few things to be worked out:
only the first of four sets of syscall patches is merged so far,
and we have a couple of areas that will require further ABI changes
(sound, sockets, media and maybe a couple of smaller drivers),
so it depends on the overall timing. If you would otherwise merge
the patches quickly, then it may be better to just follow the existing
32-bit architectures and add the 64-bit entry points when we do it
for everyone.

         Arnd
