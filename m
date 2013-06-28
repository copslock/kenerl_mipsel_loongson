Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 15:31:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56286 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3F1NbOezh7B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 15:31:14 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5SDVCnR018771;
        Fri, 28 Jun 2013 15:31:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5SDVBFG018770;
        Fri, 28 Jun 2013 15:31:11 +0200
Date:   Fri, 28 Jun 2013 15:31:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Kconfig: Add missing MODULES dependency to
 VPE_LOADER
Message-ID: <20130628133111.GN10727@linux-mips.org>
References: <1372422327-21814-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1372422327-21814-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37202
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

On Fri, Jun 28, 2013 at 01:25:27PM +0100, Markos Chandras wrote:

> The vpe.c code uses the 'struct module' which is only available if
> CONFIG_MODULES is selected.
> 
> Also fixes the following build problem on a lantiq allmodconfig:
> In file included from arch/mips/kernel/vpe.c:41:0:
> include/linux/moduleloader.h: In function 'apply_relocate':
> include/linux/moduleloader.h:48:63: error: dereferencing pointer
> to incomplete type
> include/linux/moduleloader.h: In function 'apply_relocate_add':
> include/linux/moduleloader.h:70:63: error: dereferencing pointer
> to incomplete type
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Sigh.  One more bug in the thing.  It first of all shouldn't have been
designed recycling so much code from the module loader in inapropriate
ways.

I'm going to apply the patch - but as usual whenver I have to touch the
VPE loader, kspd or rtlx I feel like a blunt chainsaw would be the right
way to fix this code.

SPUFS is a special filesystem which was designed to use the Playstation 3's
synergetic elements.  The code is in arch/powerpc/platforms/cell/spufs
and it's a far, cleaner interface to other processing thingies, be they
synergetic elements, or other cores, VPEs and TCs running bare metal
code or strage things like custom processors.

See also Documentation/filesystems/spufs.txt in the kernel code or the
spufs(7) man page.

I'm not suggesting to strictly use the same interface as SPUFS but rather
as a template.

Doing things spufs style will also mean relocation will have to be
performed in userspace again.  That code exists in modutils for the
2.4 kernel.

  Ralf
