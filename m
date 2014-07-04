Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 17:42:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45650 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837945AbaGDPmjDCRxW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jul 2014 17:42:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s64Fga3i023778;
        Fri, 4 Jul 2014 17:42:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s64FgZ2x023777;
        Fri, 4 Jul 2014 17:42:35 +0200
Date:   Fri, 4 Jul 2014 17:42:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ed Swierk <eswierk@skyportsystems.com>, linux-mips@linux-mips.org,
        ddaney.cavm@gmail.com
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
Message-ID: <20140704154235.GM13532@linux-mips.org>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
 <20140704080641.GY804@pburton-laptop>
 <20140704085246.GH13532@linux-mips.org>
 <20140704090601.GZ804@pburton-laptop>
 <20140704093809.GI13532@linux-mips.org>
 <20140704113007.GA804@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140704113007.GA804@pburton-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41027
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

On Fri, Jul 04, 2014 at 12:30:07PM +0100, Paul Burton wrote:

> I had originally left this patch at the point I started considering
> implementing emulation for the whole ISA in the kernel, figuring I was
> going insane & should probably do something else for a while. Perhaps I
> shouldn't worry so much ;)

Full emulation is a bit problematic in particular for some of the older
CPUs which have random odd ISA extensions.  Think like a MIPS I plus a
sprinkling of MIPS II and a bucket of oddness or similar.  Getting that
right would be tedious.

  Ralf
