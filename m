Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 17:54:13 +0100 (CET)
Received: from comal.ext.ti.com ([198.47.26.152]:45147 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007908AbbCIQyLEQW1G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Mar 2015 17:54:11 +0100
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id t29GrIAH022184;
        Mon, 9 Mar 2015 11:53:18 -0500
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id t29GrGok025970;
        Mon, 9 Mar 2015 11:53:16 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE70.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server id 14.3.224.2; Mon, 9 Mar 2015
 11:53:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])     by
 dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id t29GrE5r021841;        Mon, 9 Mar
 2015 11:53:15 -0500
Date:   Mon, 9 Mar 2015 11:52:42 -0500
From:   Felipe Balbi <balbi@ti.com>
To:     Valentin Rothberg <valentinrothberg@gmail.com>
CC:     <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Afzal Mohammed <afzal@ti.com>, Keerthy <j-keerthy@ti.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <balbi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Quentin Lambert <lambert.quentin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Eyal Perry <eyalpe@mellanox.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <iss_storagedev@hp.com>,
        <linux-mtd@lists.infradead.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] Remove deprecated IRQF_DISABLED flag entirely
Message-ID: <20150309165242.GK3739@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
 <1425565425-12604-1-git-send-email-valentinrothberg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GeONROBiaq1zPAtT"
Content-Disposition: inline
In-Reply-To: <1425565425-12604-1-git-send-email-valentinrothberg@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <balbi@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: balbi@ti.com
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

--GeONROBiaq1zPAtT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 05, 2015 at 03:23:08PM +0100, Valentin Rothberg wrote:
> The IRQF_DISABLED is a NOOP and has been scheduled for removal since
> Linux v2.6.36 by commit 6932bf37bed4 ("genirq: Remove IRQF_DISABLED from
> core code").
>=20
> According to commit e58aa3d2d0cc ("genirq: Run irq handlers with
> interrupts disabled") running IRQ handlers with interrupts enabled can
> cause stack overflows when the interrupt line of the issuing device is
> still active.
>=20
> This patch ends the grace period for IRQF_DISABLED (i.e., SA_INTERRUPT
> in older versions of Linux) and removes the definition and all remaining
> usages of this flag.
>=20
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> ---
> The bigger hunk in Documentation/scsi/ncr53c8xx.txt is removed entirely
> as IRQF_DISABLED is gone now; the usage in older kernel versions
> (including the old SA_INTERRUPT flag) should be discouraged.  The
> trouble of using IRQF_SHARED is a general problem and not specific to
> any driver.
>=20
> I left the reference in Documentation/PCI/MSI-HOWTO.txt untouched since
> it has already been removed in linux-next by commit b0e1ee8e1405
> ("MSI-HOWTO.txt: remove reference on IRQF_DISABLED").
>=20
> All remaining references are changelogs that I suggest to keep.
>=20
> Changelog
>=20
> v2: Correct previous change to drivers/mtd/nand/hisi504_nand.c that
> broke compilation.  Reported by Dan Carpenter.
> ---
>  drivers/usb/isp1760/isp1760-core.c   |  3 +--
>  drivers/usb/isp1760/isp1760-udc.c    |  4 ++--

I have a commit in my tree for isp1760:

https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dtest=
ing/fixes&id=3D80b4a0f8feeb6ee7fa4430a2b4ae1155ed923bd2

--=20
balbi

--GeONROBiaq1zPAtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/c/aAAoJEIaOsuA1yqRE1ZgQAJaOk/fZlreUft6tbD48x3FY
Q6TS7GLTuHQ5F0CUAevUXllXQ5z/cB4tI8F4sZbF4G8rJaAGPtaF6ehBtumXY63o
b9ti3QlAmBGP/cf6HU0SULcgLTJ5ghhNcgaGCdel7iq9jEZOVF4s/jXP4GSB0TME
Ma05sczk7VOzRmPEOsVhGBYLJr4NNZQKOhxk9fYzp6PdeE2Rjq5de/gyKyenrCcX
ly1L4poMqfUC9H1R0SayLnz+4a/4KbhoATZrt5C/+UWaoF13ycsRUP9uZ8Z4DCRG
6MOi3pXUVrnmIoCB3b2SySGDFcX0RgYuB/m5wmBXn4FyxjhBPimIsxa7Z+EWjUXW
G1KflmXYDgw7aXcFy2s5CymnzLkJgAzTg68qpkJoGK45aq5iTxMuuNMU24bOlkZz
7VJSOFQgaQmq0EuilLQNvpJmXz5m6vDsJzhO5B/oEN8vL4uAJFohqEQii/oj2ro9
xC/9GFeFYJWFAXQCi6wo8tkr52TCqoykeoCI2C7jtQvLpXrMt1BHMXEvY56/QEDU
ij22tExXr7r3HUxfHZahzus3G2auAARoBbwreutV2wykO8maXSEJf44jRqSL6fYm
+sPmKuFn0KcNL7EHg3dTXkOi7NTeFgPxMHpm63hm0ZP3wFiZRxIW9FzobBnPoOHS
b+5RKJz0meOSuRiagNlq
=4Qmw
-----END PGP SIGNATURE-----

--GeONROBiaq1zPAtT--
