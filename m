Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 15:42:17 +0100 (BST)
Received: from amdext2.amd.com ([IPv6:::ffff:163.181.251.1]:62152 "EHLO
	amdext2.amd.com") by linux-mips.org with ESMTP id <S8225192AbTCaOmJ>;
	Mon, 31 Mar 2003 15:42:09 +0100
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id h2VEc6Qo016921;
	Mon, 31 Mar 2003 08:41:59 -0600 (CST)
Received: from 163.181.250.1SAUSGW02.amd.com with ESMTP (AMD SMTP Relay
 (MMS v5.0)); Mon, 31 Mar 2003 08:41:56 -0600
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Received: from pcsmail.amd.com (pcsmail.amd.com [163.181.41.222]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id h2VEfp2p008088; Mon,
 31 Mar 2003 08:41:51 -0600 (CST)
Received: from amd.com (PC-DEVOLDER.amd.com [163.181.60.19]) by
 pcsmail.amd.com (8.11.6/8.11.6) with ESMTP id h2VEfpa29056; Mon, 31 Mar
 2003 08:41:51 -0600
Message-ID: <3E8853B3.9080902@amd.com>
Date: Mon, 31 Mar 2003 08:41:55 -0600
From: "Eric DeVolder" <eric.devolder@amd.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1)
 Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hartvig Ekner" <hartvig@ekner.info>
cc: "Pete Popov" <ppopov@mvista.com>,
	"Linux MIPS mailing list" <linux-mips@linux-mips.org>
Subject: Re: Au1500 hardware cache coherency
References: <3E882FB8.BBFDACE2@ekner.info>
X-WSS-ID: 12968C3E2041578-01-01
Content-Type: text/plain;
 charset=us-ascii;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <eric.devolder@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.devolder@amd.com
Precedence: bulk
X-list: linux-mips

There are data cache snoop bugs with respect to PCI on the Au1500. For the
Au1500s soldered on DbAu1500 boards to-date, PCI can not use coherent
transactions. Details in the Specification Update for the Au1500 
available from:

www.amd.com/pcs
  -> Technical Resources
        -> AMD Alchemy Solutions Development Board Support

Login with your board and you'll be presented with various docs, 
including the
spec update.

Regards,
Eric

Hartvig Ekner wrote:

>Hi Pete,
>
>I am attempting to use the HW coherency feature of the AU1500 to avoid SW flushes and increase the performance.
>In the config-shared.in file, I can see that the CONFIG_NONCOHERENT_IO define is always set for the AMD
>eval boards, which results in SW cache flushes when dma_cache_xxx functions are called. If HW coherency is
>working, this define should not be set.
>
>However, in your drivers, you only call the dma_cache functions from au1000/common/usbdev.c, but not from e.g. the ethernet
>driver or the audio driver. Is this intentional? It seems that the ethernet & audio driver already relies on HW
>coherency to function correctly (and it also sets the MAC enable bits accordingly, to force all ETH DMA
>accesses to be coherent), so why not USB also?
>
>When turning off NONCOHERENT_IO, there are some bugs (not in AU1000 code) which prevents the code from
>compiling, but I have fixed these. And the kernel boots, but during some large disk-copy tests, I get occasional
>data errors which I'm looking in to.
>
>So before spending more time on debugging this, and creating patches for using HW coherency, I wanted to hear
>your input - maybe there are known problems in the Au1500 coherency implementation?
>
>/Hartvig
>
>
>
>
>  
>
