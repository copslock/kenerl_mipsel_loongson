Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:34:47 +0200 (CEST)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:59004 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIYHeoO1An5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:34:44 +0200
Received: by mail-wg0-f42.google.com with SMTP id a1so6886356wgh.13
        for <multiple recipients>; Thu, 25 Sep 2014 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OcuHJJN0/DSZKPG8NWDQOY2IxAdPsavayVNpVwkgn9I=;
        b=hVBVTWLcqpypRHqmKe4zx2nqsm3cj/isE9qxrTbLkK5jhDuzFqhvGyFJvxkJ2PEtjD
         T5U7v0AdLqx7Cbi1Zlt29VTcGbs+DUBZqrJsAjrbRcIRNXOtM/Mz+UtPw+JXa3/ozjPl
         NN/b3IslxmBBi9fXK28jUVvpIimx5IZRBYYA62YF+laYEK/udnVD9O191FR0MxAiSOow
         jts9xMXC9tW54LTj/kp6VPRNdV3bwPEQ3e0eGILuyfjY86rOeSGaLsynvwtWgZqCoW51
         8GitI0AYu1ZJpIU8vF+6GbPeaM6SVgt4wF1pg86GBe9X394N/zBW4HTRuaAYajDOnccD
         LfGA==
X-Received: by 10.194.76.195 with SMTP id m3mr489584wjw.136.1411630478136;
        Thu, 25 Sep 2014 00:34:38 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id pi8sm2170899wic.17.2014.09.25.00.34.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:34:37 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:34:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 12/22] MIPS/Octeon/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Message-ID: <20140925073435.GJ12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-13-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwgQ89ZNnFUwFHTC"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-13-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42802
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


--rwgQ89ZNnFUwFHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:22AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
[...]
> @@ -132,12 +132,12 @@ msi_irq_allocated:
>  	/* Make sure the search for available interrupts didn't fail */
>  	if (irq >=3D 64) {
>  		if (request_private_bits) {
> -			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying=
 just one",
> +			pr_err("octeon_setup_msi_irq: Unable to find %d free interrupts, tryi=
ng just one",
>  			       1 << request_private_bits);

Perhaps while at it make this (and other similar changes in this patch):

	pr_err("%s(): Unable to ...", __func__, ...);

So that it becomes more resilient against this kind of rename?

>  			request_private_bits =3D 0;
>  			goto try_only_one;
>  		} else
> -			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
> +			panic("octeon_setup_msi_irq: Unable to find a free MSI interrupt");

> @@ -210,14 +210,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nv=
ec, int type)
> =20
>  	return 0;
>  }
> -

This...

> @@ -240,7 +239,7 @@ void arch_teardown_msi_irq(unsigned int irq)
>  	 */
>  	number_irqs =3D 0;
>  	while ((irq0 + number_irqs < 64) &&
> -	       (msi_multiple_irq_bitmask[index]
> +		(msi_multiple_irq_bitmask[index]

=2E.. and this seem like unrelated whitespace changes.

>  		& (1ull << (irq0 + number_irqs))))
>  		number_irqs++;
>  	number_irqs++;
> @@ -249,8 +248,8 @@ void arch_teardown_msi_irq(unsigned int irq)
>  	/* Shift the mask to the correct bit location */
>  	bitmask <<=3D irq0;
>  	if ((msi_free_irq_bitmask[index] & bitmask) !=3D bitmask)
> -		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
> -		      "interrupt (%d) not in use", irq);
> +		panic("octeon_teardown_msi_irq: Attempted to teardown MSI "
> +			"interrupt (%d) not in use", irq);

And the second line here also needlessly changes the indentation.

Thierry

--rwgQ89ZNnFUwFHTC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8WLAAoJEN0jrNd/PrOhp2MQAK6S7hsneW6O97w/t1chjlGR
ug1JLAxeP84A0Vj4I6KwfrHjux8rDqoByI5bDhH+ywcRQuf90Dx9+L9QEfWlzkcC
K1qT+twZDUqVFhCIJtuEtNVJbEXb0NlPK74W/6cUubFdAKbY1+MZe66Z0BZlBl36
bjxEyTh6uZkemh8PLwP45mJQCTD/d5/lNGDCrgzKgurE1HIHXV1r0FoD9zLJZpfA
UATpp5rQYfePlynE1mCT+G0QXcfo+zf8kp49jLxeciX5QZYs8DbZ2IwbhG4ov2je
p8SHV5T+c8D1+Q7UjNbXpDGHz12Ctpby/bLd3+FGsmeIZJbE4o5NcE5pChZfI52v
Rgl0wLOlswsM2xoSGdhA1x51QEHqFxShBf/+FwbxLA7shNWELd6gRpv9mcYSv6oy
MgALA5tV5r18NZyBm+SsvwUrgAF7e1ndIU/UYhAH1lIz3CMtqTnZ2AZIpXoJeKLo
rtzWB2MThJnnZXUpW3Umj3UWoZkcAy6zQSWBGV40hC+t3dkr1US9bOgGIrO6huyy
qTqNG+A20dRO85W7LoslDg5CO401jS8JRiHbYQW9g+QhHkWLpROgcrCoK1dz+Q2B
QjaLp2fjuM7wyyYXRLcQo68i7Y9AUv2R+k1fidvlfuWXfvzbeK6x0BHSx8nhBec6
SU2aBh+SOaTeNEFZjRFv
=dRXg
-----END PGP SIGNATURE-----

--rwgQ89ZNnFUwFHTC--
