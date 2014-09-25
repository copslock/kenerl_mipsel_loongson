Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 09:15:47 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:62659 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIYHPprhhUf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 09:15:45 +0200
Received: by mail-wg0-f43.google.com with SMTP id y10so7589437wgg.26
        for <multiple recipients>; Thu, 25 Sep 2014 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5Cc6n4wpKCdCj2AbO6o8njV8vV+t0WDRYgnr4jPLOEk=;
        b=InCaN1GZ89A9dFSrIZqYSQoNZIcTUpDKlEmCfa+ThR4S3FkQ+CXLPnWu1xrgQEYH+m
         tKe/vkXlANlLGbL/p5tze765rkyYhdji8pMbadAtQQj287iCNDPmhX/CjjUOLD8YbgJY
         q1gsIx/qKRLYqwOcnPt2n052lK8r9NNIIvRfbyYB59dQpcXZ0nUYOd3lSG08Z3SPfCip
         oB3d0bs/jb8ctQEJ5RjMmW03J4n+SWMJiKDriqIYzN17Q3C5+xW89p+gZ2pEaHYWdlRO
         vzZ7bsqy0gRTsLHXYzxGOVYzQzx+d1d2AuNCWsOsfRSKu8Ab6PfBVBB7obAUib0ctI8N
         LWNg==
X-Received: by 10.180.72.211 with SMTP id f19mr17184960wiv.39.1411629340556;
        Thu, 25 Sep 2014 00:15:40 -0700 (PDT)
Received: from localhost (port-55330.pppoe.wtnet.de. [46.59.216.211])
        by mx.google.com with ESMTPSA id q2sm2109075wiy.23.2014.09.25.00.15.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 00:15:39 -0700 (PDT)
Date:   Thu, 25 Sep 2014 09:15:38 +0200
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
Subject: Re: [PATCH v2 01/22] PCI/MSI: Clean up struct msi_chip argument
Message-ID: <20140925071536.GG12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <1411614872-4009-2-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42799
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


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:11AM +0800, Yijing Wang wrote:
> Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
> argument.

That's not true. Out of the four drivers that you modify two use the
parameter. And the two that don't probably should be using it too.

50% is not "rarely". =3D)

>           We can look up msi_chip pointer by the device pointer
> or irq number, so clean up msi_chip argument.

I don't like this particular change. The idea was to keep the API object
oriented so that drivers wouldn't have to know where to get the MSI chip
=66rom. It also makes it more resilient against code reorganizations since
the core code is the only place that needs to know where to get the chip
=66rom.

Thierry

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8EYAAoJEN0jrNd/PrOhKe8P+wRzEsusQS8lMmL8zyqvg5wy
x0Q4+eSI5aEkUEQz6Mtcld6eIwACphFOHeoDrAFauuxrjVqWslHdYAIAKbYoxG0e
xV9PJoc5PY24v4vnR5BvWEHxBfzfJ8QmFlDZGRvy3lqTPhTBOzLIbNUMO1gaoH1Q
MIzSjgl631075wZns41KNNx1TjCaXNeDwjkAyyX4bjJ7SL6ymrsxGo/zhCRCpZSk
2ks9AFoqFQoIOFeziuAW7WAx8BM9ah1ba5tc3oVZ6LC3JHrvoHZ5KCjITV75Geqb
dFzQh7Rx0yFdXVmNOX+O6XtFVvb7hNFELV1SAzQQXWl0Hyid6Dp0ZShKLSumNdG8
WvJFtUil25Prid9JVvpq+PrRGlbOucv0U+wi2cbdrE9/7UwtYoxAHNj/aTXdWwIv
d6ble8v0UT7l5Sk8QIFMI3VbatPqL/i+Mz8NijIKaMRug9/XmXZIN0Q05JhlbJ2b
/AWyYKLGAwYMrZcDU2v8CajO/NGUQ9D+mkqcN0NDsxmvP5woL6GC2tQzZABaAipF
LlbM5T6PfjxRfOvYNAIOJnttoirlQ4UI8CjVEeotPrchQalN7ZESvaHK0z2/Wrv1
kSvUiqTvOPtRaQn4rIs5MTi7tw5NBsG2MyWfy90WkITpn5vEYrX4JQITTUpa/x9B
IKT68Y/8ZFK3ksbjHtIe
=LSxe
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
