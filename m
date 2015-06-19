Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 12:06:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53572 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006879AbbFSKGeMX4zq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Jun 2015 12:06:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t5JA6Wj3031683;
        Fri, 19 Jun 2015 12:06:32 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t5JA6QWK031674;
        Fri, 19 Jun 2015 12:06:26 +0200
Date:   Fri, 19 Jun 2015 12:06:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Matthias Schiffer <mschiffer@universe-factory.net>,
        musl@lists.openwall.com, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [musl] musl-libc/MIPS: detached thread exit broken since kernel
 commit 46e12c07b
Message-ID: <20150619100626.GB29960@linux-mips.org>
References: <55837978.7020801@universe-factory.net>
 <20150619025032.GR1173@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150619025032.GR1173@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47978
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

On Thu, Jun 18, 2015 at 10:50:32PM -0400, Rich Felker wrote:

> This is kernel ABI breakage that should be fixed -- people running old
> kernel versions with old musl binaries might suffer a regression when
> upgrading, and perhaps more importantly the failure mode is just
> really bad. But I think we can also work around it on the userspace
> side in musl by pointing the stack pointer at some rodata (or even at
> pc, e.g. copying $25 to $sp) before making the syscall.

Just to be on the safe side, make sure it is something that's readable.  Core
might me mapped execute-only, that is not readable and that is a feature
which the affected kernels do support on suitable hardware.

  Ralf
