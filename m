Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 10:09:58 +0200 (CEST)
Received: from mail-we0-f181.google.com ([74.125.82.181]:42685 "EHLO
        mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008039AbaIZIJ4fqNC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 10:09:56 +0200
Received: by mail-we0-f181.google.com with SMTP id w61so7337476wes.40
        for <multiple recipients>; Fri, 26 Sep 2014 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yp3gFGYu5NNnX9hZ6DIF69feMU5kROgGPefkH1RbFhQ=;
        b=WAbadhZUU6XzeZgxAV9UdmyqmAIlTpFgCEedsvakqopkQXqMNh1viSJ+dMTIzywmUK
         hvuTlGnmKf4Y7W6ZCmFyv4lv8dGyxfxSQpDQhvzR2TIzp21/grTv4HJRJ1qOA69eesiu
         f3opAdI5vbnInFMZhDOq5kvsflX/1NkwKVFyuOtAhbC2o4FhFXNYuqu0MtmKFSphzF1S
         /uTt13qpHWOB80jtJjgw6bdmVgeOJrE2CZTsz0/e49efe+cI8Gx3XZWxpDzZ9zqj2lXQ
         duepMrRJN55QJV1wmADfyA6D4WaIhyYNQ6TrLFgUagx+/tlKWbHjn86uQsJv8CAt27BM
         oSwA==
X-Received: by 10.194.157.230 with SMTP id wp6mr4766411wjb.15.1411718991337;
        Fri, 26 Sep 2014 01:09:51 -0700 (PDT)
Received: from localhost (port-6838.pppoe.wtnet.de. [84.46.26.208])
        by mx.google.com with ESMTPSA id l4sm5269565wje.5.2014.09.26.01.09.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2014 01:09:50 -0700 (PDT)
Date:   Fri, 26 Sep 2014 10:09:49 +0200
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
Message-ID: <20140926080949.GF31106@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42835
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


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> use irq chip_data to save the msi_chip pointer. They
> already call irq_set_chip_data() in their own MSI irq map
> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> is useless.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 51d7e62..50f67a3 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -41,14 +41,13 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, st=
ruct msi_desc *desc)
>  	if (err < 0)
>  		return err;
> =20
> -	irq_set_chip_data(desc->irq, chip);
> -
>  	return 0;
>  }
> =20
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> -	struct msi_chip *chip =3D irq_get_chip_data(irq);
> +	struct msi_desc *entry =3D irq_get_msi_desc(irq);
> +	struct msi_chip *chip =3D entry->dev->bus->msi;
> =20
>  	if (!chip || !chip->teardown_irq)
>  		return;
> --=20
> 1.7.1
>=20

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJR9NAAoJEN0jrNd/PrOh5cAP/2aYAkwGt796/z3rQsXfEXhG
hPI6dXwueP4Re7P03WrSfn6JEowEsDYFLqLJJYQLwlDQa96WTd85jidBUhQRniqy
GPHoUY+c4qiQjJak+b2y4jMMNqJnWoLw57Wd1Nmy2g2pocWKwiKA1VEem2ZZPaxR
QxhYqhwK8IxOu092oPpVV8m2GtFSUzbuOoE0a3muYP+gExweDN6v485fm+PKfIVU
rmCMnmkkT9oUVNYUlQDSf0xXb+t0PNJDbGZHPM3rKQFQA45Xhadzs2D/nk1CSwoj
7EO8sq/qkfHnyXvxpvazxq2V1xsGkG63RTRmhIzP2VGDj/AI6G9AlM5dFOzPctSf
8v8FNLESIHmHKyp9IKT1pCWg6jbRHFlhL9be5+uudiDYgvXiGjtco4Jta1hlgHNk
Qd7zRsH6Y+ocewQ2sqDMrwkOEzetOfnGmjjtb3q6VaeahtwPdRKWhQcjfO//zIW3
83yoON4lx7AS1aDMRywNXbk8A6ja8ndVS2amfm6TJCbIVy6A78AnCRx4n/ShluFl
WD1TekKOyh2u2JtRagRSb0xxFwwsqzlYrOElj00zxCZJAKihIzjMf4ogfxnj2OOn
ZEF1WTMpjTpy+QB7r22R0qFX9yVBBCgRM8heGbQXeVMPD/AvmVhx803Ry2r6SmcU
iefPiqiqqocKKcpN4rMB
=jw7p
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
