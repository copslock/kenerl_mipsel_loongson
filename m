Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 10:13:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44691 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903303Ab2IKIM7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2012 10:12:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8B8Cv8m018844;
        Tue, 11 Sep 2012 10:12:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8B8Cuur018843;
        Tue, 11 Sep 2012 10:12:56 +0200
Date:   Tue, 11 Sep 2012 10:12:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rich Felker <dalias@aerifal.cx>
Cc:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120911081256.GD24448@linux-mips.org>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120909193008.GA15157@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34464
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

> Hi all,
> The kernel syscall entry/exit code seems to always save and restore
> r25. Is this stable/documented behavior I can rely on? If there's a
> reason it _needs_ to be preserved, knowing that would help convince me
> it's safe to assume it will always be done. The intended usage is to
> be able to make syscalls (where the syscall # is not a constant that
> could be loaded with lwi) without a stack frame, as in "move $2,$25 ;
> syscall".

Since there is no place where the syscall interface is documented other
than in the code itself, I've written a new wiki article

  http://www.linux-mips.org/wiki/Syscall

as start.  It's still lacking on the more obscure points but it at least
should have have answered your question, had it already existed when you
asked.

  Ralf
