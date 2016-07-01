Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2016 16:00:17 +0200 (CEST)
Received: from mout.gmx.net ([212.227.17.21]:61487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995081AbcGAOAIYXpV6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2016 16:00:08 +0200
Received: from [85.13.11.248] by 3capp-gmx-bs64.server.lan (via HTTP); Fri,
 1 Jul 2016 15:59:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-1979daaa-4eae-4604-9546-c73e7caa6a30-1467381583006@3capp-gmx-bs64>
From:   p.wassi@gmx.at
To:     "Hauke Mehrtens" <hauke@hauke-m.de>
Cc:     =?UTF-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "David Daney" <ddaney.cavm@gmail.com>,
        "David Daney" <david.daney@cavium.com>,
        =?UTF-8?Q?=22Michael_B=C3=BCsch=22?= <m@bues.ch>,
        "Larry Finger" <larry.finger@lwfinger.net>,
        "Felix Fietkau" <nbd@nbd.name>, "John Crispin" <john@phrozen.org>
Subject: Re: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 1 Jul 2016 15:59:43 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <a7c6d774-69d2-0a82-50fb-c18bc8719e7f@hauke-m.de>
References: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>,
 <a7c6d774-69d2-0a82-50fb-c18bc8719e7f@hauke-m.de>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K0:hPGmUPYkQpx3ps2Zw3GjoJhFOpD8hJrD/4dH9QR7LB+
 VPeDEqnypw0QwzW1zzzjOT4EMyDNOzdY7md2iUSmwMb7ggsnEg
 AFUUd2O0Puh82/Cc3RwbgOQ/cp1K6gB/gAtF4OHUgNob3d5nMk
 /X3THLsd+is32u24vJIr0iBcPcg3rLYGxXeqdcEAeRjs/aECnu
 OSfDb6icKHAM40du8u2y3JYJYSD5oUOHTa35VOI4UzfPqBc2w+
 bG9aPXxkIFDxPduZVYp5PnGoC9wvFh4F5xPbyXnn1RenH87lZn nzihWc=
X-UI-Out-Filterresults: notjunk:1;V01:K0:cCatXr2WWqU=:DSOasLwTSHMNwqmskHbXa/
 fscC/voL+C/GKGa5CjiukIk/4NC2Za17HAejMBfln9bnDqQcDNb9oAbE+EcffKKgY2U+bLYRB
 APUrZHm1cst1gkK8Ku5N6TPEJM0MWISDiSYbaGf47P926Ht3f5/g4UiYd75+unz4XqJcde65q
 hjmvaovjzmx5T47kmxNVg5WtcQMSWItuGVJ9RG6RWwKBPDUzCJ9/RdbMOdcfIyzM4cQk9iI9b
 iZJBdqprLlToeI+QU7h7xANI9lMNHWjOQIug+JA6boGPdd5BJq3hU8z7+dWMA7FHlIuqXFm4f
 o1kDe1y+Rxso2jNgqYNSSD9V1UI2C/2dYPfJZ/30WbM5q4Sk9II2tGa23PapCLZJ3yoxw2YeB
 DF7SmygOvHJhBEDKmuGIskOavAe6TkuiwUcscXjrEx5eLigEO1blsiG6awUtaGGymYo/N7Wt7
 kyiXsm0qnQ==
Return-Path: <p.wassi@gmx.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.wassi@gmx.at
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

Hi Hauke,

I also had no problem with booting 4.4 on my bcm47xx legacy devices.

I just tested again with LEDE's current trunk:
[1] does not boot on WRT54GL
As already said: if I clone the repo and build it myself, the device
boots perfectly fine (on 4.1 and 4.4)
Can you confirm, that [1] does not boot on your WRT54G/GL/GS?

In my opinion it's hard to discuss kernels not booting
as long as the builds are not reproducable or deterministic.
Maybe we can first figure out why [1] doesn't boot on some devices.

Best regards,
P. Wassi

[1]:
https://downloads.lede-project.org/snapshots/targets/brcm47xx/legacy/lede-brcm47xx-legacy-standard-squashfs.trx


> Hi, I just tested this on two of my older bcm47xx devices and I had no
> problem with kernel 4.4.14 from LEDE with all the LEDE patches:
> 
> Asus WL500GP V1:
> CFE version 1.0.37 for BCM947XX (32bit,SP,LE)
> Build Date: �| 10�� 12 22:21:19 CST 2006 (root@localhost.localdomain)
> Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.
> 
> Initializing Arena
> Initializing Devices.
> et0: Broadcom BCM47xx 10/100 Mbps Ethernet Controller 3.90.7.0
> rndis0: Broadcom USB RNDIS Network Adapter (P-t-P)
> CPU type 0x29006: 264MHz
> Total memory: 33554432 KBytes
> 
> Total memory used by CFE:  0x80800000 - 0x8089AF40 (634688)
> Initialized Data:          0x808313D0 - 0x80833790 (9152)
> BSS Area:                  0x80833790 - 0x80834F40 (6064)
> Local Heap:                0x80834F40 - 0x80898F40 (409600)
> Stack Area:                0x80898F40 - 0x8089AF40 (8192)
> Text (code) segment:       0x80800000 - 0x808313D0 (201680)
> Boot area (physical):      0x0089B000 - 0x008DB000
> Relocation Factor:         I:00000000 - D:00000000
> 
> Device eth0:  hwaddr 00-1A-92-EA-73-12, ipaddr 192.168.1.3, mask
> 255.255.255.0
>         gateway not set, nameserver not set
> Null Rescue Flag.
> Reading :: TFTP Server.
> Failed.: Timeout occured
> Loader:raw Filesys:raw Dev:flash0.os File: Options:(null)
> Loading: .. 3800 bytes read
> Entry at 0x80001000
> Closing network.
> Starting program at 0x80001000
> [    0.000000] Linux version 4.4.14 (hauke@hauke-desktop) (gcc version
> 5.3.0 (LEDE GCC 5.3.0 r829) ) #1 Thu Jun 30 20:49:41 UTC 2016
> [    0.000000] CPU0 revision is: 00029006 (Broadcom BMIPS3300)
> [    0.000000] bcm47xx: Using ssb bus
> [    0.000000] ssb: Found chip with id 0x4704, rev 0x09 and package 0x00
> 
> 
> 
> 
> Linksys WRT54G/GS/GL:
> CFE version 1.0.37 for BCM947XX (32bit,SP,LE)
> Build Date: Fri Jun 25 15:49:22 CST 2004 (root@Amin)
> Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.
> 
> Initializing Arena.
> Initializing Devices.
> et0: Broadcom BCM47xx 10/100 Mbps Ethernet Controller 3.60.13.0
> rndis0: Broadcom USB RNDIS Network Adapter (P-t-P)
> CPU type 0x29007: 200MHz
> Total memory: 0x2000000 bytes (32MB)
> 
> Total memory used by CFE:  0x80300000 - 0x8043DF30 (1302320)
> Initialized Data:          0x803381A0 - 0x8033A550 (9136)
> BSS Area:                  0x8033A550 - 0x8033BF30 (6624)
> Local Heap:                0x8033BF30 - 0x8043BF30 (1048576)
> Stack Area:                0x8043BF30 - 0x8043DF30 (8192)
> Text (code) segment:       0x80300000 - 0x803381A0 (229792)
> Boot area (physical):      0x0043E000 - 0x0047E000
> Relocation Factor:         I:00000000 - D:00000000
> 
> Boot version: v3.2
> The boot is CFE
> 
> mac_init(): Find mac [00:0F:66:D3:94:95] in location 1
> Nothing...
> 
> No eou key find
> Device eth0:  hwaddr 00-0F-66-D3-94-95, ipaddr 192.168.1.1, mask
> 255.255.255.0
>         gateway not set, nameserver not set
> Reading :: Failed.: Timeout occured
> Loader:raw Filesys:raw Dev:flash0.os File: Options:(null)
> Loading: .. 3800 bytes read
> Entry at 0x80001000
> Closing network.
> Starting program at 0x80001000
> [    0.000000] Linux version 4.4.14 (hauke@hauke-desktop) (gcc version
> 5.3.0 (LEDE GCC 5.3.0 r829) ) #1 Thu Jun 30 20:49:41 UTC 2016
> [    0.000000] CPU0 revision is: 00029007 (Broadcom BMIPS3300)
> [    0.000000] bcm47xx: Using ssb bus
> [    0.000000] ssb: Found chip with id 0x4712, rev 0x01 and package 0x00
> 
> 
>
