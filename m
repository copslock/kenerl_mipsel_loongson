Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:26:32 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39905 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIYH01DJO6k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:26:27 +0200
Received: by mail-wg0-f45.google.com with SMTP id x13so6812873wgg.28
        for <multiple recipients>; Thu, 25 Sep 2014 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=apL9wiTwFhCqNmhb4tFuG3MrcgFxeRCwW2KTxtZbY8k=;
        b=gYyYpxZJYtHVNybchtUvWX/xkZ2BB683Gn1A47q666UBOY0+yuEKh7dnN8vWZ37Zv3
         FTt7NxlaZxrLcmBJ+iiyGZwVGfezy2WaIJl98AzU1bJVbAoGapFMGJVECuWTXD13mU/s
         DOjzs3CHnfUnTcMyJlxbdvEuW8epDTBqJYt3D0O4oXM/hIJL8lF+TR/R2ZjSWZM7dBtz
         U8AYVr8kePJwb3EIoocIhRtI8EQPnswQtqeWJ6y7hzsct7ao1Z3WOjHDNcpZENLMwjLI
         Uq9VqHki8QPWH4xW9Rt5Z8lEzsdcuaZ6ZoDghyOhGhqMQR0nCnHJ+5IDEwuzlT1s+C+D
         2aGg==
X-Received: by 10.180.187.83 with SMTP id fq19mr35910466wic.59.1411629981806;
        Thu, 25 Sep 2014 00:26:21 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id bg10sm1660249wjc.47.2014.09.25.00.26.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:26:21 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:26:20 +0200
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
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip() to
 find MSI chip
Message-ID: <20140925072619.GI12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42801
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


--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 11:14:16AM +0800, Yijing Wang wrote:
> Introduce weak arch_find_msi_chip() to find the match msi_chip.
> Currently, MSI chip associates pci bus to msi_chip. Because in
> ARM platform, there may be more than one MSI controller in system.
> Associate pci bus to msi_chip help pci device to find the match
> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
> like in x86. we only need one MSI chip, because all device use
> the same MSI address/data and irq etc. So it's no need to associate
> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
> to return the MSI chip for simplicity. The default weak
> arch_find_msi_chip() used in ARM platform, find the MSI chip
> by pci bus.

Can't x86 simply set the bus' .msi field anyway? It would seem to be
easy to do and unifies the code rather than driving it further apart
using even more of the __weak functions.

Thierry

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8ObAAoJEN0jrNd/PrOhuC4P/jIBmvnDAEtAA8p9/uMyo4ub
35EbcR8vyvkUOhtovW5OYqkxRnKAfsYNHAbYYijRRWopeBkmqYj1EiW8F3M3MbKT
FD+87Kx/0mNqy1mNdoPnIttpaCyY9igbhmeWhE5gFFqI4L715gT4AVg7tG79gsas
BObGQrGqdsEcdHsMae9wIm6X46Q2HcECiOp5T619C7P6/4DRXoQ6CreiwtWgh8GN
HdDemrevFvVZI72ceWPPPSY813vykzLhvxbiMhjhiYtZSbtqmYJoNQBbeQIlhfYV
mdIBuGWQlSAyy4+IZq/IBJ/lO4BtU4zevDvSCOnKhCUlHAZ7qNpxLtDXaZmxRQ1W
/9BeZHt+IDeev7rXTA97oQXAwzbAabafN1FWyCUWZEq28xIYmAqQZeFA9+KKRQQm
QMs10F3xpcayjlUXPNp7pLoWgcffcb0g8YocMo4DdMgMFQ9Pnx7jIrQ9Z46n4o+i
u2Qb275YAwisvL1ol3S2lZ+19CdVEwp+ly/66aYviHzVYeDm2C11myPCbfCbNcPg
M/qS6KwZzn+LyyCiLT0dmcm90UTIPZ7uw0sbwcVbq80skjhZxLT5NS7xHYnP/znG
62a/6pxngsPcnk+b7pv2htjbxkKDjJkpn8kXGiR6sGwun0b7HheNwzanLbDPs/7B
3QkCbl7txteq7GjETQqt
=LNzZ
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--
