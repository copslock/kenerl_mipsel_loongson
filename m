Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 01:11:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35970 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993420AbdCDALhEGiOv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 01:11:37 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3C4C441F8E07;
        Sat,  4 Mar 2017 01:16:16 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 04 Mar 2017 01:16:16 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 04 Mar 2017 01:16:16 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 238B9408A0905;
        Sat,  4 Mar 2017 00:11:26 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 4 Mar
 2017 00:11:31 +0000
Date:   Sat, 4 Mar 2017 00:11:30 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Jason Uy <jason.uy@broadcom.com>
CC:     Ray Jui <ray.jui@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
Message-ID: <20170304001130.GV996@jhogan-linux.le.imgtec.org>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
 <1484164100-9805-2-git-send-email-jason.uy@broadcom.com>
 <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
 <1488394220.20145.68.camel@linux.intel.com>
 <20170303002129.GS996@jhogan-linux.le.imgtec.org>
 <1488547866.20145.74.camel@linux.intel.com>
 <ab064967-e362-d9be-3040-3260e9b5c426@broadcom.com>
 <3e45a0582dd91dab1a6e9bd6f4339e12@mail.gmail.com>
 <20170303230712.GT996@jhogan-linux.le.imgtec.org>
 <69272eeb863f39633c51b0312c9ccd2f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O9T4zNOkGnr0n+A/"
Content-Disposition: inline
In-Reply-To: <69272eeb863f39633c51b0312c9ccd2f@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57026
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

--O9T4zNOkGnr0n+A/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Fri, Mar 03, 2017 at 04:02:56PM -0800, Jason Uy wrote:
> HI James,
>=20
> Maybe instead of that, we should do this instead
>=20
> If ((IS_ERR(d->clk) && PTR_ERR(d->clk)) || !old)

IS_ERR(x) matches a range of non-zero negative values, so it implies
PTR_ERR(x) already, so it doesn't change anything.

Cheers
James

>=20
> Note that this is what is done in the probe function of the dw driver.
>=20
> Regards,
> Jason
>=20
> -----Original Message-----
> From: James Hogan [mailto:james.hogan@imgtec.com]
> Sent: March-03-17 3:07 PM
> To: Jason Uy <jason.uy@broadcom.com>
> Cc: Ray Jui <ray.jui@broadcom.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Heiko Stuebner <heiko@sntech.de>; Gr=
eg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby <jslaby@suse.com>;
> Kefeng Wang <wangkefeng.wang@huawei.com>; Noam Camus <noamc@ezchip.com>;
> Heikki Krogerus <heikki.krogerus@linux.intel.com>; Wang Hongcheng
> <annie.wang@amd.com>; linux-serial@vger.kernel.org; LKML
> <linux-kernel@vger.kernel.org>; bcm-kernel-feedback-list@broadcom.com; Li=
nux
> MIPS Mailing List <linux-mips@linux-mips.org>; David Daney
> <david.daney@cavium.com>; Russell King <linux@armlinux.org.uk>;
> linux-clk@vger.kernel.org; Viresh Kumar <viresh.kumar@st.com>
> Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control =
to
> be used
>=20
> Hi Jason,
>=20
> On Fri, Mar 03, 2017 at 09:43:55AM -0800, Jason Uy wrote:
> > James,
> >
> > Can you verify that changing the code to the following fixes your probl=
em?
> >
> > if (IS_ERR_OR_NULL(d->clk) || !old)
> >     goto out;
>=20
> It does, however I'm not at all convinced it is correct. clk_get either
> returns a valid opaque clock cookie that can be passed to other clock
> functions (which includes NULL), or ERR_PTR(-errno), which IS_ERR() should
> catch for errors.
>=20
> According to this thread:
>=20
> https://lists.gt.net/linux/kernel/2102623
>=20
> we should stick to the clk API and use IS_ERR() rather than
> IS_ERR_OR_NULL(), but shouldn't be blindly accepting the result of
> clk_get_rate() (or I suppose clk_round_rate()), but rather checking for t=
he
> value 0 and handling that case as "we don't have a usable clock from the =
clk
> api, fall back to something else".
>=20
> Cheers
> James
>=20
> >
> > Regards,
> > Jason
> >
> > -----Original Message-----
> > From: Ray Jui [mailto:ray.jui@broadcom.com]
> > Sent: March-03-17 9:34 AM
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; James Hogan
> > <james.hogan@imgtec.com>; Heiko Stuebner <heiko@sntech.de>
> > Cc: Jason Uy <jason.uy@broadcom.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Jiri Slaby <jslaby@suse.com>; Kefeng
> > Wang <wangkefeng.wang@huawei.com>; Noam Camus <noamc@ezchip.com>;
> > Heikki Krogerus <heikki.krogerus@linux.intel.com>; Wang Hongcheng
> > <annie.wang@amd.com>; linux-serial@vger.kernel.org; LKML
> > <linux-kernel@vger.kernel.org>; bcm-kernel-feedback-list@broadcom.com;
> > Linux MIPS Mailing List <linux-mips@linux-mips.org>; David Daney
> > <david.daney@cavium.com>; Russell King <linux@armlinux.org.uk>;
> > linux-clk@vger.kernel.org; Viresh Kumar <viresh.kumar@st.com>
> > Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow
> > control to be used
> >
> > Hi Andy/Jason,
> >
> > On 3/3/2017 5:31 AM, Andy Shevchenko wrote:
> > > Heiko, you might be interested in this as well.
> > >
> > > On Fri, 2017-03-03 at 00:21 +0000, James Hogan wrote:
> > >> On Wed, Mar 01, 2017 at 08:50:20PM +0200, Andy Shevchenko wrote:
> > >>> On Wed, 2017-03-01 at 18:02 +0000, James Hogan wrote:
> > >>>> On 11 January 2017 at 19:48, Jason Uy <jason.uy@broadcom.com>
> > >>>> wrote:
> > >>>>> In the most common use case, the Synopsys DW UART driver does
> > >>>>> not set the set_termios callback function.  This prevents
> > >>>>> UPSTAT_AUTOCTS from being set when the UART flag CRTSCTS is set.
> > >>>>> As a result, the driver will use software flow control as
> > >>>>> opposed to hardware flow control.
> > >>>>>
> > >>>>> To fix the problem, the set_termios callback function is set to
> > >>>>> the DW specific function.  The logic to set UPSTAT_AUTOCTS is
> > >>>>> moved so that any clock error will not affect setting the
> > >>>>> hardware flow control.
> > >>>> Bisection shows that this patch, commit
> > >>>> 6a171b29937984a5e0bf29d6577b055998f03edb, has broken boot of the
> > >>>> Cavium Octeon III based UTM-8 board (MIPS architecture).
> > >>>>
> > >>>> I now get the following warning:
> > >>>> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> > >>>> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> > >>>> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> > >>>> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> > >>>> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> > >>>> [<ffffffff811901a0>] register_console+0x1c8/0x418
> > >>>> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> > >>>> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> > >>>> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8 Then it hangs and
> > >>>> the watchdog restarts the machine.
> > >>>>
> > >>>> Any ideas?
> > >>>
> > >>> 1. Does it use clock on that platform?
> > >
> > >> I've now dug a little deeper. Essentially what is going on is:
> > >>
> > >> 1) CONFIG_HAVE_CLK=3Dn (Octeon doesn't select it)
> > >> 2) The CONFIG_HAVE_CLK=3Dn implementation of devm_clk_get() returns
> > >> NULL
> > >> 3) The "if (IS_ERR(d->clk) || !old) {" check in dw8250_set_termios()
> > >>    doesn't match, since !IS_ERR(NULL)
> > >> 4) The CONFIG_HAVE_CLK=3Dn implementation of clk_round_rate() returns
> > >> 0
> > >> 5) The CONFIG_HAVE_CLK=3Dn implementation of clk_set_rate(d->clk, 0)
> > >>    returns 0
> > >> 6) dw8250_set_termios() thinks the frequency for that baud rate has
> > >> been
> > >>    set successfully and writes 0 into uartclk
> > >> 7) it all goes wrong from there...
> > >
> > > So, it means we have need special care of NULL case here, and
> > > honestly, I don't like it. But it seems the only feasible (quick)
> > > fix right now.
> >
> > I agree. I think it should have been:
> >
> > if (IS_ERR_OR_NULL(d->clk) || !old)
> >     goto out;
> >
> > I think it makes sense to validate to make sure the 'clk' pointer is
> > valid before proceeding any further down below (regardless of how well
> > or how not well the clock framework handles it).
> >
> > Thanks,
> >
> > Ray
> >
> > >
> > >> The CONFIG_HAVE_CLK=3Dn implementation of devm_clk_get() in
> > >> particular seems highly questionable to me, given that commit
> > >> 93abe8e4b13a ("clk:
> > >> add non CONFIG_HAVE_CLK routines") which added it 5 years ago says:
> > >>
> > >>> These calls will return error for platforms that don't select
> > >>> HAVE_CLK
> > >>
> > >> And NULL isn't an error in this API.
> > >
> > > Which is okay. I dunno what should be returned from clk_round_rate()
> > > if clk is NULL. I would fix CLK framework, though I would like to
> > > gather more details.
> > >
> > > Btw, I hope you also noticed this one:
> > >
> > > http://www.spinics.net/lists/linux-serial/msg25314.html
> > >

--O9T4zNOkGnr0n+A/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYugYyAAoJEGwLaZPeOHZ6UlUP/38BfF1UYDxx4a7HBrhHZPZW
V5QasOZgwCaNub6twcX5SMvX2jJQZb8Rwgkaz6CfMpZnq0WYTTGYjVFjKE9PeTJI
qno2Fm+w/nk8/YuYQVcWsqG9UzZa9tts5NnNKxPbpyRntKoZH90LP84sdTkRwZoy
sA7mOapLI2WNNr3yPZjQVGwTi7S7IJ0ZvbC+trnih2/F2L3taPMHiRbYcVfMBttk
NJSWD3ybvQIGgJtEKaKTNxbSZzdXO5g0bMBHfniPveapVGqSKXdUEJYYkSALhyo8
y2ZF+uIRyj3LxO8OHIvJXLk2ktqwXExmKbsP3vj1G0s8uC9zDFIUfPTATIWPGpbg
Lj/eGNkxWAWeEsFNz8GoqicpCEwwGlbnm/qPAzzxUzFKm94En9wxYOtWRINlTYe9
8ndCZMJuhQYx1zIxL00V62YOUThLJsGFfwrAB6U0Yo94koPfkvDqi3UUx76i9/1F
MAh9S53z/JkaKO2ZO8rpqx9CWqxkcl2y1Ft7dp7o8L2eOhDqllL4uJFAk2V2p9G/
7ivyjYhlIPrvrhCkyVUQYwJy0iLqBIeyUMUGs0CYNjv6cSIuoDiv3sYFxRY8UIJc
K/YkqnMWfivw2Sulmw8bEoEsKLRS8Z8ufOsqOfCEVqaT1J795+fcXELIUsx8iB7v
EdAtXtU8GdxI8YuYjUKv
=gj8k
-----END PGP SIGNATURE-----

--O9T4zNOkGnr0n+A/--
