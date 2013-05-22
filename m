Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 15:42:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33632 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823426Ab3EVNly1F5YT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 May 2013 15:41:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4MDfo2h006870;
        Wed, 22 May 2013 15:41:50 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4MDfn8Q006836;
        Wed, 22 May 2013 15:41:49 +0200
Date:   Wed, 22 May 2013 15:41:48 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Aron Xu <aron@debian.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: N64: Define getdents64
Message-ID: <20130522134148.GE10769@linux-mips.org>
References: <1369147026-23033-1-git-send-email-aron@debian.org>
 <519BC32E.2080405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519BC32E.2080405@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36523
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

On Tue, May 21, 2013 at 11:55:42AM -0700, David Daney wrote:

> On 05/21/2013 07:37 AM, Aron Xu wrote:
> >As a relatively new ABI, N64 only had getdents syscall while other modern
> >architectures have getdents64.
> >
> >This was noticed when Python 3.3 shifted to the latter one for aarch64.
> >
> >Signed-off-by: Aron Xu <aron@debian.org>
> 
> This looks correct to me.  The getdents64 call returns more
> information than getdents (it adds a field for the file type).  So,
> although in n64 the widths of the d_ino and d_off fields are the
> same for getdents64 and getdents, we still need to add this syscall.
> 
> Acked-by: David Daney <david.daney@cavium.com>

Yes, the patch is looking good but I was really wondering why the other
ABIs had getdents64 wired up but not the native N64, so I started
digging.

Commit 1a1d77dd589de5a567fa95e36aa6999c704ceca4 [Merge with 2.4.0-test7.]
added N64 getdents(2) to arch/mips64/kernel/scall_64.S as syscall 5213,
then dropped again in 578720675c44e54e8aa7c68f6dce59ed37ce3d3b [Overhaul
of the 64-bit syscall interface.  Now heritage free.] for 2.5.18 in 2002.

It took a while to be noticed ;)

Thanks a lot!

  Ralf
