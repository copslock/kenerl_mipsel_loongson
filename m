Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2012 05:31:34 +0200 (CEST)
Received: from haggis.pcug.org.au ([203.10.76.10]:37476 "EHLO
        members.tip.net.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903318Ab2IUDb1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2012 05:31:27 +0200
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by members.tip.net.au (Postfix) with ESMTPSA id 23AA01640F3;
        Fri, 21 Sep 2012 13:30:57 +1000 (EST)
Date:   Fri, 21 Sep 2012 13:30:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thierry Reding <thierry.reding@avionic-design.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Greg Ungerer <gerg@uclinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Provide a default pcibios_update_irq()
Message-Id: <20120921133053.7d92b41c54d3400e952ee8ff@canb.auug.org.au>
In-Reply-To: <CAErSpo4RgNjFE7zH9vKTgAq_7djbWi5sR7k_DJYr8=G3A=0zeg@mail.gmail.com>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
        <1347880974-13615-2-git-send-email-thierry.reding@avionic-design.de>
        <20120920083731.b99255eb8fdeea908d34ed2f@canb.auug.org.au>
        <CAErSpo4RgNjFE7zH9vKTgAq_7djbWi5sR7k_DJYr8=G3A=0zeg@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__21_Sep_2012_13_30_53_+1000_6fJdZvf2GVz=KRck"
X-archive-position: 34534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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
Return-Path: <linux-mips-bounce@linux-mips.org>

--Signature=_Fri__21_Sep_2012_13_30_53_+1000_6fJdZvf2GVz=KRck
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Thu, 20 Sep 2012 21:19:30 -0600 Bjorn Helgaas <bhelgaas@google.com> wrot=
e:
>
> On Wed, Sep 19, 2012 at 4:37 PM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> >
> > Didn't we have a problem with some compiler versions when the weak
> > definition was in the same file as the call (there is a call to this
> > function in drivers/pci/setup-irq.c)?
>=20
> There was such a bug, but as far as I know, we aren't worrying about
> it anymore: https://lkml.org/lkml/2011/7/4/9

OK, thanks.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__21_Sep_2012_13_30_53_+1000_6fJdZvf2GVz=KRck
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQW99tAAoJEECxmPOUX5FEL/YP+wX8jDRVY59Nu8INBHtW97vi
Id5MzR7NZqIMFLsX4TTasMY3zXmh7QthaRgHeLCRpeApLuai3q7jPO9mh1N5Liij
ipemFO+d4Z+SODfvdaWFxzAdvb3OHBZ2Bj2fUX9reeJoqLx6rRNkhOIXapx8gjFT
G6Zpv5G6UC6oCJwQwO+v1zIuPA5Z6MN3PRhShM6bTvRguXeih+Ur+67XRtDDKORi
KngGhWpc0ieTooaQEfdlJ5eztlk8qphp3lM6ehdXTPzdl9azRM0oj5Lvn7T9pauj
2zNJ5JEZj1hFHQPfjxurrx1h6b+duoZ9E3IN2mHM+DpOHltfxSnar8Pv0nJsq9yS
sqrxuIomZggUNi68h+bebrd+76Na6u9FAq0DOnZas+kxWYDmw6Pf+DjAOylBLEyr
qitrPDoJONCJzjFbklyvdIhvoHmp0HLssku9uuocz6AWJ4oXwTiOLGC1RfYLJmpA
qtKjPRUkvSMGGXh7wbSJu1B9/Z0e7hdKspggv5nzYnkJB0lDYaQcl5/0f5S6Yy34
clbH1xdUT2YnW6T8wfNUAvMf3bexzVCy6IGxU9gidfYcQMcbv+Fzpp1HNtsnQX+R
W9otg+HJxouJ69+UpBMUWeS6pc0voZdT/GDEpxbN3u9P8e8Y46OJZfEwOGIgrjUP
flkeljYJMKmwjZ/bAfRA
=292X
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Sep_2012_13_30_53_+1000_6fJdZvf2GVz=KRck--
