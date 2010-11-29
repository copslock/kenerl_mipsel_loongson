Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2010 07:07:49 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:54385 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491762Ab0K2GHm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Nov 2010 07:07:42 +0100
Received: by iwn36 with SMTP id 36so3806476iwn.36
        for <linux-mips@linux-mips.org>; Sun, 28 Nov 2010 22:07:41 -0800 (PST)
Received: by 10.231.32.197 with SMTP id e5mr1322727ibd.188.1291010861003; Sun,
 28 Nov 2010 22:07:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.231.196.10 with HTTP; Sun, 28 Nov 2010 22:07:20 -0800 (PST)
In-Reply-To: <20101129055529.GB17113@yookeroo>
References: <1290607413.12457.44.camel@concordia> <1290692075.689.20.camel@concordia>
 <20101129055529.GB17113@yookeroo>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Sun, 28 Nov 2010 23:07:20 -0700
X-Google-Sender-Auth: 5ZNSIXdbI5HOuG5KI0gVD2MP83w
Message-ID: <AANLkTi=KBsMDvG2wZDu6ZtctWzd_bdQ=tO97eZu1R+VL@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
To:     Michael Ellerman <michael@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Sun, Nov 28, 2010 at 10:55 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Fri, Nov 26, 2010 at 12:34:35AM +1100, Michael Ellerman wrote:
>> Most of these are straight renames, but some have changed more
>> substantially. The routines for the flat tree have all become fdt_foo().
>
> I'm a little uneasy about using the same prefix as libfdt (fdt_foo())
> for routines that have a different implementation and different names
> / semantics to the libfdt routines.

I'd also be okay with either dtflat_ or flatdt_ for the prefix on
these routines.

g.
