Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jun 2013 13:59:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38185 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824788Ab3FPL7fNq7IE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jun 2013 13:59:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5GBxUs9030217;
        Sun, 16 Jun 2013 13:59:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5GBxRk6030216;
        Sun, 16 Jun 2013 13:59:27 +0200
Date:   Sun, 16 Jun 2013 13:59:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.s.daney@gmail.com>
Cc:     Gleb Natapov <gleb@redhat.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Sanjay Lal <sanjayl@kymasys.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
Message-ID: <20130616115926.GM20046@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <51B26974.5000306@caviumnetworks.com>
 <20130609073115.GE4725@redhat.com>
 <51B50E87.2060501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51B50E87.2060501@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36935
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

On Sun, Jun 09, 2013 at 04:23:51PM -0700, David Daney wrote:

> Come to think of it, Emulating SGI hardware might be an interesting
> case.  There may be old IRIX systems and applications that could be
> running low on real hardware.  Some of those systems take up a whole
> room and draw a lot of power.  They might run faster and at much
> lower power consumption on a modern 48-Way SMP SoC based system.

Many SGI MIPS system have RTCs powered by builtin batteries with a
nominal livetime of ten years and for which no more replacements are
available.  This is beginning to limit usable SGI MIPS systems to those
who know how to solve these issues with a Dremel and a soldering iron.

That said, SGI platforms are all more or less weird custom architectures
so the platform emulation - let alone the firmware blobs - will be a
chunk of work.

  Ralf
