Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 21:13:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16737 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013859AbaKQUNMsnz9J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 21:13:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1D2A780A6ADAF;
        Mon, 17 Nov 2014 20:13:03 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 20:13:06 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 20:13:06 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Nov
 2014 12:12:58 -0800
Message-ID: <546A56C9.4060608@imgtec.com>
Date:   Mon, 17 Nov 2014 12:12:57 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re:  MIPS: c-r4k.c: Fix the 74K D-cache alias erratum workaround
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

 > Fix the 74K D-cache alias erratum workaround so that it actually works.
 > Our current code sets MIPS_CACHE_VTAG for the D-cache, but that flag
 > only has any effect for the I-cache.  Additionally MIPS_CACHE_PINDEX is
 > set for the D-cache if CP0.Config7.AR is also set for an affected
 > processor, leading to confusing information in the bootstrap log (the
 > flag isn't used beyond that).

 > So delete the setting of MIPS_CACHE_VTAG and rely on MIPS_CACHE_ALIASES,
 > set in a common place, removing I-cache coherency issues seen in GDB
 > testing with software breakpoints, gdbserver and ptrace(2), on affected
 > systems.

 > While at it add a little piece of explanation of what CP0.Config6.SYND
 > is so that people do not have to chase documentation.

This shift to MIPS_CACHE_ALIASES is not needed, a use of MIPS_CACHE_VTAG 
in dcache is actually a way how to prevent some very specific situations 
in 74K(E77)/1074K(E17) cache handling. It is not a case of cache 
aliasing and name VTAG is used because it is related with virtual 
address conversion tagging. I reused MIPS_CACHE_VTAG just to save some 
spare bits in cpu_info.options and because D-cache never had virtual 
tagging like I-cache.

The setting d-cache aliases then CPU hasn't it is a significant 
performance loss and should be avoided.

Please don't use this patch.

- Leonid.
