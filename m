Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2010 16:19:46 +0200 (CEST)
Received: from pfepa.post.tele.dk ([195.41.46.235]:40738 "EHLO
        pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491775Ab0E3OTl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 May 2010 16:19:41 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepa.post.tele.dk (Postfix) with ESMTP id 42602A5002D;
        Sun, 30 May 2010 16:19:39 +0200 (CEST)
Date:   Sun, 30 May 2010 16:19:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     sam@ravnborg.org
Subject: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100530141939.GA22153@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

This patchset does the following:
- introduce arch/mips/Kbuild
- use -Werror on all core-y files of the mips kernel
- introduce a distributed way to specify platform definitions
- refactor a few Makefiles
- clean up cleaning 

Ralf asked in private mail if I could try to implement
a working varient of a suggestion I made some time ago.
The idea was to move platform specific definitions to
dedicated platfrom files.

This is implmented in the third patch.

The idea is to move the platform definitions from arch/mips/Makefile
to arch/mips/<platform>/Platfrom

The content of this file is used in arch/mips/Makefile
and arch/mips/Kbuild.

On top of this is a few patches that refactor the
boot and boot/compressed Makefiles so they are more
kbuild conformant.
This beautify the output when we build a kernel.

Wu Zhangjin have pointed out a few bugs in the first
variants of the patches that hit the mailing list - thanks!


Patches will follow.

Note: I tried to test a little with bigsur_defconfig
but get_user() is buggy. Or at least my gcc thinks that
first argument may be used uninitialized.
I think mips needs to fix the 64 bit variant of get_user().
I took a quick look but ran away.

	Sam


Sam Ravnborg (6):
      mips: introduce arch/mips/Kbuild
      mips: add -Werror to arch/mips/Kbuild
      mips: introduce support for Platform definitions
      mips: refactor arch/mips/boot/Makefile
      mips: refactor arch/mips/boot/compressed/Makefile
      mips: clean up arch/mips/Makefile

 arch/mips/Kbuild                   |   15 +++++++++
 arch/mips/Kbuild.platforms         |    6 ++++
 arch/mips/Makefile                 |   57 +++++++++---------------------------
 arch/mips/ar7/Platform             |    7 ++++
 arch/mips/boot/Makefile            |   49 ++++++++++++++----------------
 arch/mips/boot/compressed/Makefile |   54 ++++++++++++++++++----------------
 arch/mips/kernel/Makefile          |    2 -
 arch/mips/math-emu/Makefile        |    1 -
 arch/mips/mm/Makefile              |    2 -
 9 files changed, 94 insertions(+), 99 deletions(-)
