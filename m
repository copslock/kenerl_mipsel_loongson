Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Dec 2010 08:19:55 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:57379 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065Ab0LQHTv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Dec 2010 08:19:51 +0100
Received: by iyj21 with SMTP id 21so264478iyj.36
        for <multiple recipients>; Thu, 16 Dec 2010 23:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0xs1W9upc+Gtd0MIvtyRg8H1x1Ws9ACVAp4yRSVVePQ=;
        b=o9ec33BnuRB99OD5lLCecZqIN05gIMzlVtgXINko1/fG7buFNVwfa9TsDHZ3XOD2iw
         svK7Jmn+ygFlC5xNpx6upwKmZ8+Dk6csbCGGNXqO7K2VAlPTLX9UI0q53897621hGKSM
         2TXVh/dlphm1zzoQYdax1GiLTvYosySWpIKIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=V4mQlv9jyU3oUjZAXkDKGW7CmA1AEm1pRm1C4dDW7aVeF85KzpdvyEcvjdYbK9dl5s
         iOpV5sXjVtB2QkoSGfb3jaxpkZGH5VfrfvyEj0huRd8Ig3KT0GOpca/go6UO1cX/utLj
         VzsJVH5sIH1cIyo2LB63X0kn7F4VkFb6dNT3I=
MIME-Version: 1.0
Received: by 10.42.180.199 with SMTP id bv7mr553134icb.119.1292570385253; Thu,
 16 Dec 2010 23:19:45 -0800 (PST)
Received: by 10.42.23.136 with HTTP; Thu, 16 Dec 2010 23:19:45 -0800 (PST)
In-Reply-To: <20101217045016.GA19218@lucon.org>
References: <20101217045016.GA19218@lucon.org>
Date:   Fri, 17 Dec 2010 15:19:45 +0800
Message-ID: <AANLkTikpVzHkVgj-L_-9FxqihKBmP-0TDXm2WZsYP6Rb@mail.gmail.com>
Subject: Re: The Linux binutils 2.21.51.0.4 is released
From:   Jeff Chua <jeff.chua.linux@gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     linux-gcc@vger.kernel.org, gcc@gcc.gnu.org,
        GNU C Library <libc-alpha@sourceware.org>,
        Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-vax@pergamentum.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <jeff.chua.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff.chua.linux@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 17, 2010 at 12:50 PM, H.J. Lu <hongjiu.lu@intel.com> wrote:
> This release fixes the Linux relocatable kernel build:
> http://sourceware.org/bugzilla/show_bug.cgi?id=12327
> 1. binutils-2.21.51.0.4.tar.bz2. Source code.
> The primary sites for the beta Linux binutils are:
> 1. http://www.kernel.org/pub/linux/devel/binutils/

Did you forget to upload it?

Thanks,
Jeff
