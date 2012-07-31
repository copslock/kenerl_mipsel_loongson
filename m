Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2012 15:40:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41588 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903610Ab2GaNkH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2012 15:40:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q6VDe5Gh015982;
        Tue, 31 Jul 2012 15:40:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q6VDe1Lc015963;
        Tue, 31 Jul 2012 15:40:01 +0200
Date:   Tue, 31 Jul 2012 15:40:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lluis Batlle i Rossell <viric@viric.name>
Cc:     linux-mips@linux-mips.org, loongson-dev@googlegroups.com
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
Message-ID: <20120731134001.GA14151@linux-mips.org>
References: <20120615234641.6938B58FE7C@mail.viric.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120615234641.6938B58FE7C@mail.viric.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34004
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

On Sat, Jun 16, 2012 at 12:22:53AM +0200, Lluis Batlle i Rossell wrote:

> Reusing most of the code from lw,ld,sw,sd emulation,
> I add the emulation for lwc1,ldc1,swc1,sdc1.
> 
> This avoids the direct SIGBUS sent to userspace processes that have
> misaligned memory accesses.
> 
> I've tested the change in Loongson2F, with an own test program, and
> WebKit 1.4.0, as both were killed by sigbus without this patch.

A misaligned FPU access is a strong indication for broken, non-portable
software.  which means you're likely trying to fix the wrong issue.  It's
quite intentional that there is no unaligned handling for the FPU in the
kernel - and afaics there isn't for any other MIPS UNIX.

  Ralf
