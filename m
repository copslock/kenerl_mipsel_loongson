Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 19:08:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38805 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903468Ab2IJRId (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Sep 2012 19:08:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8AH8W1h013802;
        Mon, 10 Sep 2012 19:08:32 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8AH8UvH013801;
        Mon, 10 Sep 2012 19:08:30 +0200
Date:   Mon, 10 Sep 2012 19:08:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rich Felker <dalias@aerifal.cx>
Cc:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120910170830.GB24448@linux-mips.org>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120909193008.GA15157@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34452
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

On Sun, Sep 09, 2012 at 03:30:08PM -0400, Rich Felker wrote:

> The kernel syscall entry/exit code seems to always save and restore
> r25. Is this stable/documented behavior I can rely on? If there's a
> reason it _needs_ to be preserved, knowing that would help convince me
> it's safe to assume it will always be done. The intended usage is to
> be able to make syscalls (where the syscall # is not a constant that
> could be loaded with lwi) without a stack frame, as in "move $2,$25 ;
> syscall".

The basic design idea is that syscalls use a calling convention similar
to subroutine calls.  $25 is $t9, so a temp register which is callee saved.

So if the kernel is saving $t9 and you've been relying on that, consider
yourself lucky - there's not guarantee for that.

  Ralf
