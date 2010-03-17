Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 07:05:07 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:3756 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491080Ab0CQGFD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Mar 2010 07:05:03 +0100
Received: from [10.16.192.232] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 16 Mar 2010 23:04:51 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from SJEXCHCCR01.corp.ad.broadcom.com ([10.252.49.130]) by
 SJEXCHHUB02.corp.ad.broadcom.com ([10.16.192.232]) with mapi; Tue, 16
 Mar 2010 23:04:51 -0700
From:   "Ramgopal Kota" <rkota@broadcom.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Tue, 16 Mar 2010 23:04:49 -0700
Subject: HIGHMEM not working.
Thread-Topic: HIGHMEM not working.
Thread-Index: AcrBK3wkk2FBNl+9TaOxNHDqJxz80AEZusdwAAEpc2A=
Message-ID: <6C370B347C3FE8438C9692873287D2E1109DDF0073@SJEXCHCCR01.corp.ad.broadcom.com>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546AC862322@xmail3.se.axis.com>
 <6C370B347C3FE8438C9692873287D2E1109DDF0057@SJEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <6C370B347C3FE8438C9692873287D2E1109DDF0057@SJEXCHCCR01.corp.ad.broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 67BEAE8931G62159373-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <rkota@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkota@broadcom.com
Precedence: bulk
X-list: linux-mips

 Hi,

I need help in running CPU with HIGH_MEM.
Below is the processor memory map .. It is base on MIPS64K Core.

0x0000_0000  -- 0x07FF_FFFF   -> RAM (Region 1)
0x0800_0000  -- 0x0FFF_FFFF   -> PCI BUS 1
0x2000_0000  -- 0x2FFF_FFFF   -> Flash Region
0x4000_0000  -- 0x47FF_FFFF   -> PCI BUS 2
0x8000_0000  -- 0xCFFF_FFFF   -> RAM (Region 2) the first 128MB is remapped into 0x8000_0000 .. 

The system has 256MB of PHYSICAL RAM .. 

I configured TLB's and added memory regions. The system boots up correctly ..
If I show cat /proc/meminfo it shows 256MB , it could allocate memory ( I verified with a simple program allocating the memory and writing some data)

There is a PCI MAC device on PCI BUS 2. The CPU is not able to perform DMA to/from device.
The MAC driver is allocating DMA buffers using the following code ..
{
    phy = virt_to_bus(high_memory);  << Resulting in 0xa000_0000; 
    virt = ioremap(pbase);    
}
The Linux configuration has no ZONE_DMA configuration ..

Few questions ..
  A) HIGH_MEMORY START Address is configured to 0x2000_0000 , is it correct value.
  B) Are there any data which can be dumped to know more information ?
  C) Do I need to enable MEMORY Discontinuous Config also ?  ( As I did not see a reason to enable this as memory in Region 2 is contiguous)
  D) I read in some articles on internet that if HIGH_MEM is used,PCI bounce buffers needs to be used ? Can some body point me how to set this up ?

Thanks & Regards,
Ramgopal Kota
