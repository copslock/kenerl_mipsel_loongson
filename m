Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2018 00:30:36 +0200 (CEST)
Received: from mga12.intel.com ([192.55.52.136]:59835 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994621AbeJDWaVIdurv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Oct 2018 00:30:21 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 15:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,341,1534834800"; 
   d="scan'208";a="94741865"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.189.220])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2018 15:30:01 -0700
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, James Hogan <jhogan@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 0/5] termios: remove arch redundancy in <asm/termbits.h>
Date:   Thu,  4 Oct 2018 15:29:48 -0700
Message-Id: <20181004222953.2229-1-hpa@zytor.com>
X-Mailer: git-send-email 2.14.4
Return-Path: <hpa@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

<asm/termbits.h> is one of those files which define an ABI. Some were
made different due to the desire to be compatible with legacy
architectures, others were mostly direct copies of the i386
definitions, which are now in asm-generic.

This folds the IA64, MIPS, PA-RISC, and Xtensa implementations into
the generic one.  IA64 and Xtensa are identical, MIPS and PA-RISC are
trivially different and just need a handful of constants redefined.

<asm-generic/termbits.h> has a few very minor adjustments to allow this.

 arch/ia64/include/uapi/asm/termbits.h   | 210 +-----------------------------
 arch/mips/include/uapi/asm/ioctls.h     |   2 +
 arch/mips/include/uapi/asm/termbits.h   | 213 ++----------------------------
 arch/parisc/include/uapi/asm/termbits.h | 197 +---------------------------
 arch/xtensa/include/uapi/asm/termbits.h | 222 +-------------------------------
 include/uapi/asm-generic/termbits.h     |   7 +-
 6 files changed, 27 insertions(+), 824 deletions(-)

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Helge Deller <deller@gmx.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: <linux-ia64@vger.kernel.org>
Cc: <linux-mips@linux-mips.org>
Cc: <linux-parisc@vger.kernel.org>
Cc: <linux-xtensa@linux-xtensa.org>
