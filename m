Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 12:19:02 +0100 (CET)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:50427 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012212AbbA3LTAt23c7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 12:19:00 +0100
Received: by mail-wi0-f181.google.com with SMTP id fb4so2008043wid.2
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LdaF4MsnjuXi5OB63enTkONWvLW0tOidplbeZ/WP1I4=;
        b=sOY1hjjDDirv+RhSfTimjlffSZ2/etbZVVAmcIr1tU56d2bqKNZlqLChmrnj41FMXC
         OHtJeGbdNUr6KQhLtQtM+Up0WuW+LjJEs1q6Rjw1mezEpStm6/L75GKD3RC38vOPjaQl
         mdIi/JrfQ/salfOqVLlBmqlnssYGHIUtbESajE78Q7THt0XR42smoeN+SUQrWVKkT1t6
         lvt81HyEeHkIWTy8AGKBmbGPf9VhkY2blXf3kC4rsV3zy/zaCWDgPnA+PXD/oDGVL4K0
         wyrpbIRGEvQGwSxOb4e+e47PhGj95oSHmdm5219FleSvOpn3j3oqAJeYtMoTVpdVpwdD
         EQLw==
X-Received: by 10.194.76.228 with SMTP id n4mr11111976wjw.74.1422616735634;
        Fri, 30 Jan 2015 03:18:55 -0800 (PST)
Received: from localhost (port-54356.pppoe.wtnet.de. [46.59.213.2])
        by mx.google.com with ESMTPSA id j1sm14464045wjw.25.2015.01.30.03.18.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jan 2015 03:18:55 -0800 (PST)
Date:   Fri, 30 Jan 2015 12:18:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        vladimir_zapolskiy@mentor.com,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Message-ID: <20150130111853.GA32359@ulmo>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
 <54BE3369.9000802@imgtec.com>
 <54CA6089.50505@imgtec.com>
 <20150130091832.GA16744@ulmo>
 <CAL1qeaH77fJuh8fM1tKJz0bizni1sErCy=EwZTzV=EY10dX9iA@mail.gmail.com>
 <20150130102612.GE16744@ulmo>
 <CAL1qeaEen_RM8da+KU-+O26M9Z7VksWG+C=C-Oa6cAhyjiXfug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <CAL1qeaEen_RM8da+KU-+O26M9Z7VksWG+C=C-Oa6cAhyjiXfug@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 11:08:46AM +0000, Andrew Bresticker wrote:
> +linux-mips
>=20
> On Fri, Jan 30, 2015 at 10:26 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Fri, Jan 30, 2015 at 09:50:46AM +0000, Andrew Bresticker wrote:
> >> > Also you're making it especially difficult to build-test by not
> >> > providing even the basic bits of your SoC support first. All even
> >> > linux-next seems to have for the Pistachio SoC is the addition of a
> >> > compatible string to the dw-mmc driver.
> >> >
> >> > I'll take the PWM driver, but I'll assume that you'll eventually have
> >> > more pieces available, in which case I'd appreciate a note so I can
> >> > update my build scripts.
> >>
> >> FYI, I'm hoping to post Pistachio platform support for 3.21.
> >
> > That'd be great. I can switch over to a proper defconfig then and not
> > jump through extra hoops to build test patches.
> >
> > Also, I'm seeing a bunch of weird errors from building MIPS, mostly
> > things like this:
> >
> >           CC      net/ipv4/netfilter/arp_tables.mod.o
> >         {standard input}: Assembler messages:
> >         {standard input}: Warning: .gnu_attribute 4,3 requires `softflo=
at'
> >
> > or this later on:
> >
> >         mips-linux-gnu-ld: Warning: vmlinuz uses -mhard-float (set by a=
rch/mips/boot/compressed/head.o), arch/mips/boot/compressed/decompress.o us=
es -msoft-float
> >
> > This is essentially a gpr_defconfig (because it select MIPS_ALCHEMY,
> > which in turns pulls in COMMON_CLK that PWM_IMG depends on) and then
> > enabling MFD_SYSCON on top so that all dependencies are met.
> >
> > What am I doing wrong?
>=20
> What version of binutils are you using?  I believe the latter error
> should be fixed by commit 842dfc11ea9a ("MIPS: Fix build with binutils
> 2.24.51+"), but perhaps the decompressor Makefile requires a fix as
> well?  Unfortunately I'm traveling for the next couple of days, but I
> may be able to take a look at it on Monday.

I use binutils 2.25, and indeed building the correct branch gets rid of
those errors. Sorry for the noise.

Thierry

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy2idAAoJEN0jrNd/PrOhPj0P/jjwv5BjeA2bwEawIawUPAn2
8Uv3Vbvbdh9MAKwjtmqO3RMz+4Z4J+rskjjACo2mZalJHtoA3hDL799ENX25Hszp
BzgYc82vF1fY1vzKArKKO47h8j+PDH2vOuOxe6stZXn+RolihbBp/nOacjkSV3Fv
weCvQXFi1gPNFdTcjuDSK7oWkEJtj03TvvEYlr4Ve3TD7/bfSARMoP89t5enKwK9
/mPjqkvHRHiJLaA+DVFkeR7SIsZzdOSrcYJM8NOpLGEuKSPlritGtvN2XpQSOUWk
/XyzfoMApnt/051i0Zy/2kpsLLDyEq65gEL2u/qWq6Ti2xifzScggAsmBlw/ErSJ
bTXuWEDmeBIkJOhIk2WJmXt8frM9P39j+YHaWECkjPiGUx7ErMIVkPLB2OyghU7l
TsFC0H+NBWqst2/RQrKLtgF/qPe3uWyTk2Cv++4bxhO0eu6/KByycRMCSAJetIQd
NJb/nHYC7NcjJh35pMj5a/Y2LLckTMEVgzJaLIM5WSmn8m0YR52wedyV/E6Wwls0
UVpCpi1KfAeS92g6m1EmmpSqNPRzLzhnSCLe0netpkkD4mRysLtODV0mM8vfw/ZD
PYuP8fpZXNrjK6JjKhUbQSfSYNMnZTgglSjG4Q6qniS403bLSCE9cV7+HmzONL65
q0/n5U9BgrL6tvH7oQ//
=3n3v
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
