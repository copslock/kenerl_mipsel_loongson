Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 09:41:14 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:56211 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeABIlDh098x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 09:41:03 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 02 Jan 2018 08:40:34 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Jan 2018
 00:40:32 -0800
Date:   Tue, 2 Jan 2018 08:40:31 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     MIPS Mailing List <linux-mips@linux-mips.org>,
        <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is
 used
Message-ID: <20180102084030.GK5027@jhogan-linux.mipstec.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-4-jonas.gorski@gmail.com>
 <20171114110211.GA5823@jhogan-linux.mipstec.com>
 <CAOiHx==rL82D4NMz8t15jMr8m5oQmhkAzc+9r6qA0WMgbS-b9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zBZpvCNcoXwafAjP"
Content-Disposition: inline
In-Reply-To: <CAOiHx==rL82D4NMz8t15jMr8m5oQmhkAzc+9r6qA0WMgbS-b9w@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1514882433-637138-32443-384931-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188567
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--zBZpvCNcoXwafAjP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2017 at 04:38:29PM +0100, Jonas Gorski wrote:
> On 14 November 2017 at 12:02, James Hogan <james.hogan@mips.com> wrote:
> > On Sun, Oct 29, 2017 at 04:27:21PM +0100, Jonas Gorski wrote:
> >> Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
> >> trigger I/F of FIFO buffers"), the port's default FCR value isn't used
> >> in serial8250_do_set_termios anymore, but copied over once in
> >> serial8250_config_port and then modified as needed.
> >>
> >> Unfortunately, serial8250_config_port will never be called if the port
> >> is shared between kernel and userspace, and the port's flag doesn't ha=
ve
> >> UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as wel=
l.
> >>
> >> This causes garbled output from userspace:
> >>
> >> [    5.220000] random: procd urandom read with 49 bits of entropy avai=
lable
> >> ers
> >>    [kee
> >>
> >> Fix this by forcing it to be configured on boot, resulting in the
> >> expected output:
> >>
> >> [    5.250000] random: procd urandom read with 50 bits of entropy avai=
lable
> >> Press the [f] key and hit [enter] to enter failsafe mode
> >> Press the [1], [2], [3] or [4] key and hit [enter] to select the debug=
 level
> >>
> >> Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigg=
er I/F of FIFO buffers")
> >> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> >> ---
> >> I'm not sure if this is just AR7's issue, or if this points to a gener=
al
> >> issue for UARTs used as kernel console and login console with the "fix=
ed"
> >> commit.
> >
> > Thanks. Given nobody seems to have objected, I've applied to my
> > mips-fixes branch, with stable tag for 3.17+.
>=20
> Hmm, I don't see it in
> https://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git/log/?h=3D=
mips-fixes
> - did you maybe forget to push?

Ralf reappeared so I delegated the patch to him in patchwork, and he has
apparently marked it as accepted.

But perhaps that only just happened and he hasn't pushed yet. Ralf?

Cheers
James

--zBZpvCNcoXwafAjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpLRX4ACgkQbAtpk944
dnowVQ//TBNJ/KpQTDvxPtW4e0XF19xuu9crVUf8Nm4F6cX4x2jPk8sHjWadYG8x
yDP7KQBiHhAQH4uJcpPaH6ViwBNKqhHaDphrjTDF33qbOxvTqfH6GRy8aPo4ZE1U
NblrXfxGvO2YnOTbtYHsErh13wUqmjQanRD81OrH8CU+CI5Bcwz+TBl8LsWipR9V
0TAO+3fb007SHUVQI0yLQ/cuwz++GBJbtJoCBgVBAyhQXdYbgHiPkBuaQxtSChrk
lZSsaTDHKKO6Fl/Myr9yh0ld+3Et1wYfcLbRTCOJ8XNK+wokzPc3FltFLXMSW1E1
fFLyYzXaduBt8cCmgyzBh+D9OazErqtr+sJR4L4M7wX5dOU9aC+aEYxZ7wNJl34S
CznuIEsvAmtWZC0LBSFNjb5Lb9/n2G2tep73Zikart9KU7lP35Tcpljv60ujxF1o
YJmWx+4GDle+kYLEzrkEtMm7P5rqFOT5DNvH466JdQWBK0AdqwNnTLoliIBpoTMw
Z6c0Aj0Nr43/ic4TxA3mgvRbgDbj2Pwipsak+to+WxoG73HFNR+quadNvYxYEcy5
TsMD/1dZzNCbp4wh+MlexuqKqZNG1EkIVYvbnzfzbtyq4nL3cwEPcDeeTvKlrnxt
zIQnpaaJf21maRZRC/vUeRG5P9YS/S/R4hOhifAMzV8YFShXLdQ=
=Xw6n
-----END PGP SIGNATURE-----

--zBZpvCNcoXwafAjP--
