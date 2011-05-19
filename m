Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 01:22:27 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59790 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491078Ab1ESXWY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2011 01:22:24 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JNMMLO025899;
        Fri, 20 May 2011 00:22:22 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JNMLTf025898;
        Fri, 20 May 2011 00:22:21 +0100
Date:   Fri, 20 May 2011 00:22:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        Namhyung Kim <namhyung@gmail.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] Remove Alchemy OSS drivers?
Message-ID: <20110519232221.GC10628@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

OSS has very little if any useful life in it left for MIPS, at least from
my perspective.  So I propose to remove the Au1550 driver - there is an
ALSA replacement for it available.

Anybody against it?  Are there still any remaining features or platforms
that are only supported by the OSS driver?

The OSS code is so backwards that I'd like to retire the possible remaining
MIPS users and then make OSS unavailable in Kconfig for MIPS.

  Ralf
