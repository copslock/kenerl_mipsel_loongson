Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 10:19:51 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9061 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822344Ab3HUITsxxIE9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 10:19:48 +0200
Received: (qmail 11577 invoked by uid 89); 21 Aug 2013 08:19:49 -0000
Received: by simscan 1.3.1 ppid: 11570, pid: 11573, t: 0.1425s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO azrael.ibk.sigmapriv.at) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 21 Aug 2013 08:19:49 -0000
From:   Richard Weinberger <richard@nod.at>
To:     linux-arch@vger.kernel.org
Cc:     mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org,
        lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: [RFC] Get rid of SUBARCH
Date:   Wed, 21 Aug 2013 10:19:24 +0200
Message-Id: <1377073172-3662-1-git-send-email-richard@nod.at>
X-Mailer: git-send-email 1.8.1.4
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

This series is an attempt to remove the SUBARCH make parameter.
It as introduced at the times of Linux 2.5 for UML to tell the UML
build system what the real architecture is.

But we actually don't need SUBARCH, we can store this information
in the .config file.
i386_defconfig will produce a kernel for x86, and x86_64_defconfig
for x86_64. There is no need to specify SUBARCH.
With this patchset applied you can build UML always with "make linux ARCH=um"
and it will produce the an image for the architecture specified in your .config.
Currenlty "make linux ARCH=um" will alter your .config to match the detected SUBARCH
whith sucks and causes problems on automated build systems.

The series touches also m68k, sh, mips and unicore32.
These architectures magically select a cross compiler if ARCH != SUBARCH.
Do really need that behavior?

[PATCH 1/8] um: Create defconfigs for i386 and x86_64
[PATCH 2/8] um: Do not use SUBARCH
[PATCH 3/8] um: Remove old defconfig
[PATCH 4/8] m68k: Do not use SUBARCH
[PATCH 5/8] sh: Do not use SUBARCH
[PATCH 6/8] mips: Do not use SUBARCH
[PATCH 7/8] unicore32: Do not use SUBARCH
[PATCH 8/8] Makefile: Remove SUBARCH

Thanks,
//richard
