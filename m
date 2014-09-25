Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:19:29 +0200 (CEST)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:64594 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIYHT1bDcsU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:19:27 +0200
Received: by mail-wg0-f47.google.com with SMTP id y10so7803689wgg.30
        for <multiple recipients>; Thu, 25 Sep 2014 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=54LPibpr5MFQmFUTqd/bsOkGnFV60cmVAemAuLuZND0=;
        b=bKoaY56t/58urznkHS/uRE4kF9JwlEB5YoTrwHsvgoNMnfy+OGN2wIqBfCZkttv5P9
         pcPw8GmgArX4wiOgIcEI0pDkq0DxhJRys2Xz6upnCZGJ7J/D5v8gsXZnG/CpUscsF8xh
         J2N7IOzc53ZuYftAW8ChR3fS8BH52MHRTMfIqqsl2xS05eSgYNImPJbG3a88jA3iKG23
         87mTFP3sqBx4Kcf17FuEwFSr39rZGhaWKJCFXIoi1mal8Hw5t6SrlJprTfdaGYswKaSR
         YeRZvAnU3wrLKZQHQJbYtPhnvLCX8IwixSe+G2GxwufmaPfFm+2tCN37peAhH5+d9LAA
         U2Pw==
X-Received: by 10.180.36.84 with SMTP id o20mr36654904wij.9.1411629562222;
        Thu, 25 Sep 2014 00:19:22 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id bg10sm1641250wjc.47.2014.09.25.00.19.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:19:21 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:19:20 +0200
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
Subject: Re: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
Message-ID: <20140925071919.GH12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42800
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


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> use irq chip_data to save the msi_chip pointer. They
> already call irq_set_chip_data() in their own MSI irq map
> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> is useless.

Again, I think this should be the other way around. If drivers do
something that's already handled by the core, then the duplicate code
should be dropped from the drivers.

Thierry

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8H3AAoJEN0jrNd/PrOhD9gP/irz9NSH3coHma+k59CgfNee
Eadp8ruJoWHsk+kNc+VP4X8QUfFbawc4Y9GarISl2soj926zV/hj8I7CSKn7im1g
OEWOG1+IoZY+1142DUhZRfqgw+kPIsHL2nKRK6RJCWhpIxIrh1f7/LcSyrWUbS9r
7t6FJUljEAZ4oSmW8FDuK4hrK9s53zIKQkvv2zfbOv7sAvnYuJM4r5EteKEkxVqy
VEwvbqgS5Ccf4PKJKnISrCAV9z4H8kYF2PN0e7+8x9l6WOsdz5yEszOJmoREGMzG
eCUaBYi7Tl7jAqdQkJfEePdK7BotGIbuffF2j76j1TTgOKp2HEoMlTxLv9SldxMa
9NoNSP5NzJzSyK6Pawx84xkhKnMd5TWLD7IMcDvfcMIbQ+IZiXDnNjQ9diG3RjhT
zLyMRZc5MdOfL8ScPzrYYUATbIEFmJdB0rUZ6u9ivHdRsVqZ6pJbRz/C/QPfd92M
dDXoVvcRDGGgaM66PbfYykArWhGI+hPG4ip3t5CpA2KLqLm9BapvqSc0H6V9y5w8
nuBHS0pk3mojCR9naMzuOy0nqME7SU9QiOiMMvv6uZztE2y3udRmkZNHX32DSi7l
6YLq84EA/LyOtPp9jrRH1eKZLty5qyY2mO9Le46GAragc909SMnKpNAWJyV+RLLm
9fhn8sFnEUFKzDPptCkB
=WmVy
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
