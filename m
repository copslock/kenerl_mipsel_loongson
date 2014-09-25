Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:36:19 +0200 (CEST)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64720 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIYHgQtPaCN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:36:16 +0200
Received: by mail-wg0-f44.google.com with SMTP id z12so3553493wgg.3
        for <multiple recipients>; Thu, 25 Sep 2014 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZrnXqACxgJlDYBQtbgEmF7W8KL5gRWOwuaC4X0jOH9o=;
        b=P7r91BYOGU/Wmo+EmxqQMr8VriPXS4PN9L7fbE9Z62LFeDQhdEPWAZ7vzE1XsYnNl6
         T47t7tXVSrD7rxJsyxRcTQTF6t1dEIU2nSaNrCHlvoYW4BLsgd3hvFt/OTIqOE3MjOlG
         FhF3bTTj4Sk5U7+QbMTT9yciCCwuUsnF9nG7MnpN/G7nWtRS0rEeElVeX539MulC7qaJ
         GejqvqI1JNdxkjXON5MAMmUe3awbNtE75EjEvn4SLzIJUK4IiBk/vaoPVo6dtjpnS3b4
         r5+gEzorhb07FDMGpKZ2uKYbGIqhvMEJklIdierCDSvnDRYOo9OmT/2qxC5oX79yrl7F
         j/EQ==
X-Received: by 10.194.191.135 with SMTP id gy7mr13427397wjc.39.1411630571582;
        Thu, 25 Sep 2014 00:36:11 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id lu12sm8274722wic.4.2014.09.25.00.36.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:36:10 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:36:09 +0200
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
Subject: Re: [PATCH v2 14/22] MIPS/Xlp/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Message-ID: <20140925073608.GK12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-15-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6K2R/cS9K4qvcBNq"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-15-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42803
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


--6K2R/cS9K4qvcBNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:24AM +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Nit: s/irq/IRQ/ in the above.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/mips/pci/msi-xlp.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
> index e469dc7..6b791ef 100644
> --- a/arch/mips/pci/msi-xlp.c
> +++ b/arch/mips/pci/msi-xlp.c
> @@ -245,7 +245,7 @@ static struct irq_chip xlp_msix_chip =3D {
>  	.irq_unmask	=3D unmask_msi_irq,
>  };
> =20
> -void arch_teardown_msi_irq(unsigned int irq)
> +void xlp_teardown_msi_irq(unsigned int irq)

Should this not be static now as well?

Thierry

--6K2R/cS9K4qvcBNq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8XoAAoJEN0jrNd/PrOhrs4P/Rg10uO2/sCyBwOPDpHaskVO
8blYsnipag0xv7pyGtAeiEVLgpzcQpv+zjXPmti+R1qI1OVkUXblvYhNtz/CDMvg
AN6CaoZI3llRg3fZwiayj3m/i1HpiXTPqYPK3sWanCUMmZJe73eUj8zMt6bH7yPG
WsuUwWTrc2hcscIDucigcNopQ0fuh0vLYLWgiZe+qJdJIrvGkvGN4h0pHuqIkk0o
DUyMUme8HOL1irxSWYnnmkTPx3TOAWDn7VJVxJgpIKEG0A/X1GCi/4wCkMMxtuxH
1V0aRu/k9AsOR5BVDROfyZCHvuTVLZeXP54ehWxAyA1GwS55Z36FNsl/JLtZ2WhO
95CX6ac9NMDLgmGr9W19SAffXn47Yy/1fvK5zq0F+taK005ajIxufmnoSVrzZsH8
dS8MoFslKB8B2EKW5874CFVUKGx5hZTARp12WWvTfJehLTYfJNpSpdjRdI7LBggj
/PNzvpDkiwwSVzXcJUU45wOZvaS0ImoH3Xn2GF91D/kO+jfFc52lI8Tv8Ixw7Hgl
pJObojrzrQJe20K2NJP9xuCNXUXiI0/EbfwZf/MxE5u/FSxigS8vajMY8CFMlQ5N
4sSi2qWsKa2ZrGMo5dyDfblWSjy1U1O752LQXn+8ddng18wDV/tk/tzZU0Xsywy6
jGgaMyNaRi22AESZhUqv
=xvjk
-----END PGP SIGNATURE-----

--6K2R/cS9K4qvcBNq--
