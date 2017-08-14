Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 13:25:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32308 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993924AbdHNLZQrKK0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 13:25:16 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C46DCBA535634;
        Mon, 14 Aug 2017 12:25:07 +0100 (IST)
Received: from [10.20.78.87] (10.20.78.87) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 14 Aug 2017
 12:25:09 +0100
Date:   Mon, 14 Aug 2017 12:25:02 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: math-emu: do not use bools for arithmetic
In-Reply-To: <20170814102148.397474-1-manuel.lauss@gmail.com>
Message-ID: <alpine.DEB.2.00.1708141210580.17596@tp.orcam.me.uk>
References: <20170814102148.397474-1-manuel.lauss@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.87]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Mon, 14 Aug 2017, Manuel Lauss wrote:

> ---
> v2: just use xor, as suggested by Maciej.  No size changes this time, but still
> untested due to lack of hardfloat userland.

 D'oh, I was wondering what you meant by writing: "binary size reduction" 
and didn't get that you meant a size reduction of the binary object file 
produced rather than a transformation made by the compiler to the binary 
expression used.  That looks odd indeed -- have you tried comparing the 
output from `objdump -d' with and without the original patch applied?

 Your change looks obviously correct to me, however I can push it through 
GCC and/or glibc IEEE 754 math regression testing if it'll make you feel 
more confident about it.

 Meanwhile:

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

  Maciej
