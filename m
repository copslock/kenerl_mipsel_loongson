Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Dec 2015 05:21:27 +0100 (CET)
Received: from lkcl.net ([217.147.94.29]:35210 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006513AbbLZEVZSkpUN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 Dec 2015 05:21:25 +0100
Received: from mail-oi0-f50.google.com ([209.85.218.50])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <lkcl@lkcl.net>)
        id 1aCgM8-0005Mb-56
        for linux-mips@linux-mips.org; Sat, 26 Dec 2015 04:21:24 +0000
Received: by mail-oi0-f50.google.com with SMTP id o62so148230681oif.3
        for <linux-mips@linux-mips.org>; Fri, 25 Dec 2015 20:21:23 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.202.49.9 with SMTP id x9mr24012561oix.75.1451103677856; Fri,
 25 Dec 2015 20:21:17 -0800 (PST)
Received: by 10.60.7.37 with HTTP; Fri, 25 Dec 2015 20:21:17 -0800 (PST)
Date:   Sat, 26 Dec 2015 04:21:17 +0000
X-Gmail-Original-Message-ID: <CAPweEDyUja75JGT+1wSqL7O4OSyDg5f7+=nnJTy7WSKe114paA@mail.gmail.com>
Message-ID: <CAPweEDyUja75JGT+1wSqL7O4OSyDg5f7+=nnJTy7WSKe114paA@mail.gmail.com>
Subject: first ever EOMA68-jz4775 (MIPS) CPU Card prototypes manufactured
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <lkcl@lkcl.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkcl@lkcl.net
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

http://rhombus-tech.net/ingenic/jz4775/news/

i thought you'd like to know that the assembly of the first
EOMA68-compliant ingenic jz4775 CPU Cards have been completed.  six
were made: i have given one to the factory owner so that he has
something to show clients in future.  these CPU Cards are specially
relevant because they are the first that can be used to make RYF
(Respect Your Freedom) FSF Hardware-Endorseable products.

2GB of DDR3 1066mhz RAM has been added to these boards, as well as a
4GB Hynix MLC NAND.  there is also a micro-sd card slot on-board, and
a (1.27mm) DIL2x5 header which has JTAG, UART and boot-selection.

i recall many months ago that there were people on this list who were
potentially interested to help with board bring-up, if that's still
the case i would love to hear from you.  you might need a soldering
iron :)

l.
