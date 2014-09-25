Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:37:10 +0200 (CEST)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:58006 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIYHhIYzMmP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:37:08 +0200
Received: by mail-wg0-f42.google.com with SMTP id a1so6889391wgh.13
        for <multiple recipients>; Thu, 25 Sep 2014 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q2t/TON9LNCLPcpskdxiO/+pmitEpNqzpcXY3U83BWM=;
        b=yp4J1wO1qibsNyQmTaClCi+PJz73Ol4mooWRwYeoX9hpTbhWsM52AKJ2zkEfTOvR5z
         r4K545YwjhJHKAfswT5LvtE1p8efyEAUJEIViL9ML5ngZJcpwvbwVkie80e2QPySH8tL
         qaIOnBYFST/aH+FjTo7Aa9aiSGT3pMlwSsBvn9KtGJK159Z3+J7TUQ3dgcAAimKGBAL9
         rU0d3CvsHCU15seIHcYl/h4R+VDT+K5cwwuYY3b79mX72dk3MccmFSULNkPLhx+nrlJm
         40CFngLHPLaIE+5dWsn092+1dBPY2JGmQdegaFzrvp32hi5sHhcycQDfkOhOEHmL7FYx
         4OIQ==
X-Received: by 10.180.187.76 with SMTP id fq12mr16869775wic.4.1411630623224;
        Thu, 25 Sep 2014 00:37:03 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id ia3sm1740135wjb.12.2014.09.25.00.37.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:37:02 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:37:01 +0200
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
Subject: Re: [PATCH v2 15/22] MIPS/Xlr/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Message-ID: <20140925073700.GL12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-16-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nrM5Z5VIJgwP9LWp"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-16-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42804
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


--nrM5Z5VIJgwP9LWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:25AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
[...]
> @@ -214,11 +214,11 @@ static int get_irq_vector(const struct pci_dev *dev)
>  }
> =20
>  #ifdef CONFIG_PCI_MSI
> -void arch_teardown_msi_irq(unsigned int irq)
> +void xlr_teardown_msi_irq(unsigned int irq)
>  {
>  }
> =20
> -int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +int xlr_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)

Can both of these now be static?

Thierry

--nrM5Z5VIJgwP9LWp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8YcAAoJEN0jrNd/PrOhmbYP/ikLBs/f/C3q0Ah+1wm0yIQ9
biLioTIcSkRAsIfmKvheDIwFqrlfVwxThhAFT1+1x9N/KgeZ0hTm7/ZzogCQEn9J
J90nv0Y1KRdY/exT1wfgVEFtITGMGqDKTScawCJSoqc/4iswAtYkap3QdftgmyDU
acFImPmiT5rTaF3oQXhgNTgRcMMsdGOYJg/64K0snGcBGCNDYr4ZutMiEzof/G7O
w5KUk61xP+tvpYWRebsG/ivvFVWXNwVnpAOPAq+j6ziVxLlFLvY/r7QZ0Z95kSTj
AqufUg6h2cePrzW3VGxKJ5HL0eLS43pMofUkRFqcNv/BEeE8ZEg5wd2mNCtAroXb
fG5+KClUrEYZ28WO5d7Bagvekb00O2SYJ6HQW9WoASguiLfMMGa0g9w8SxmES0Gv
axepd0VObagoL/0lUjvSs73S39kzWsShRysZ9hCEsox1Xt3kinX3wwIP+k97dsKC
LAyXKNzxzU5xtlsZONRwRx2SsBRnUApH6CgDE5SOBgSAM+Juuk/e4NES7iTHW1iA
7DrbU7XWcMc/SLbIanZv3gig1WuNUR011kUZ9cerQpTMZ5JX+pR/f59jbtgexuEt
2lqvEs5pj2RZfiZy+pl21B1hMz7UPuQm8Hw0NMsXQP9wPcDwLzYAqT7uhHdaBhLV
4rVgrCyYNcw+4+MK/Nhv
=crca
-----END PGP SIGNATURE-----

--nrM5Z5VIJgwP9LWp--
