Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2012 12:18:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60182 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6870515Ab2JLKSW1Kqud (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Oct 2012 12:18:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9CAIIdI012674;
        Fri, 12 Oct 2012 12:18:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9CAIHLY012673;
        Fri, 12 Oct 2012 12:18:17 +0200
Date:   Fri, 12 Oct 2012 12:18:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ronny Meeus <ronny.meeus@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: 2GB userspace limitation in ABI N32
Message-ID: <20121012101817.GC30020@linux-mips.org>
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com>
 <20121010080756.GC6740@linux-mips.org>
 <CAMJ=MEeSxpcLRCWmkOn7w4Ge1J9Bg7_bFN+Z8xPoYumGFddabA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJ=MEeSxpcLRCWmkOn7w4Ge1J9Bg7_bFN+Z8xPoYumGFddabA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34688
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

On Wed, Oct 10, 2012 at 05:12:16PM +0200, Ronny Meeus wrote:

> Do you have any clue (rough) on the amount of effort this change would cost?

David Daney's reply should give you more information for an estimate.

> About the limited gain we can discuss: if you have a large application
> that has been created assuming 32bit and it needs to be ported to a
> 64bit architecture, I think the effort can be huge and the risk for
> forgetting things is high. It will be very hard to check whether the
> system behaves well under all conditions.

A 64-bit port could start right away without the delay of waiting for
a usable N32-4GB.  Added benefit - with N64 you can grow beyond the 3GB.

Downside, due to larger pointers thus better cache locality 32-bit code
generally performs better.  And I agree that verification of N32-4GB
probably is easier than for a large application that wasn't written
with the intend of 64-bit support.

In my past as a contractor I've dealth with a few customers who were
trying to avoid going 64-bit at all cost.  They had to pay that cost ...

  Ralf
