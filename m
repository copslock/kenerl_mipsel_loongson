Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 06:41:42 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:62713 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFEli convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 06:41:38 +0200
Received: by pwi8 with SMTP id 8so2729827pwi.36
        for <multiple recipients>; Sun, 05 Jun 2011 21:41:30 -0700 (PDT)
Received: by 10.68.14.167 with SMTP id q7mr1650199pbc.430.1307335290052; Sun,
 05 Jun 2011 21:41:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.65.134 with HTTP; Sun, 5 Jun 2011 21:41:10 -0700 (PDT)
In-Reply-To: <20110606010753.GA16202@linux-mips.org>
References: <20110606010753.GA16202@linux-mips.org>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Sun, 5 Jun 2011 22:41:10 -0600
X-Google-Sender-Auth: EEV9vv6Et-Dj72jRVy7R_q2-bos
Message-ID: <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com>
Subject: Re: Converting MIPS to Device Tree
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Dezhong Diao <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3817

On Sun, Jun 5, 2011 at 7:07 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Over the past few days I've started to convert arch/mips to use DT.

Nice!

>  So
> far none of the platforms (except maybe PowerTV?) seems to have a
> firmware that is passing a DT nor is there any 2nd stage bootloader that
> could do so.

FWIW, U-Boot now has pretty generic support for manipulating and
passing a dtb at boot.  That doesn't do much good for existing
deployed systems though.

> So as the 2nd best thing I've been working on .dts files to be compiled
> into the images.
>
> I've put a git tree of my current working tree online.  It's absolutely
> work in progress so expect to encounter bugs.
>
>  http://git.linux-mips.org/?p=linux-dt.git;a=summary (Gitweb)
>  git://git.linux-mips.org/linux-dt.git
>  http://www.linux-mips.org/wiki/Device_Tree (brief documentation & links)
>
> An incomplete to do list:
>
>  o Sort out interface for firmware to pass a DT to the kernel.  Because we
>    have so many different firmware implementations this one might get a
>    slight bit interesting.

I strongly recommend defining a single method for passing the DT here.
 If firmware is being modified anyway to add DT support, then may as
well get everyone to conform to the same interface.  Things do get
really hairy if you try to pass the DT inside a legacy firmware
interface and then try to figure out which data is authoritative; the
dtb or the legacy data.  DT boot can even be made a different boot
mode for the firmware.  This is effectively what U-Boot has done.
Either you boot without DT, using the legacy interface, or you boot
with DT using a new *and common* DT boot interface.

>  o Interface to select one of several builtin DT images.  I am thinking of
>    extending the existing MIPS_MACHINE() / machtype mechanism to play
>    nicely with DT.

I'm toying with this idea on arm too with the machine_desc structure,
but it is looking more likely that ARM is going to support DT on older
non-DT firmware by appending the .dtb blob to the zImage, and getting
the wrapper to handle fixing up the boot interface.  There are patches
on the list for this, but they need one more going over before they
get committed.

>  o Finish and test AR7, Cobalt, Jazz, Malta, MIPSsim and SNI ports.
>  o Convert the remaining platforms; find if it's actually sensible to
>    convert all platforms.
>  o I'm considering to make DT support a requirement for future MIPS
>    platforms so you might as well start beating your firmware monkeys /
>    ask Santa to put you a shiny new bootloader blob into the boot now.
>  o Write more of the required infrastructure.
>  o Write documentation
>
> Contributions and comments welcome,

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
