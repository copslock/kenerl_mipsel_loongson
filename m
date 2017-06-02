Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 10:49:12 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:43221 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993905AbdFBItFI0gwp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Jun 2017 10:49:05 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E21EAB5D;
        Fri,  2 Jun 2017 08:49:04 +0000 (UTC)
From:   Aleksa Sarai <asarai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, Aleksa Sarai <asarai@suse.de>
Subject: [PATCH v2 0/1] tty: add TIOCGPTPEER ioctl
Date:   Fri,  2 Jun 2017 18:48:57 +1000
Message-Id: <20170602084858.4299-1-asarai@suse.de>
X-Mailer: git-send-email 2.13.0
Return-Path: <asarai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asarai@suse.de
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

Changes in v2:

  * Reordered addition to ioctls.h to follow correct hex ordering.

Aleksa Sarai (1):
  tty: add TIOCGPTPEER ioctl

 arch/alpha/include/uapi/asm/ioctls.h   |  1 +
 arch/mips/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/ioctls.h  |  1 +
 arch/powerpc/include/uapi/asm/ioctls.h |  1 +
 arch/sh/include/uapi/asm/ioctls.h      |  1 +
 arch/sparc/include/uapi/asm/ioctls.h   |  3 +-
 arch/xtensa/include/uapi/asm/ioctls.h  |  1 +
 drivers/tty/pty.c                      | 71 ++++++++++++++++++++++++++++++++--
 include/uapi/asm-generic/ioctls.h      |  1 +
 9 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.13.0
