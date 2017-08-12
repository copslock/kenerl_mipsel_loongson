Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2017 15:32:41 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:62468 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993195AbdHLNcdqw6Fj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2017 15:32:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id CDEDB3F524;
        Sat, 12 Aug 2017 15:32:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6IIMUGO0qFxB; Sat, 12 Aug 2017 15:32:23 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id D213B3F5D2;
        Sat, 12 Aug 2017 15:32:16 +0200 (CEST)
Date:   Sat, 12 Aug 2017 15:32:15 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: Update PS2 R5900 to kernel 4.x?
Message-ID: <20170812133215.GB14994@localhost.localdomain>
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
 <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
 <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
 <2CA3040B-8EB9-456C-A4DE-BFE0D097971C@nocrew.org>
 <77bec1a2-7e2b-3012-a909-b5ec1fe24178@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77bec1a2-7e2b-3012-a909-b5ec1fe24178@gentoo.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59495
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

On Fri, Aug 04, 2017 at 10:13:32AM -0400, Joshua Kinard wrote:
> It appears the busybox init didn't like the changes to _sys_fork in
> 64b3122df48b, and is thus crashing, which causes the kernel to panic due to
> PID 1 dying.

I’m making some progress, and now have v3.10 compiling and booting:

https://github.com/frno7/linux/tree/ps2-v3.10-squashed

I had to unset CONFIG_R5900_128BIT_SUPPORT but I’m hoping that part of the
patch could be simplified later on.

Fredrik
