Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:38:10 +0200 (CEST)
Received: from mail-we0-f174.google.com ([74.125.82.174]:56792 "EHLO
        mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007194AbaIYHiIijnqn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:38:08 +0200
Received: by mail-we0-f174.google.com with SMTP id w62so7007670wes.33
        for <multiple recipients>; Thu, 25 Sep 2014 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6rLojZGON83WXLxZK+g7tNbcm1em7XaEjEKFh8TVGKM=;
        b=J813lj0I0rZlvLhygRh0hGaOs6+EqXjG1IiZ4wKzxF4O/BHpRYbs4I/lvlOxGREn3p
         0qTjdDjBQNyKhcAppRW9UjijRSzq88wDRsIsWprMxzH8dpdY3kDtkdlvYiP+wihCt6uh
         vhV4eeUjFXEO0l4WdvjQMX3gG510dhhX7D+b1UPX8n378vHzgm92XfNVyFFixQ7ZoAtq
         /rg2sy+0c/wixLvZchwM6swDc2DnjjhK7OlU3hd4wfvGmC7n6EutSs422/uhjx5cB7yh
         dBR8rl66l2Wnf3F66x6wlUFBIoad7pbJKo9QxKWXpFLCnR7tuiE17aHzSOO/TaY0FVBe
         neow==
X-Received: by 10.180.98.131 with SMTP id ei3mr23477228wib.46.1411630683415;
        Thu, 25 Sep 2014 00:38:03 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id wx3sm1732858wjc.19.2014.09.25.00.38.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:38:02 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:38:01 +0200
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
Subject: Re: [PATCH v2 17/22] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Message-ID: <20140925073800.GM12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-18-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W4pDZ/VvazBYHhxQ"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-18-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42805
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


--W4pDZ/VvazBYHhxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:27AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
[...]
> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>  	}
>  }
> =20
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)

static?

--W4pDZ/VvazBYHhxQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8ZYAAoJEN0jrNd/PrOhT54QAIN9jc2i8zDFXQP0O2xLX151
K/0a6f2Ke1ts4th35u5jkXxtnjEubc8RMuU2k+Dft0pOk1wQqfi7CmdJtG+MrGqI
IZ78syU0TLzw2I2IhhCW/qIrc0eK9gcVpY5FnYxNGNsErYVOHB5w2lqj65UXkrK1
KuKTi4wk7SBfs7D0I7UVe9CjiGte3h4Wkm0FExDPekBjlb+NheufDExalF1vv5VW
Y/Ers3FW9kjTCLWHf+wS7Sg7a/uq8PfTG3hkn7ja7ykCouBoheB+pb1OmV5boizz
/H9TvN+P3WCd3TCe0pz5qI8icntR/5V09HiM3OM1sGqwWopvZgKiw8RSXwJMKdb3
4NsDxyu6glUOMpuFyDxzQ+iC94LeTq1L4C4oTfrdMdCQetJQm1DxWQYo4iPy1Luz
cyWf37Gr7RoNuPlx++ONPfub8xDPP6LpDm7Jf1ztIuHNRnN0D/EYNP/3W6s2en4w
0n4URoSBn7blmJQPOKQ+oNkw295vAc0bSU+NlqjdnpMhJq/Aq+olHB4Of97IKXtk
7lLqyJAX6ISNs302AVES9Wch7UW6MWrlpxiQk3HkGZBvFExbGCTD806d0wr9+V9Y
XcvfTABfe5ycOd28a4HwZx0BpglxbMRwarqwdwhpA9H0500K4lmTPrzZLVY+B0AB
UxhsWg3u+nU6NtiAWuwY
=lpw6
-----END PGP SIGNATURE-----

--W4pDZ/VvazBYHhxQ--
