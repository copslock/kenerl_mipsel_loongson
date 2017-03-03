Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2017 01:21:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24313 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993876AbdCCAVfd13C8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Mar 2017 01:21:35 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1633F41F8D9A;
        Fri,  3 Mar 2017 01:26:12 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 03 Mar 2017 01:26:12 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 03 Mar 2017 01:26:12 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 60C245737FDED;
        Fri,  3 Mar 2017 00:21:25 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 3 Mar
 2017 00:21:29 +0000
Date:   Fri, 3 Mar 2017 00:21:29 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jason Uy <jason.uy@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Noam Camus <noamc@ezchip.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wang Hongcheng <annie.wang@amd.com>,
        <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-clk@vger.kernel.org>, Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control to
 be used
Message-ID: <20170303002129.GS996@jhogan-linux.le.imgtec.org>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
 <1484164100-9805-2-git-send-email-jason.uy@broadcom.com>
 <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
 <1488394220.20145.68.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+bDoS+V4AJZnUgoC"
Content-Disposition: inline
In-Reply-To: <1488394220.20145.68.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--+bDoS+V4AJZnUgoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 08:50:20PM +0200, Andy Shevchenko wrote:
> On Wed, 2017-03-01 at 18:02 +0000, James Hogan wrote:
> > On 11 January 2017 at 19:48, Jason Uy <jason.uy@broadcom.com> wrote:
> > > In the most common use case, the Synopsys DW UART driver does not
> > > set the set_termios callback function.=C2=A0 This prevents UPSTAT_AUT=
OCTS
> > > from being set when the UART flag CRTSCTS is set.=C2=A0 As a result, =
the
> > > driver will use software flow control as opposed to hardware flow
> > > control.
> > >=20
> > > To fix the problem, the set_termios callback function is set to the
> > > DW specific function.=C2=A0 The logic to set UPSTAT_AUTOCTS is moved =
so
> > > that any clock error will not affect setting the hardware flow
> > > control.
>=20
> > Bisection shows that this patch, commit
> > 6a171b29937984a5e0bf29d6577b055998f03edb, has broken boot of the
> > Cavium Octeon III based UTM-8 board (MIPS architecture).
> >=20
> > I now get the following warning:
>=20
> > [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> > [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> > [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> > [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> > [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> > [<ffffffff811901a0>] register_console+0x1c8/0x418
> > [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> > [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> > [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8
>=20
> > Then it hangs and the watchdog restarts the machine.
> >=20
> > Any ideas?
>=20
> 1. Does it use clock on that platform?

btw, sorry for HTML email blocked from lists, gmail tricked me into it
:-(

I've now dug a little deeper. Essentially what is going on is:

1) CONFIG_HAVE_CLK=3Dn (Octeon doesn't select it)
2) The CONFIG_HAVE_CLK=3Dn implementation of devm_clk_get() returns NULL
3) The "if (IS_ERR(d->clk) || !old) {" check in dw8250_set_termios()
   doesn't match, since !IS_ERR(NULL)
4) The CONFIG_HAVE_CLK=3Dn implementation of clk_round_rate() returns 0
5) The CONFIG_HAVE_CLK=3Dn implementation of clk_set_rate(d->clk, 0)
   returns 0
6) dw8250_set_termios() thinks the frequency for that baud rate has been
   set successfully and writes 0 into uartclk
7) it all goes wrong from there...

The CONFIG_HAVE_CLK=3Dn implementation of devm_clk_get() in particular
seems highly questionable to me, given that commit 93abe8e4b13a ("clk:
add non CONFIG_HAVE_CLK routines") which added it 5 years ago says:

> These calls will return error for platforms that don't select HAVE_CLK

And NULL isn't an error in this API.

Cc'ing some clk folk.

Cheers
James

--+bDoS+V4AJZnUgoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYuLcJAAoJEGwLaZPeOHZ6cDkP/3mvQE+yaNnKdwh4G/K0ezr8
zWYFYPAhQWH/gvGkgN6jetBBz7Ffxt51754pBAoXQQk5TddtzDqCGOlZQBpIBTJB
GEqnq3hf/i9KBwIvWodveOT13U8EIydeQquXRrsVx6SwIln/YlcszzQrDcB4ZRxr
AL93SMFr+ko79ZgSWvCOt2+aEtmeL2apVuQaWeEq6cCcOfStdv4hPlO4kPQTTbB/
/YNWvx3s33vWzlwxQ9Npm1/38xPiPWrkVzv25LbyC4lg1Wtg8a0xWrh866UAj8+S
eaqnm0czRo8NV0fOXjVjDZ0NKtmyV5CScnU0Xmw/dW7lyfsLilKraOw8x8qVBc1K
ZTnOcnif2+mdKNflK3AWTfU+b+MTte0w7s29LbFuSy3j6coKyMfEAcBaEs36xuJ6
c8J4cwz5juwq4FIDmSNKOPZxlC+5i1xbJesrbfk20Z0JmM57kSbz1bqFZKOVs9KP
ovqiZy0FG3McoF1+e4bFnr3+07MsbIBby/gNQDQd/HgTtEHXAwvJ8oZPOw1AuJ47
yl6YQO+t2k5MOeLemLdxcUcat63YlYNUbMnNx3sOO0gNJ+fDp+aPtg/R79ftKMN9
0axOINy9M42PAHWK4uSLddVTh9JuEE+vgGh8hk8BDeZovfT6xqaf80ni2dq9htys
UljKoCl2yxuzgP1pDeWo
=OgmA
-----END PGP SIGNATURE-----

--+bDoS+V4AJZnUgoC--
