Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2012 19:36:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34083 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903360Ab2IWRgM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Sep 2012 19:36:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8NHaAmd006495;
        Sun, 23 Sep 2012 19:36:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8NHa9D2006494;
        Sun, 23 Sep 2012 19:36:09 +0200
Date:   Sun, 23 Sep 2012 19:36:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mips@linux-mips.org, linux-next@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: ptrace: Add missing #include <asm/syscall.h>
Message-ID: <20120923173609.GE13842@linux-mips.org>
References: <1347913216-11140-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1347913216-11140-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34540
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Sep 17, 2012 at 10:20:16PM +0200, Geert Uytterhoeven wrote:

> arch/mips/kernel/ptrace.c: In function ‘syscall_trace_enter’:
> arch/mips/kernel/ptrace.c:664: error: implicit declaration of function ‘__syscall_get_arch’
> make[2]: *** [arch/mips/kernel/ptrace.o] Error 1

Thanks, I already had fixed that in the linux-trace tree; the latest
version just had not yet propagated yet to the other trees.

  Ralf
