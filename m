Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 03:02:31 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:35630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990474AbdJEBCXq872r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Oct 2017 03:02:23 +0200
Received: from mail.kernel.org (dyndsl-091-248-051-199.ewe-ip-backbone.de [91.248.51.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA69321869;
        Thu,  5 Oct 2017 01:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA69321869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date:   Thu, 5 Oct 2017 03:02:18 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Reed <mdr@sgi.com>, Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] timer: Remove init_timer_deferrable() in favor of
 timer_setup()
Message-ID: <20171005010218.v3aw4d3y66jn3bbo@earth>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-6-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ioctv6qfrc7mty7c"
Content-Disposition: inline
In-Reply-To: <1507159627-127660-6-git-send-email-keescook@chromium.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <sre@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sre@kernel.org
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


--ioctv6qfrc7mty7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Oct 04, 2017 at 04:26:59PM -0700, Kees Cook wrote:
> This refactors the only users of init_timer_deferrable() to use
> the new timer_setup() and from_timer(). Removes definition of
> init_timer_deferrable().

[...]

>  drivers/hsi/clients/ssi_protocol.c           | 32 ++++++++++++++++------------

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--ioctv6qfrc7mty7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnVhJQACgkQ2O7X88g7
+poqtw/+NVd8QRs2QuA6PAGWHUwxaYVABpFWmmT6auUlvyFDZ3dfZJID5IF3k1iT
na5dX3a4nAKolDTmc7NOxWF7vEH/L/ONlRhfTt69PFg9oAk5KNjS1RdEx1bdxGRU
rUBXQwOc2zi9LqxB2Hd8GQXOOhxbw0gICl4wrLCoUdkGNJs5fPpR6zVG8PGbntpq
WWjDPDja6L+D6+pMhGADYfYj7Xtkfm0GWn3bycnHFKvFB61feCjknnH33QHR2Ayt
O7gqcCR5aaYf6EadcVT4wR+ZRYl/7sZt102ziwKAsy2eztiOIsj4N8aRV2oR8riz
CGwIx8ANBkrdn6OG8XFy6BfPzSZcBXqg6L/WreDPHJa2xZAzOds566XysTlDVnS2
mmPZzXYhzdSJT5SgWxOwzPE3LH6wgG3id80kaCHFqive8gfGI6rh6Y8zQUk3umvg
ksAklh+tTffWw6oBVT5P2GdyJUHx53Mbb3msk6NyH/G5DmGE0ikcWNcSHg8gcjVt
KKArZaKBako7TLOE9Xklfx43wLM7GM5RtR6oDCeUfKKG8sF1PLaANmp0SnJeWP2X
FjPA+SlOO9G/qT++PIkxsB2T6sFZrF/TNXi5exM7V6mYdTxvwJ8OVsKNMQKyxOKq
rFI2Ntch9Trc5vcvXqlrW84i2bzA1b0jfzO1nkKoKm0XF8UHUKo=
=6loN
-----END PGP SIGNATURE-----

--ioctv6qfrc7mty7c--
