Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2014 01:11:50 +0200 (CEST)
Received: from orbit.nwl.cc ([176.31.251.142]:45435 "EHLO mail.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6854763AbaHDXLsN-uAH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Aug 2014 01:11:48 +0200
Received: from mail.nwl.cc (orbit [127.0.0.1])
        by mail.nwl.cc (Postfix) with ESMTP id A4A8F22BB3;
        Tue,  5 Aug 2014 01:11:47 +0200 (CEST)
Received: from base (orbit [127.0.0.1])
        by mail.nwl.cc (Postfix) with ESMTP id 793FF227FD;
        Tue,  5 Aug 2014 01:11:47 +0200 (CEST)
Date:   Tue, 5 Aug 2014 01:14:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     linux-mips@linux-mips.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>
Subject: ATH79: zboot and kernel parameters
Mail-Followup-To: linux-mips@linux-mips.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Message-Id: <20140804231147.793FF227FD@mail.nwl.cc>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phil@nwl.cc
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

Hi,

I have this Routerboard 493g from Mikrotik, thanks to the
OpenWrt-provided patches Linux-3.14.9 runs fine on it.

On top of that, I have added the necessary things to allow for zboot and
indeed it can boot a compressed kernel. The only problem with that is
for some reason the kernel parameters passed on by the boot loader do
not make it into the kernel.

I have tried printing the parameters from inside decompress.c by
mimicking the way head.S stores them for later access from inside C
code, but had no luck so far. For whatever reason, the variables'
contents seem to be zero.

Do you maybe have an idea what could be the culprit difference in
between an uncompressed kernel image and the decompressor that makes the
registers a0 to a4 inaccessible? Mostly due to my practically
non-existing knowledge about assembly I am stuck at this point.

Best wishes, Phil
