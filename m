Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2011 02:41:12 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:60732 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491956Ab1F1AlD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jun 2011 02:41:03 +0200
Received: by iyn15 with SMTP id 15so5571085iyn.36
        for <multiple recipients>; Mon, 27 Jun 2011 17:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b7deloBv6q06do+Zd75oViHSx2ai6dBhFehEMyHCJVw=;
        b=i8tDfsONQQKqHEH6pqGDQp8u+8FtlBqd30sOXJF3JFvyliJFvToFDw3dyGPoAEM4c6
         Px+OV58O69oUqIasJ0JtYq1si0MB3Rhc92tGxBjcIkpEpThSObYSI/WEAseW9ctIYdDv
         dFnp6k1AYxShav6T1itMdVu/bG+HXyQ3FJduc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f96W5RMnLBZPEeOENA3b9Gc8kRfjNnDIQVDsxAKrFj4rBu82kk1tzfCAMxhU9khTsT
         sJDXJ8hVUOQrp4hDWn47HbqeZPJ17AYHPNW99b53SMsy1/FoozlKvUFecF480cw2XHbQ
         GrdyLFWWif8Uro56OonyptVy+/AusrYQgNX50=
MIME-Version: 1.0
Received: by 10.231.141.20 with SMTP id k20mr5292343ibu.132.1309221656937;
 Mon, 27 Jun 2011 17:40:56 -0700 (PDT)
Received: by 10.231.34.70 with HTTP; Mon, 27 Jun 2011 17:40:56 -0700 (PDT)
In-Reply-To: <20110627111259.GA13620@linux-mips.org>
References: <20110627111259.GA13620@linux-mips.org>
Date:   Tue, 28 Jun 2011 09:40:56 +0900
Message-ID: <BANLkTikDxsOJKpiJs0NpMXbjVOFMHL7RZw@mail.gmail.com>
Subject: Re: [PATCH v2] NET: AX88796: Tighten up Kconfig dependencies
From:   Magnus Damm <magnus.damm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ben Dooks <ben-linux@fluff.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Garzik <jeff@garzik.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: magnus.damm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22415

Hi Ralf,

On Mon, Jun 27, 2011 at 8:13 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> In def47c5095d53814512bb0c62ec02dfdec769db1 [[netdrvr] Fix dependencies for
> ax88796 ne2k clone driver] the AX88796 driver got restricted to just be
> build for ARM and MIPS on the sole merrit that it was written for some ARM
> sytems and the driver had the misfortune to just build on MIPS, so MIPS was
> throw into the dependency for a good measure.  Later
> 8687991a734a67f1638782c968f46fff0f94bb1f [ax88796: add superh to kconfig
> dependencies] added SH but only one in-tree SH system actually has an
> AX88796.
>
> Tighten up dependencies by using an auxilliary config sysmbol
> HAS_NET_AX88796 which is selected only by the platforms that actually
> have or may have an AX88796.  This also means the driver won't be built
> anymore for any MIPS platform.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
> v2: fixed Sergei's complaints about the log message

I'm the one who added the SuperH bits a few years ago. Judging by the
text above it seems like you prefer not to build this driver for MIPS.
Which is totally fine with me.

As for SH and SH-Mobile ARM, unless explicitly requested we usually
don't restrict our platform drivers. Allowing them to build on any
system helps to catch compile errors. It also makes it possible to add
board support by simply adding platform data to the board file and
then updating the kconfig. Keeping the amount of code at the bare
minimum makes back porting rather easy too.

I'm not sure if the ax88796 driver does something non-standard to
require special symbols, but usually platform drivers are rather clean
and can be compiled for any architecture or platform. At least in
theory. =)

Cheers,

/ magnus
