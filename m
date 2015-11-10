Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2015 12:13:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60544 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011261AbbKJLNFC352A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Nov 2015 12:13:05 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tAABCuJV030940;
        Tue, 10 Nov 2015 12:12:56 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tAABCsam030938;
        Tue, 10 Nov 2015 12:12:54 +0100
Date:   Tue, 10 Nov 2015 12:12:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 4/4] MIPS: Loongson: Make CPU names more clear
Message-ID: <20151110111253.GB29184@linux-mips.org>
References: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
 <1444198082-24128-5-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1444198082-24128-5-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Oct 07, 2015 at 02:08:02PM +0800, Huacai Chen wrote:

> Make names in /proc/cpuinfo more human-readable, Since GCC support the
> new-style names for a long time, this may not break -march=native any
> more.

I do understand why you want to make this change - but things in proc
including CPU names are interfaces and those are cast in stone.  You
can't just call a potatoe a cherry today :-)

Unless you have a good reason which would include demonstrating that is
not breaking any existing application code?

  Ralf
