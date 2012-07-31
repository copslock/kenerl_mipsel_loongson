Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2012 17:10:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51996 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903690Ab2GaPKI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2012 17:10:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q6VFA6G2020406;
        Tue, 31 Jul 2012 17:10:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q6VFA5fL020405;
        Tue, 31 Jul 2012 17:10:05 +0200
Date:   Tue, 31 Jul 2012 17:10:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, loongson-dev@googlegroups.com
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
Message-ID: <20120731151005.GB14151@linux-mips.org>
References: <20120615234641.6938B58FE7C@mail.viric.name>
 <20120731134001.GA14151@linux-mips.org>
 <20120731140723.GB25996@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20120731140723.GB25996@vicerveza.homeunix.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34006
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jul 31, 2012 at 04:07:23PM +0200, Lluís Batlle i Rossell wrote:

> Maybe there could be a cleaner declaration of that intention, though. The only
> code there was "I herewith declare: this does not happen.  So send SIGBUS."

To give you an idea, the emulation is on the order of a 1000 times slower
than the processing a properly aligned load in hardware.  And even where
hardware does unaligned handling such as on x86 there still is a performance
penalty though that would far less severe.

So given that proper alignment is always the right thing.  There are very
few cases were handling misalignment in software is justified, for example
the IP stack.  Even the checks if a packet is misaligned would cause a
performance penalty and it's (assuming sane networking hardware) a very
rare event.

lwl/lwr in the IP stack would be a bad tradeoff.  It's faster than the
unaligned exception handler but would slow down processing of every
correctly aligned packet.  So lwl/lwr are only a good choice where a high
fraction of misaligned packets is expected.

  Ralf
