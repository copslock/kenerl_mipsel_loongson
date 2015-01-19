Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 08:09:22 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:64111 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011002AbbASHJVD56lw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 08:09:21 +0100
Received: by mail-wg0-f45.google.com with SMTP id y19so30059540wgg.4
        for <linux-mips@linux-mips.org>; Sun, 18 Jan 2015 23:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ojm/ju8grTaFqYVJJ5m1/eguvqrrsdABeNU6OUm4g1g=;
        b=F5c0yNleqvQja00k3gN0syoRv2rX6CqABuI/N2xN1rDRrnCe65O5tJlELy6Dn+32NU
         evHJIzBS3lYvy2DdZbmvlVE8zRD31PuWeQbV6EnyKdBYrBo/Fj2Cx4ot+qT1uthUnT8W
         6VWQAt4vDCP2QPfk79vmpj/sTYVmSEzaBgEmW8JP1MC2RvgkCMHwpuvLOyrQu57vOpHq
         6t2HhegOCt8dgeWIZJyFJhnB4tsqPEGTe9yPyj03BkyIi+nLOjqeDlto/IA6GA+vagmy
         Tur58aM3uNnWK/9F7kVRtI2yO7NP4Uey7eXF1msB0VrkZfHoK9FKStSRRTL1vtiRzrTS
         9ogA==
X-Received: by 10.194.234.2 with SMTP id ua2mr20951717wjc.40.1421651355883;
 Sun, 18 Jan 2015 23:09:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.105.144 with HTTP; Sun, 18 Jan 2015 23:08:35 -0800 (PST)
In-Reply-To: <1421645476-13532-1-git-send-email-paul.burton@imgtec.com>
References: <1421645476-13532-1-git-send-email-paul.burton@imgtec.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 19 Jan 2015 08:08:35 +0100
Message-ID: <CAOLZvyGqk4cuZTbeqwYAr2aFw69k6xTuRK7R+MGpJX6HDreAhA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: bypass FP mode checks when CONFIG_MIPS_O32_FP64_SUPPORT==n
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Jan 19, 2015 at 6:31 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> The FP mode checks introduced to support the FP modes indicated by the
> new PT_MIPS_ABIFLAGS program header & .MIPS.abiflags section have been
> found to cause some compatibility issues when mixing binaries with such
> mode information & an ELF interpreter without it, or vice-versa[1]. The
> mode checks serve little purpose unless the kernel actually supports the
> FP64 modes as indicated by CONFIG_MIPS_O32_FP64_SUPPORT, which currently
> defaults to disabled & is marked experimental. Bypass the mode checks
> when the FP64 support is disabled in order to avoid compatibility issues
> with v3.19 until the logic is fixed.
>
> [1]: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00279.html
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>

Tested-by: Manuel Lauss <manuel.lauss@gmail.com>

Fixes my soft-float userspace issue.

Thanks Paul!

     Manuel
