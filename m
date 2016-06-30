Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 23:57:33 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:47969 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993200AbcF3V50dZqtk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jun 2016 23:57:26 +0200
Received: from [192.168.10.229] (p4FF95A0C.dip0.t-ipconnect.de [79.249.90.12])
        by hauke-m.de (Postfix) with ESMTPSA id B24E510021B;
        Thu, 30 Jun 2016 23:57:25 +0200 (CEST)
Subject: Re: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        Larry Finger <larry.finger@lwfinger.net>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Wassi <p.wassi@gmx.at>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <a7c6d774-69d2-0a82-50fb-c18bc8719e7f@hauke-m.de>
Date:   Thu, 30 Jun 2016 23:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 06/16/2016 08:17 AM, Rafał Miłecki wrote:
> Hello,
> 
> From time to time I test new kernels with ancient Linksys WRT300N v1.0
> device based on BCM4704 SoC.
> 
> I noticed that after updating kernel from 4.3 to 4.4 it doen't boot
> anymore. All I can see is the last CFE's (bootloader's) message:
>> Starting program at 0x80001000
> Enabling CONFIG_EARLY_PRINTK doesn't help.
> 

Hi, I just tested this on two of my older bcm47xx devices and I had no
problem with kernel 4.4.14 from LEDE with all the LEDE patches:

Asus WL500GP V1:
CFE version 1.0.37 for BCM947XX (32bit,SP,LE)
Build Date: �| 10�� 12 22:21:19 CST 2006 (root@localhost.localdomain)
Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.

Initializing Arena
Initializing Devices.
et0: Broadcom BCM47xx 10/100 Mbps Ethernet Controller 3.90.7.0
rndis0: Broadcom USB RNDIS Network Adapter (P-t-P)
CPU type 0x29006: 264MHz
Total memory: 33554432 KBytes

Total memory used by CFE:  0x80800000 - 0x8089AF40 (634688)
Initialized Data:          0x808313D0 - 0x80833790 (9152)
BSS Area:                  0x80833790 - 0x80834F40 (6064)
Local Heap:                0x80834F40 - 0x80898F40 (409600)
Stack Area:                0x80898F40 - 0x8089AF40 (8192)
Text (code) segment:       0x80800000 - 0x808313D0 (201680)
Boot area (physical):      0x0089B000 - 0x008DB000
Relocation Factor:         I:00000000 - D:00000000

Device eth0:  hwaddr 00-1A-92-EA-73-12, ipaddr 192.168.1.3, mask
255.255.255.0
        gateway not set, nameserver not set
Null Rescue Flag.
Reading :: TFTP Server.
Failed.: Timeout occured
Loader:raw Filesys:raw Dev:flash0.os File: Options:(null)
Loading: .. 3800 bytes read
Entry at 0x80001000
Closing network.
Starting program at 0x80001000
[    0.000000] Linux version 4.4.14 (hauke@hauke-desktop) (gcc version
5.3.0 (LEDE GCC 5.3.0 r829) ) #1 Thu Jun 30 20:49:41 UTC 2016
[    0.000000] CPU0 revision is: 00029006 (Broadcom BMIPS3300)
[    0.000000] bcm47xx: Using ssb bus
[    0.000000] ssb: Found chip with id 0x4704, rev 0x09 and package 0x00




Linksys WRT54G/GS/GL:
CFE version 1.0.37 for BCM947XX (32bit,SP,LE)
Build Date: Fri Jun 25 15:49:22 CST 2004 (root@Amin)
Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.

Initializing Arena.
Initializing Devices.
et0: Broadcom BCM47xx 10/100 Mbps Ethernet Controller 3.60.13.0
rndis0: Broadcom USB RNDIS Network Adapter (P-t-P)
CPU type 0x29007: 200MHz
Total memory: 0x2000000 bytes (32MB)

Total memory used by CFE:  0x80300000 - 0x8043DF30 (1302320)
Initialized Data:          0x803381A0 - 0x8033A550 (9136)
BSS Area:                  0x8033A550 - 0x8033BF30 (6624)
Local Heap:                0x8033BF30 - 0x8043BF30 (1048576)
Stack Area:                0x8043BF30 - 0x8043DF30 (8192)
Text (code) segment:       0x80300000 - 0x803381A0 (229792)
Boot area (physical):      0x0043E000 - 0x0047E000
Relocation Factor:         I:00000000 - D:00000000

Boot version: v3.2
The boot is CFE

mac_init(): Find mac [00:0F:66:D3:94:95] in location 1
Nothing...

No eou key find
Device eth0:  hwaddr 00-0F-66-D3-94-95, ipaddr 192.168.1.1, mask
255.255.255.0
        gateway not set, nameserver not set
Reading :: Failed.: Timeout occured
Loader:raw Filesys:raw Dev:flash0.os File: Options:(null)
Loading: .. 3800 bytes read
Entry at 0x80001000
Closing network.
Starting program at 0x80001000
[    0.000000] Linux version 4.4.14 (hauke@hauke-desktop) (gcc version
5.3.0 (LEDE GCC 5.3.0 r829) ) #1 Thu Jun 30 20:49:41 UTC 2016
[    0.000000] CPU0 revision is: 00029007 (Broadcom BMIPS3300)
[    0.000000] bcm47xx: Using ssb bus
[    0.000000] ssb: Found chip with id 0x4712, rev 0x01 and package 0x00
