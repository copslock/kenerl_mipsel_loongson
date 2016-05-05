Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2016 03:36:45 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36731 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027436AbcEEBgnIwMId (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 May 2016 03:36:43 +0200
Received: by mail-pa0-f45.google.com with SMTP id bt5so29826551pac.3;
        Wed, 04 May 2016 18:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=SOzwKKjcrmIaSMLHHkSw2HU6+JyiJcjHt8mwdEHNAUg=;
        b=Njh267kXlwU/2BeLMJe+BVSIpjwCrms2RY0z1JLKgejOPppTJfM3w6jBh5hzADpcI/
         sHrzfvoKFq0HTdlUlbBl9M/2hJ20+A2qFiM87Mu5GD7dclrz4INFv7U+gdkdo/qOIgbV
         /zlwg48pNizTcDYkoialfapCvlvN4uG7QPxHb8Bx3GdDRSmp/4R3zMBskUSgIuyAzD0A
         wnA4neSyVR8OHDG3UcRsqBggsTn+HPADQ6LGJvR56k82vQj2AixKeMAsBdwhsbYkvxv+
         38EdaloU9UGK8HYQQxd1q/Cj6XNvNR5EKrfc0U2F0bTwA+g0y1EWYunU01FcQ0rFGNQd
         iuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SOzwKKjcrmIaSMLHHkSw2HU6+JyiJcjHt8mwdEHNAUg=;
        b=Rh8PkzGTU5374dMTVaWUzXs22+qsVdiQUf6DVIw7uISzNgyi9fiW0FsIri/rO0kcoJ
         mKUtwOB8f84SIItTxmXdhOFeyF+7YWfTf2g1Z92PbFw3ZId691vDNyFx9hdvY5zxNeqG
         7IU7lZP4r3LPC0gAwFfluH0mihKOu/jRdixDohdzznuE9HjaL5IcTn8X2nkObTHFUhf6
         9EmMR2vCRRTenaWHIwBRME8GAj5YA2r4apuHl2MR3JwKs+Mb4u1GoLFpFEVfhwLqcqog
         Dk4JUdpagapXDsumWoTZ9SgUGuyqg/SBXuNmVduGgbYnqyy5ZqX5en9+iQOLt87UnOzE
         VFaw==
X-Gm-Message-State: AOPr4FWaX+bkNjztCAWeO7HoJ/Ut7+6q2X1g3/smq+6IzcXVGLCF7afwiHZW6EZKsxax9g==
X-Received: by 10.66.177.75 with SMTP id co11mr16884752pac.85.1462412196549;
        Wed, 04 May 2016 18:36:36 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id w125sm8874423pfb.53.2016.05.04.18.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2016 18:36:35 -0700 (PDT)
Subject: Re: [PATCH v2 03/15] MIPS: PCI: Compatibility with ARM-like PCI host
 drivers
To:     Paul Burton <paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <1454499045-5020-4-git-send-email-paul.burton@imgtec.com>
 <56FB0D90.8000200@gmail.com> <20160404100940.GA21568@NP-P-BURTON>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        Yijing Wang <wangyijing@huawei.com>,
        John Crispin <blogic@openwrt.org>,
        Yinghai Lu <yinghai@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <572AA3A0.5080201@gmail.com>
Date:   Wed, 4 May 2016 18:36:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160404100940.GA21568@NP-P-BURTON>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi Paul,

On 04/04/16 03:09, Paul Burton wrote:
> Hi Florian,
> 
> Just an FYI, the pcie-xilinx driver I wrote this for has since been
> converted away from the ARM-like pci_common_init_dev & struct hw_pci to
> use only functions provided by the core PCI subsystem[1]. As a result
> I've stopped using this patch & don't plan to continue work on it.
> Perhaps it would be cleanest to do a similar conversion for the driver
> you're using?

Yes, I did just that, but as of v4.6-rc6, I am seeing a bunch of
undefined references while doing so:

arch/mips/pci/built-in.o: In function `pcibios_enable_device':
(.text+0x550): undefined reference to `pcibios_plat_dev_init'
arch/mips/pci/built-in.o: In function `pcibios_init':
pci.c:(.init.text+0x6c): undefined reference to `pcibios_map_irq'
pci.c:(.init.text+0x78): undefined reference to `pcibios_map_irq'

and this makes perfect sense because arch/mips/pci/pci.c is referencing
those functions, while I did not add anything for BMIPS_GENERIC.

At this point, I would very much prefer that the MIPS/Linux kernel did
not rely on the different machines to provide those implementations
(though it definitively is not a big deal to add them, it just feels
unnecessary), I will try to cook a patch for that and provide dummy
fallbacks.

Thanks!
-- 
Florian
