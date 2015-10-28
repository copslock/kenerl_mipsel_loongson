Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 22:02:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29922 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010148AbbJ1VCuep8EQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 22:02:50 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id BCC1D154CD8C6;
        Wed, 28 Oct 2015 21:02:40 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 28 Oct 2015 21:02:44 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Wed, 28 Oct 2015 21:02:44 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: old OCTEON bootloaders and .MIPS.abiflags
Thread-Topic: old OCTEON bootloaders and .MIPS.abiflags
Thread-Index: AQHREbp+B6iNRp1taESc8zmCk2oAr56BY2Ew
Date:   Wed, 28 Oct 2015 21:02:43 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235361C6AA6F@LEMAIL01.le.imgtec.org>
References: <20151028195436.GB1838@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20151028195436.GB1838@blackmetal.musicnaut.iki.fi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.69]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> Current binutils adds .MIPS.abiflags section to the kernel vmlinux.
> 
> This seems break the boot on some old (buggy) OCTEON bootloaders:
> 
> 	ELF file is 64 bit
> 	Attempting to allocate memory for ELF segment: addr: 0xffffffff816e67f0 (adjusted to:
> 0x00000000016e67f0), size 0x18
> 	Allocated memory for ELF segment: addr: 0xffffffff816e67f0, size 0x18
> 	Attempting to allocate memory for ELF segment: addr: 0xffffffff81100000 (adjusted to:
> 0x0000000001100000), size 0x1b86360
> 	Error allocating memory for elf image!
> 	## ERROR loading File!
> 
> The workaround is to remove the .MIPS.abiflags with "strip" - I guess that
> is safe for the kernel... Not sure if there is nothing much else to be
> done, and already a similar hack needs to be done for the .notes section.
> 
> I just wanted to post this in case some else faces the same issue.

It seems reasonably sensible to /DISCARD/ the .MIPS.abiflags section in the kernel link
scripts as I don't think the kernel needs that information for any purpose. I assume
.reginfo is discarded as well at some point.

Matthew
