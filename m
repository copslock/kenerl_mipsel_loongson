Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 00:07:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28869 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993420AbdCCXHTWw40W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 00:07:19 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7431841F8E07;
        Sat,  4 Mar 2017 00:11:58 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 04 Mar 2017 00:11:58 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 04 Mar 2017 00:11:58 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A00392AD750BF;
        Fri,  3 Mar 2017 23:07:08 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 3 Mar
 2017 23:07:13 +0000
Date:   Fri, 3 Mar 2017 23:07:13 +0000
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
Message-ID: <20170303230712.GT996@jhogan-linux.le.imgtec.org>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
 <1484164100-9805-2-git-send-email-jason.uy@broadcom.com>
 <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
 <1488394220.20145.68.camel@linux.intel.com>
 <20170303002129.GS996@jhogan-linux.le.imgtec.org>
 <1488547866.20145.74.camel@linux.intel.com>
 <ab064967-e362-d9be-3040-3260e9b5c426@broadcom.com>
 <3e45a0582dd91dab1a6e9bd6f4339e12@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvzZjokS1nTZS3h1"
Content-Disposition: inline
In-Reply-To: <3e45a0582dd91dab1a6e9bd6f4339e12@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57022
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

--mvzZjokS1nTZS3h1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Fri, Mar 03, 2017 at 09:43:55AM -0800, Jason Uy wrote:
> James,
>=20
> Can you verify that changing the code to the following fixes your problem?
>=20
> if (IS_ERR_OR_NULL(d->clk) || !old)
>     goto out;

It does, however I'm not at all convinced it is correct. clk_get either
returns a valid opaque clock cookie that can be passed to other clock
functions (which includes NULL), or ERR_PTR(-errno), which IS_ERR()
should catch for errors.

According to this thread:

https://lists.gt.net/linux/kernel/2102623

we should stick to the clk API and use IS_ERR() rather than
IS_ERR_OR_NULL(), but shouldn't be blindly accepting the result of
clk_get_rate() (or I suppose clk_round_rate()), but rather checking for
the value 0 and handling that case as "we don't have a usable clock from
the clk api, fall back to something else".

Cheers
James

>=20
> Regards,
> Jason
>=20
> -----Original Message-----
> From: Ray Jui [mailto:ray.jui@broadcom.com]
> Sent: March-03-17 9:34 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; James Hogan
> <james.hogan@imgtec.com>; Heiko Stuebner <heiko@sntech.de>
> Cc: Jason Uy <jason.uy@broadcom.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Jiri Slaby <jslaby@suse.com>; Kefeng Wang
> <wangkefeng.wang@huawei.com>; Noam Camus <noamc@ezchip.com>; Heikki Kroge=
rus
> <heikki.krogerus@linux.intel.com>; Wang Hongcheng <annie.wang@amd.com>;
> linux-serial@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>;
> bcm-kernel-feedback-list@broadcom.com; Linux MIPS Mailing List
> <linux-mips@linux-mips.org>; David Daney <david.daney@cavium.com>; Russell
> King <linux@armlinux.org.uk>; linux-clk@vger.kernel.org; Viresh Kumar
> <viresh.kumar@st.com>
> Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control =
to
> be used
>=20
> Hi Andy/Jason,
>=20
> On 3/3/2017 5:31 AM, Andy Shevchenko wrote:
> > Heiko, you might be interested in this as well.
> >
> > On Fri, 2017-03-03 at 00:21 +0000, James Hogan wrote:
> >> On Wed, Mar 01, 2017 at 08:50:20PM +0200, Andy Shevchenko wrote:
> >>> On Wed, 2017-03-01 at 18:02 +0000, James Hogan wrote:
> >>>> On 11 January 2017 at 19:48, Jason Uy <jason.uy@broadcom.com>
> >>>> wrote:
> >>>>> In the most common use case, the Synopsys DW UART driver does not
> >>>>> set the set_termios callback function.  This prevents
> >>>>> UPSTAT_AUTOCTS from being set when the UART flag CRTSCTS is set.
> >>>>> As a result, the driver will use software flow control as opposed
> >>>>> to hardware flow control.
> >>>>>
> >>>>> To fix the problem, the set_termios callback function is set to
> >>>>> the DW specific function.  The logic to set UPSTAT_AUTOCTS is
> >>>>> moved so that any clock error will not affect setting the hardware
> >>>>> flow control.
> >>>> Bisection shows that this patch, commit
> >>>> 6a171b29937984a5e0bf29d6577b055998f03edb, has broken boot of the
> >>>> Cavium Octeon III based UTM-8 board (MIPS architecture).
> >>>>
> >>>> I now get the following warning:
> >>>> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> >>>> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> >>>> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> >>>> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> >>>> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> >>>> [<ffffffff811901a0>] register_console+0x1c8/0x418
> >>>> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> >>>> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> >>>> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8 Then it hangs and the
> >>>> watchdog restarts the machine.
> >>>>
> >>>> Any ideas?
> >>>
> >>> 1. Does it use clock on that platform?
> >
> >> I've now dug a little deeper. Essentially what is going on is:
> >>
> >> 1) CONFIG_HAVE_CLK=3Dn (Octeon doesn't select it)
> >> 2) The CONFIG_HAVE_CLK=3Dn implementation of devm_clk_get() returns
> >> NULL
> >> 3) The "if (IS_ERR(d->clk) || !old) {" check in dw8250_set_termios()
> >>    doesn't match, since !IS_ERR(NULL)
> >> 4) The CONFIG_HAVE_CLK=3Dn implementation of clk_round_rate() returns 0
> >> 5) The CONFIG_HAVE_CLK=3Dn implementation of clk_set_rate(d->clk, 0)
> >>    returns 0
> >> 6) dw8250_set_termios() thinks the frequency for that baud rate has
> >> been
> >>    set successfully and writes 0 into uartclk
> >> 7) it all goes wrong from there...
> >
> > So, it means we have need special care of NULL case here, and
> > honestly, I don't like it. But it seems the only feasible (quick) fix
> > right now.
>=20
> I agree. I think it should have been:
>=20
> if (IS_ERR_OR_NULL(d->clk) || !old)
>     goto out;
>=20
> I think it makes sense to validate to make sure the 'clk' pointer is valid
> before proceeding any further down below (regardless of how well or how n=
ot
> well the clock framework handles it).
>=20
> Thanks,
>=20
> Ray
>=20
> >
> >> The CONFIG_HAVE_CLK=3Dn implementation of devm_clk_get() in particular
> >> seems highly questionable to me, given that commit 93abe8e4b13a ("clk:
> >> add non CONFIG_HAVE_CLK routines") which added it 5 years ago says:
> >>
> >>> These calls will return error for platforms that don't select
> >>> HAVE_CLK
> >>
> >> And NULL isn't an error in this API.
> >
> > Which is okay. I dunno what should be returned from clk_round_rate()
> > if clk is NULL. I would fix CLK framework, though I would like to
> > gather more details.
> >
> > Btw, I hope you also noticed this one:
> >
> > http://www.spinics.net/lists/linux-serial/msg25314.html
> >

--mvzZjokS1nTZS3h1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYufcZAAoJEGwLaZPeOHZ6ZxIQAIK+69uA+O+ZucfIIVEtqb5M
TVTWaGCoGbTorVa7GI4RAJjfO/0J5QPZyVL8VZiAHI3kovr71VqpVx2dZRtC5ZA/
yABfv14l9GWX/Tvb91A01RssVlTG3pQ7QMURsW8RbqAbnjxuqCZ8IG/bVArw20Py
ZYpsYmS4sfxjdQBbtfQVzh1kpEDfCAKL0dvrtzY2sAQ3a4AQptU+Z5sQLMaw+Jmy
SUaMXKCM0Efhz6W8TdX9qhX5dm3N63JheO7uW3exDJjRe3fcej2ufSos0wK/xrwr
QU+LDVtf8jp7xfFt28ml6ghFEFow2oaYH0GYakg5UvQBV5P2NzP680mznCpBv/fJ
Wf2RyZ6YIjFMrYAmUCyyLHLLTFi6oO5qowcfbKYluB7Akr0UcKzrIuI4kGc03C49
LyDs4hyj9EBE063mcbuJSBmRh8+nLdiNE9FMh0C4EtTVRPyObR+R+O50wYzo/37r
G0PPFBOmso0cUdqwmBFrhW0bpkogaaWRcWXfEjMcLSZYcncNAVhGbH3xnwcRthJn
vsDMiseZ1EIxNQe/qcIxUPv1fytdz8APYo+vY+rDepxEXafh2/M0cye6nTDMXqDF
TzseJAhra3G8C4xDH1+ikXyN0ExmUk/j5VC8+cBzpieNxDKsODozablOTzdwQDr2
uurjADJQAFXEiVGIATTO
=EetP
-----END PGP SIGNATURE-----

--mvzZjokS1nTZS3h1--
