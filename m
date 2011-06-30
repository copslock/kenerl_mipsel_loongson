Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 11:18:17 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42070 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491023Ab1F3JSO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jun 2011 11:18:14 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5U9HwVR016412;
        Thu, 30 Jun 2011 10:17:58 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5U9HsK9016404;
        Thu, 30 Jun 2011 10:17:54 +0100
Date:   Thu, 30 Jun 2011 10:17:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, florian@linux-mips.org,
        Florian Fainelli <florian@openwrt.org>,
        linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: SB16 build error.
Message-ID: <20110630091754.GA12119@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24749

Found on a MIPS build but certain other architectures will have the same
issue:

  CC      sound/isa/sb/sb16_csp.o
sound/isa/sb/sb16_csp.c: In function ‘snd_sb_csp_ioctl’:
sound/isa/sb/sb16_csp.c:228: error: case label does not reduce to an integer constant
make[1]: *** [sound/isa/sb/sb16_csp.o] Error 1
make: *** [sound/isa/sb/sb16_csp.o] Error 2

This error message is caused by the _IOC_TYPECHECK() error check triggering
due to excessive ioctl size on Alpha, PowerPC, MIPS and SPARC which define
_IOC_SIZEBITS as 13.  On all other architectures define it as 14 so struct
snd_sb_csp_microcode with it's little over 12kB will just about fit into
the 16kB limit.

  Ralf
