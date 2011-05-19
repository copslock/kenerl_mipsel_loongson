Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 14:31:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56759 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491081Ab1ESMbk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 14:31:40 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JCVimb023337;
        Thu, 19 May 2011 13:31:44 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JCVhhi023335;
        Thu, 19 May 2011 13:31:43 +0100
Date:   Thu, 19 May 2011 13:31:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] MIPS: Install handlers for software IRQs
Message-ID: <20110519123143.GC18668@linux-mips.org>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
 <953858e54ceec800464756a0521abea1@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953858e54ceec800464756a0521abea1@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 16, 2010 at 02:22:33PM -0700, Kevin Cernekee wrote:

> BMIPS4350/4380/5000 CMT/SMT all use SW INT0/INT1 for inter-thread
> signaling.

I had previously ages ago applied this patch but it somehow vapolized
so I just refreshed the patch and queued it for 2.6.41, sorry.

  Ralf
