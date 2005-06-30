Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 00:55:57 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.202]:42141 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226113AbVF3Xzi> convert rfc822-to-8bit;
	Fri, 1 Jul 2005 00:55:38 +0100
Received: by wproxy.gmail.com with SMTP id 70so234930wra
        for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 16:55:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S+h2cSFVfMLfEVq8ziTAv7KV6T2imsySwIPKIxtyX5RfRD9+7S2yS7g+1zihSMojhUXyEi3eIe/2bsS1/zV4E7wVl1i4zgeQrG7pxPg+5JbCnFnuU4KZgHMYb6o3kuAjLbjfw5dgBnzzJu5xexTgMMBC+esqvJ89GpQgB58+Vfk=
Received: by 10.54.38.64 with SMTP id l64mr795705wrl;
        Thu, 30 Jun 2005 16:55:25 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 30 Jun 2005 16:55:25 -0700 (PDT)
Message-ID: <2db32b720506301655542c8c15@mail.gmail.com>
Date:	Thu, 30 Jun 2005 16:55:25 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: ide support on db1550 of linux 2.4.31
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I just made the multi-port work on db1550. The problem is due to the
misplacement of the UART register. So if anybody else want to run
other boards on db1550, make sure you use the UART register address of
your "own boards", not au1000.h. Thanks for the help.

Now I am trying to support a IDE/CompactFlash adapter. I patched the
kernel as other mentioned, forcing HPT371N to use the timing of
HPT372N. But got no luck to succeed.  The output is:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT371: IDE controller at PCI slot 00:0b.0
HPT371: chipset revision 2
HPT371: not 100% native mode: will probe irqs later
hpt: HPT372N detected, using 372N timing.
FREQ: 73 PLL: 35
hpt: no known IDE timings, disabling DMA.
hpt: no known IDE timings, disabling DMA.
probing for hda: present=0, media=32, probetype=ATA
probing for hda: present=0, media=32, probetype=ATAPI
probing for hdb: present=0, media=32, probetype=ATA
probing for hdb: present=0, media=32, probetype=ATAPI
probing for hdc: present=0, media=32, probetype=ATA
probing for hdc: present=0, media=32, probetype=ATAPI
probing for hdd: present=0, media=32, probetype=ATA
probing for hdd: present=0, media=32, probetype=ATAPI
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
probing for hdg: present=0, media=32, probetype=ATAPI
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
probing for hdi: present=0, media=32, probetype=ATA
probing for hdi: present=0, media=32, probetype=ATAPI
probing for hdj: present=0, media=32, probetype=ATA
probing for hdj: present=0, media=32, probetype=ATAPI
probing for hdk: present=0, media=32, probetype=ATA
probing for hdk: present=0, media=32, probetype=ATAPI
probing for hdl: present=0, media=32, probetype=ATA
probing for hdl: present=0, media=32, probetype=ATAPI

Any idea what is happening here?

thanks
