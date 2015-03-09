Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 18:30:53 +0100 (CET)
Received: from bear.ext.ti.com ([192.94.94.41]:50472 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008422AbbCIRatn-Lnj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Mar 2015 18:30:49 +0100
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id t29HThBe003054;
        Mon, 9 Mar 2015 12:29:43 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id t29HTfLo001252;
        Mon, 9 Mar 2015 12:29:41 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE71.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server id 14.3.224.2; Mon, 9 Mar 2015
 12:29:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])     by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id t29HTdwX027587;        Mon, 9 Mar
 2015 12:29:40 -0500
Date:   Mon, 9 Mar 2015 12:29:07 -0500
From:   Felipe Balbi <balbi@ti.com>
To:     Valentin Rothberg <valentinrothberg@gmail.com>
CC:     <balbi@ti.com>, <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20150309172907.GO3739@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
 <1425565425-12604-1-git-send-email-valentinrothberg@gmail.com>
 <20150309165242.GK3739@saruman.tx.rr.com>
 <CAD3Xx4JCL7Gt9SEoumiKSvmQOL-JQmg0Qth5wRE7COFZ-Oap8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AFQGHouA0VN8Ovbt"
Content-Disposition: inline
In-Reply-To: <CAD3Xx4JCL7Gt9SEoumiKSvmQOL-JQmg0Qth5wRE7COFZ-Oap8g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <balbi@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46300
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

--AFQGHouA0VN8Ovbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 06:24:29PM +0100, Valentin Rothberg wrote:
> On Mon, Mar 9, 2015 at 5:52 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Mar 05, 2015 at 03:23:08PM +0100, Valentin Rothberg wrote:
> >> The IRQF_DISABLED is a NOOP and has been scheduled for removal since
> >> Linux v2.6.36 by commit 6932bf37bed4 ("genirq: Remove IRQF_DISABLED fr=
om
> >> core code").
> >>
> >> According to commit e58aa3d2d0cc ("genirq: Run irq handlers with
> >> interrupts disabled") running IRQ handlers with interrupts enabled can
> >> cause stack overflows when the interrupt line of the issuing device is
> >> still active.
> >>
> >> This patch ends the grace period for IRQF_DISABLED (i.e., SA_INTERRUPT
> >> in older versions of Linux) and removes the definition and all remaini=
ng
> >> usages of this flag.
> >>
> >> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> >> ---
> >> The bigger hunk in Documentation/scsi/ncr53c8xx.txt is removed entirely
> >> as IRQF_DISABLED is gone now; the usage in older kernel versions
> >> (including the old SA_INTERRUPT flag) should be discouraged.  The
> >> trouble of using IRQF_SHARED is a general problem and not specific to
> >> any driver.
> >>
> >> I left the reference in Documentation/PCI/MSI-HOWTO.txt untouched since
> >> it has already been removed in linux-next by commit b0e1ee8e1405
> >> ("MSI-HOWTO.txt: remove reference on IRQF_DISABLED").
> >>
> >> All remaining references are changelogs that I suggest to keep.
> >>
> >> Changelog
> >>
> >> v2: Correct previous change to drivers/mtd/nand/hisi504_nand.c that
> >> broke compilation.  Reported by Dan Carpenter.
> >> ---
> >>  drivers/usb/isp1760/isp1760-core.c   |  3 +--
> >>  drivers/usb/isp1760/isp1760-udc.c    |  4 ++--
> >
> > I have a commit in my tree for isp1760:
> >
> > https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3D=
testing/fixes&id=3D80b4a0f8feeb6ee7fa4430a2b4ae1155ed923bd2
>=20
> I am sorry, but I did not receive an email that it has been applied.
> Andrew asked me to do this patch, so I replied to the one you
> mentioned to avoid this conflict:

it's still in my testing/fixes, it'll be moved to fixes after I finish
testing that branch, then you'll receive an email

--=20
balbi

--AFQGHouA0VN8Ovbt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/dhjAAoJEIaOsuA1yqRE084QAK/PIzs7jP/V+aSCsJYjZUdB
GQQlAB+B+/hoCSXyqGILrByQOITeyaDCyLv2TrwwLIi5/MYHqyGuO2hKiREtSYAz
GFxwRVwDTZZRU9EwqY2AJf1AN/bi55f8K1+qbmkcOuc9o8oXL6aX6gjDkT4e03hC
xvh1CqroT08hmt6zCcCmhMPcNKXyP/ccBzzIRBNnuZfcL6FSkJ+q/0JMXI3Pob2c
tyYtyY4msShPsbDlvdsz/3lnLsZUhker9b6rooixhH4LDkVr6dUsYMHIHKDfPvD4
VgYw6Ogd+8+0f6TvRb+AKZYdwgWqZQxmDkHeNZRpqlYr0n3A7hsnGkZE1WVIey/V
TS4Zzx8PN2/ZIHOZeo8QhojJPz9P59VWkFxkxelnowaf93DmkQMpc8QwPCDnmFz8
dsRQK65OuIvFdhQbW/LXUNLkzr2S7if6ztWcraH3Xpa7/xgc1o8n6RlE3b4mLK5f
SPTgcFF0eOu06AwfwyaxOpK00mUfUmjKOv00PYZjnCyD3UX5HNJHUJAuJJZkH8Ns
1dZKevNy+C005CXjb/T0leLz9QIvyJVlPaf06LQTuN38eZo8yF0SDF7xcQSiu6TR
vRSVzOeu6HChsEI8jVDV2mmkwIBZHYBJDbHtR9OdP+32Z7R+8xYAxzIV2LEHn6R+
lIbRpAm0Sb85UU/GJoHq
=rJOK
-----END PGP SIGNATURE-----

--AFQGHouA0VN8Ovbt--
