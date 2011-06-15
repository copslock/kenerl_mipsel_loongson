Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 10:03:04 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:59340 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490982Ab1FOIDB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 10:03:01 +0200
Received: by qyk32 with SMTP id 32so2095458qyk.15
        for <multiple recipients>; Wed, 15 Jun 2011 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gVQUE4oX+uQMW5TLRGECkxA7/PzcUWpK4LvmRETvGtQ=;
        b=n+mA4vvsdzLV/ei2iYXecq7Zp9onOwEAYT5AF1tIM/axCcywKKRTMv5etvQK4qWJF0
         3tjvnHnillrTlGzvZEsGMEgae6U2xhmsfTCdG46zeSisBxCVpGMEHb9Kzp0f42oBGubL
         rrTkGyx6KLkP8h+spq9/Q/04w0X4Sz5QoBR3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uPVw/oXJvLbULUtBD6fdjAxgwbk785UTYVau9WpB7GIRu4xrx6dPr+VvILWzPenWof
         LtdHVG7WeEymvDcNO4S1GNfs2d/49UnmEabE58gdvdq2Hh88EYHEYtL4pwtP+2GWaBmA
         ztiYbzL76iApg7EE5GVGhAmWp4h66thKKE0mU=
MIME-Version: 1.0
Received: by 10.229.10.209 with SMTP id q17mr141368qcq.106.1308124973614; Wed,
 15 Jun 2011 01:02:53 -0700 (PDT)
Received: by 10.229.217.201 with HTTP; Wed, 15 Jun 2011 01:02:53 -0700 (PDT)
In-Reply-To: <201106142222.43553.arnd@arndb.de>
References: <20110614190850.GA13526@linux-mips.org>
        <201106142222.43553.arnd@arndb.de>
Date:   Wed, 15 Jun 2011 16:02:53 +0800
Message-ID: <BANLkTikpax09bQqwuP1dJYRtSO+c0DdUgg@mail.gmail.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
From:   Lennox Wu <lennox.wu@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev@lists.ozlabs.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Mikael Starvik <starvik@axis.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-sh@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary=0016364ecb745fc9a204a5bb94b9
X-archive-position: 30399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lennox.wu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12155

--0016364ecb745fc9a204a5bb94b9
Content-Type: text/plain; charset=ISO-8859-1

2011/6/15 Arnd Bergmann <arnd@arndb.de>
>
> >  config SCORE
> > -       def_bool y
> > -       select HAVE_GENERIC_HARDIRQS
> > -       select GENERIC_IRQ_SHOW
> > +     def_bool y
> > +     select HAVE_GENERIC_HARDIRQS
> > +     select HAVE_PC_PARPORT
> > +     select GENERIC_IRQ_SHOW
> >
> >  choice
> >       prompt "System type"
>
> Certainly not, no PIO support
>
>  Yes, there is no platform of the Score supports PIO.
Best,
Lennox

--0016364ecb745fc9a204a5bb94b9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/6/15 Arnd Bergmann <span dir=3D"ltr=
">&lt;<a href=3D"mailto:arnd@arndb.de">arnd@arndb.de</a>&gt;</span><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex;">
<div class=3D"im">
&gt; =A0config SCORE<br>
&gt; - =A0 =A0 =A0 def_bool y<br>
&gt; - =A0 =A0 =A0 select HAVE_GENERIC_HARDIRQS<br>
&gt; - =A0 =A0 =A0 select GENERIC_IRQ_SHOW<br>
&gt; + =A0 =A0 def_bool y<br>
&gt; + =A0 =A0 select HAVE_GENERIC_HARDIRQS<br>
&gt; + =A0 =A0 select HAVE_PC_PARPORT<br>
&gt; + =A0 =A0 select GENERIC_IRQ_SHOW<br>
&gt;<br>
&gt; =A0choice<br>
&gt; =A0 =A0 =A0 prompt &quot;System type&quot;<br>
<br>
</div>Certainly not, no PIO support<br>
<div class=3D"im"><br></div></blockquote><div>=A0Yes, there is no platform =
of the Score supports PIO.</div><div>Best,</div><div>Lennox</div></div>

--0016364ecb745fc9a204a5bb94b9--
