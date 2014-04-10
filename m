Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 02:38:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50602 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834662AbaDJAiJCRpaE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Apr 2014 02:38:09 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s3A0c7YF030632;
        Thu, 10 Apr 2014 02:38:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s3A0c648030631;
        Thu, 10 Apr 2014 02:38:06 +0200
Date:   Thu, 10 Apr 2014 02:38:06 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <20140410003806.GV17197@linux-mips.org>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
 <20140409051929.GA29246@localhost>
 <20140409082445.GC1438@pax.zz.de>
 <20140409133229.GA22315@alpha.franken.de>
 <20140409231345.GC8370@localhost>
 <5345DB6A.7060004@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5345DB6A.7060004@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39754
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

On Wed, Apr 09, 2014 at 07:44:42PM -0400, Joshua Kinard wrote:

> > I notice there is also a mips64 compiler. Should I use that?

The difference between a mips-linux, mips64-linux, mips64el-linux or mipsel-linux
compiler are only the defaults and they can be overridden with command
line options; the kernel makefiles will pass the required options.

> If you weren't using a mips64 compiler, that's probably the issue.  R10000
> processors are 64-bit only, so a 'mips' toolchain probably doesn't include
> the R10K cache-barrier code, causing that option to fail.

No - there's no mode switch.  An R10000 will happily run 32-bit code
otherwise 32 bit kernels wouldn't work.  32 bit code just doesn't use
64 bit addressing, instructions or the upper 32 bit of the 64 bit registers.

$ mips-linux-gcc -mr10k-cache-barrier=store -c -O2 -o c.o c.c
c.c:1:0: error: ‘-mr10k-cache-barrier’ requires a target that provides the ‘cache’ instruction
[...]

When adding an option like -mips32 the compilation will succeed.

> Are you configuring for IP22 (Indy, Indigo2 R4x00), or IP28 (R10000)?  Note,
> IP26 (R8000) is not supported in Linux.  I think OpenBSD got it working, though.

Wish I'd have a box ....

  Ralf
