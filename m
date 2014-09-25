Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:06:10 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:52982 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIYHGIn6bFl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:06:08 +0200
Received: by mail-wg0-f52.google.com with SMTP id n12so5643084wgh.23
        for <multiple recipients>; Thu, 25 Sep 2014 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sAWLuIz2mypWO160iftrwrkyaD+2dEjPGse35FodaGQ=;
        b=dYbGCVOMsO7VEyFzv4L0wf25SVcltAE+r2aFEa3Q5rmFYoHXrGzyoB1e9YVjy4xuI6
         H5yj88Rx97aNHtE9DW7h1vIhbdrLU9u/vu5MSTaOWa1VTe5YDdLVF7uxBQr3GW6zt17Q
         yhBYqE76CYNXjDugr7fLx4gcSdUmmgq4IVasXn7f1/MruRQo+LnSM+CBBXxM+5qQM/VC
         dPzW+oxfK8qiz7qoKcshhAhI1T8miit41OzCYjCLQ6k5mxahkbXTffUhB78LflbwXxAi
         3ieSuDCCCcK05JvyS5dDwp3pHQnabAqLHcxuuu+4ZBuOMuU4JIqND6rMgcYSc3/m4/5g
         qRXQ==
X-Received: by 10.194.246.2 with SMTP id xs2mr13006924wjc.33.1411628763513;
        Thu, 25 Sep 2014 00:06:03 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id hf9sm2104682wib.11.2014.09.25.00.06.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:06:02 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:06:01 +0200
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
Subject: Re: [PATCH v2 02/22] PCI/MSI: Remove useless bus->msi assignment
Message-ID: <20140925070601.GF12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-3-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-3-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42798
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


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 11:14:12AM +0800, Yijing Wang wrote:
> Currently, PCI drivers will initialize bus->msi in
> pcibios_add_bus(). pcibios_add_bus() will be called
> in every pci bus initialization. So the bus->msi
> assignment in pci_alloc_child_bus() is useless.

I think this should be the other way around. The default should be to
inherit bus->msi from the parent. That way drivers don't typically have
to do it, yet they can still opt to override it if they need to.

For Tegra for example I think it would work if we assigned the MSI chip
to the root bus (in tegra_pcie_scan_bus()) and then have it propagated
to child busses in pci_alloc_child_bus() so that tegra_pcie_add_bus()
can be removed altogether.

Thierry

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI77YAAoJEN0jrNd/PrOhZ/IQAMCSt26z+T6Q8TozfHBY40d1
VjyfIqF++JMHsJp9JBnJk7W/SdKcW+ClXvgZjtR4hqvTRlYUBPk6Sn3JWpi3RslY
GHt/y1pNGzk05qLADjlA8CAGVjq0Vspw5WO5SLjzu10gfvcddAX7YKRcWz5vW9uv
TcG+NFcDyGRaNg+ATkJ8Ep4rVN3eIkh9te9CE/pG5zQAV+NEZkaN4v9hRFubWIPy
HUXyDu+8aTJ3YUyhrXkbGR23i0lLzcWsqhrcjbbbQj0swxngijMgBbzJU2jJ0rxx
5CjTbs0mgvqKfsX1WQ3Df61rSN/krlMiZeD66YuMTuWdlzZkGJqpHCDkKdx2rITZ
o2IXg6faK1OARr8JfubrXil2utfpJkvBJR2fWmH0j37ZkEb249skTCAnb2yroyhJ
Mz3BmS+nAgPJkQUTTVZigeR+90KASb/WQrFPZhvOPK/ioMy0UyGy6uvNYm4rLXK+
gWN2TjIaniEFM60xJLFPgsVuf9XXKUZ0REybeTiDM65mofLUSkxtMbK/mrcBdHgF
kdO+JJ93hN6vnnqpqA/QjKNJebZm0PUjSTZvXIlzBs/v+gOh4bWewATJLbcgll/g
w85vBMPaceGBcjBIBul927T7Uf+2pLOmJHmM+eCzXSdxAyQ8qx75Su9uWOY3sX3Q
JDxVrWb34Dj7sIqL36a3
=f2MC
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
