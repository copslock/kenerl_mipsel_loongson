Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 15:26:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31258 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006739AbcBXO01Vk8v6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 15:26:27 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 5122B44E71408;
        Wed, 24 Feb 2016 14:26:18 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775]) by
 HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3%26]) with mapi id
 14.03.0266.001; Wed, 24 Feb 2016 14:26:20 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>
CC:     Scott Egerton <Scott.Egerton@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] mips: Avoid a form of the .type directive that is not
 supported by LLVM's Integrated Assembler
Thread-Topic: [PATCH] mips: Avoid a form of the .type directive that is not
 supported by LLVM's Integrated Assembler
Thread-Index: AQHRaZkU+k5Y1OCoL0aZtPCBvTihB58wqaGAgAnOyQCAANKnOw==
Date:   Wed, 24 Feb 2016 14:26:18 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F467757E6@hhmail02.hh.imgtec.org>
References: <1455723429-26459-1-git-send-email-daniel.sanders@imgtec.com>
 <alpine.DEB.2.00.1602171944410.15885@tp.orcam.me.uk>,<20160224015058.GA25673@linux-mips.org>
In-Reply-To: <20160224015058.GA25673@linux-mips.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.153.31.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Daniel.Sanders@imgtec.com
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

Thanks
________________________________________
From: Ralf Baechle [ralf@linux-mips.org]
Sent: 24 February 2016 01:50
To: Maciej Rozycki
Cc: Daniel Sanders; Scott Egerton; Paul Burton; Markos Chandras; Leonid Yegoshin; linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: Avoid a form of the .type directive that is not supported by LLVM's Integrated Assembler

On Wed, Feb 17, 2016 at 08:04:31PM +0000, Maciej W. Rozycki wrote:

>  If LLVM strives to be GNU toolchain compatible, then this looks like a
> bug in their scanner as generic ELF support in GAS (gas/config/obj-elf.c)
> has this, in `obj_elf_type':
>
>   if (*input_line_pointer == ',')
>     ++input_line_pointer;
>
> so the comma is entirely optional.  I realise this is undocumented, but
> there you go.  It must have been there since forever.

It contradicts documentation.  The gas manual says:

* Type::                        `.type <INT | NAME , TYPE DESCRIPTION>'

And the SGI assembler manual I dug up as ".type name, value".  So maybe
gas is too generous here?

Either way, I think the patch is right and I've just applied v2.

  Ralf
