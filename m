Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 15:39:11 +0100 (CET)
Received: from mail.netlogicmicro.com ([64.0.7.62]:3541 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492866AbZKYOhs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 15:37:48 +0100
X-TM-IMSS-Message-ID: <0ebfac24000115e4@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.1.1.7]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 0ebfac24000115e4 ; Wed, 25 Nov 2009 06:37:38 -0800
Received: from 71.145.164.137 ([71.145.164.137]) by orion8.netlogicmicro.com ([10.1.1.7]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 25 Nov 2009 14:38:47 +0000
Received: from kh-d280-64 by webmail2.netlogicmicro.com; 25 Nov 2009 08:37:37 -0600
Subject: Re: how to support more than 512MB RAM for MIPS32 ?
From:   Kevin Hickey <khickey@netlogicmicro.com>
To:     figo zhang <figo1802@gmail.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <c6ed1ac50911242234p12817b55r1a062d59949308bf@mail.gmail.com>
References: <c6ed1ac50911242234p12817b55r1a062d59949308bf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Wed, 25 Nov 2009 08:37:37 -0600
Message-ID: <1259159857.4675.11.camel@kh-d280-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Return-Path: <khickey@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25124
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

We use HIGHMEM on the Au1300 to access any memory spaces >256 MB.  Our
I/O area starts at 256 MB.  We just map the extra DRAM to any area
outside the I/O space, enable highmem, and register it as BOOT_MEM_RAM
with add_memory_region.  Works great.

=Kevin
--
Kevin Hickey
Netlogic Microsystems


On Wed, 2009-11-25 at 14:34 +0800, figo zhang wrote:
> hi all,
> 
> I am using 24KEC SOC, i want to support larger more than 512MB RAM.
> The mips32 architure  in Kseg0/Kseg1,
> such as:
> 0x8000,0000 ~ 0x92c0,0000  # 300MB for RAM
> 0x92c0,0000 ~ 0xa000,0000  # 212 for I/O register
> 
> so, mips32 only support 300MB memory, i dont how to support more than
> 512MB in linux-mips kernel , such as 2GB memory? it is using HIGHMEM
> strategy
> for kernel(ZONE_HIGHMEM)?
> 
> Best,
> Figo.zhang
