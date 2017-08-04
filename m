Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 16:57:53 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:57381 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23995085AbdHDO5pV1FZX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Aug 2017 16:57:45 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id 253DF3F433;
        Fri,  4 Aug 2017 16:57:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O6gcTLJ8IGaq; Fri,  4 Aug 2017 16:57:34 +0200 (CEST)
Received: from [10.0.1.7] (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id 3BD663F294;
        Fri,  4 Aug 2017 16:57:29 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Update PS2 R5900 to kernel 4.x?
From:   Fredrik Noring <noring@nocrew.org>
In-Reply-To: <77bec1a2-7e2b-3012-a909-b5ec1fe24178@gentoo.org>
Date:   Fri, 4 Aug 2017 16:57:27 +0200
Cc:     linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1DC41BC8-A39F-4F73-8A97-B61BE0023788@nocrew.org>
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
 <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
 <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
 <2CA3040B-8EB9-456C-A4DE-BFE0D097971C@nocrew.org>
 <77bec1a2-7e2b-3012-a909-b5ec1fe24178@gentoo.org>
To:     Joshua Kinard <kumba@gentoo.org>
X-Mailer: Apple Mail (2.3259)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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


> 4 aug. 2017 kl. 16:13 skrev Joshua Kinard <kumba@gentoo.org>:
> 
> If I can find the time this weekend, and the power cord, I'll have to see if it
> works.  I want to say it might've taken a power spike and stopped turning on,
> but that might've been something else attached to my TV.  Thus far planning to
> try and chase down possible timer/RCU bugs in SGI IP27 this weekend, but we'll see.

You will (most likely) need a boot loader (e.g. Free MC boot) on a memory card.
I borrowed a “Swap Magic” dvd from a friend to install it. There are apparently
several other ways, including buying a preinstalled memory card. This needs to
be done once and is a small threshold to installing Linux.

I compiled the linux-dev project

    https://github.com/rickgaiser/linux-dev

which contains most if not all needed tools, including a fairly recent R5900
cross-compiler:

    % mipsel-linux-gcc --version
    mipsel-linux-gcc.br_real (Buildroot 2017.02-00008-g0de152b) 6.3.0

If your machine happens to be defective or incompatible, a great variation of
PS2 machines sell second-hand for EUR 25 or so. Most are compatible with Linux,
as I understand, but check the model to be sure. Later models have ethernet but
I believe all have usb so I suppose network and other things are doable on all.

All the best,
Fredrik
