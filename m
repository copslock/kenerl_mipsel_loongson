Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 13:22:50 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43771 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491067Ab0E0LWq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 May 2010 13:22:46 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4RBMgAX021185;
        Thu, 27 May 2010 12:22:42 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4RBMfcY021183;
        Thu, 27 May 2010 12:22:41 +0100
Date:   Thu, 27 May 2010 12:22:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.s.daney@gmail.com>
Cc:     wuzhangjin@gmail.com, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 7/9] tracing: MIPS: Reduce the overhead of dynamic
 Function Tracer
Message-ID: <20100527112241.GD16894@linux-mips.org>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
 <6b4495690164114ff7353c86f6b53b979fca2756.1273834562.git.wuzhangjin@gmail.com>
 <4BED8524.8010805@gmail.com>
 <1273891425.8552.12.camel@localhost>
 <4BF02587.5020303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF02587.5020303@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 16, 2010 at 10:04:07AM -0700, David Daney wrote:

> Yes, that seems good to me.  I just wanted to make sure that this
> wasn't being called from non-init code.

Worst case there's always CONFIG_DEBUG_SECTION_MISMATCH.

  Ralf
