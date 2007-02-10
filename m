Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 02:54:37 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.169]:35541 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20039671AbXBJCyd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Feb 2007 02:54:33 +0000
Received: by ug-out-1314.google.com with SMTP id 40so100573uga
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2007 18:53:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UkYZZuIpgZR4Ry/237G0g7uzIlsLhl3AmWdAMeyWXA8cCXFmB/MIFt8jgC6AWt2QcVkUilr7j9BvFezblOJURQIlP0Y/9qeO29S6nH1Koizl5eu6Moi4boGghgGovv7ZoEv5lKXScujmj/Uet+URuAi6tRcdDyB5+6RWxeVB7us=
Received: by 10.78.181.13 with SMTP id d13mr65586huf.1171076010210;
        Fri, 09 Feb 2007 18:53:30 -0800 (PST)
Received: by 10.78.170.9 with HTTP; Fri, 9 Feb 2007 18:53:30 -0800 (PST)
Message-ID: <ecb4efd10702091853w195c576fs2c9559cae82b1224@mail.gmail.com>
Date:	Fri, 9 Feb 2007 21:53:30 -0500
From:	"Clem Taylor" <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: PCI troubles on Alchemy AU1550 in 2.6.20 (and 2.6.19.1)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I was wondering if anyone has any PCI devices working on an AU1550
with 2.6.20 or 2.6.19.1. I'm currently using 2.6.16.16 and I've been
trying to move to 2.6.20.

With 2.6.19.1 (including the resource_size_t patch) and 2.6.20,
reading from an address that is mapped with ioremap_nocache() is
returning the wrong data.

I also tried out the sata_sil driver which was working with 2.6.16.1,
but with 2.6.20 it seems unhappy:
sata_sil 0000:00:13.0: version 2.0
PCI: Enabling device 0000:00:13.0 (0000 -> 0003)
sata_sil 0000:00:13.0: cache line size not set.  Driver may not function
PCI: Setting latency timer of device 0000:00:13.0 to 64
ata1: SATA max UDMA/100 cmd 0xC0102080 ctl 0xC010208A bmdma 0xC0102000 irq 1
ata2: SATA max UDMA/100 cmd 0xC01020C0 ctl 0xC01020CA bmdma 0xC0102008 irq 1
scsi0 : sata_sil
ata1: SATA link up <unknown> (SStatus 208 SControl 2484F5B8)
scsi1 : sata_sil
ata2: SATA link up <unknown> (SStatus 1000FC08 SControl 2484F5B8)

It doesn't seem to be finding the disk.

With 2.6.16.16 it is happy:
libata version 1.20 loaded.
sata_sil 0000:00:13.0: version 0.9
PCI: Enabling device 0000:00:13.0 (0000 -> 0003)
sata_sil 0000:00:13.0: cache line size not set.  Driver may not function
sata_sil 0000:00:13.0: Applying R_ERR on DMA activate FIS errata fix
PCI: Setting latency timer of device 0000:00:13.0 to 64
ata1: SATA max UDMA/100 cmd 0xC0162080 ctl 0xC016208A bmdma 0xC0162000 irq 1
ata2: SATA max UDMA/100 cmd 0xC01620C0 ctl 0xC01620CA bmdma 0xC0162008 irq 1
ata1: SATA link down (SStatus 0)
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata2: dev 0 ATA-7, max UDMA/133, 1465149168 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: ST3750640AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 1465149168 512-byte hdwr sectors (750156 MB)
...

If I define CONFIG_RESOURCES_64BIT, then things get even worse, none
of the PCI devices show up. This would agree with what Alexander Bigga
saw without the resource_size_t fixups. I applied his patch to
2.6.19.1 and it seems to be in 2.6.20.

                         Any ideas?
                         Clem
