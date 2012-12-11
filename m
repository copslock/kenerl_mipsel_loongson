Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2012 12:14:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53521 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823908Ab2LKLObMfguU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Dec 2012 12:14:31 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qBBBETxi027300;
        Tue, 11 Dec 2012 12:14:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qBBBESgY027266;
        Tue, 11 Dec 2012 12:14:28 +0100
Date:   Tue, 11 Dec 2012 12:14:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RM9000 / E9000, MSP71xx class processors, SOCs and eval boards
Message-ID: <20121211111427.GA23572@linux-mips.org>
References: <20121206160052.GB32620@linux-mips.org>
 <CACoURw7JTFMzmcRZHmBchcWPC8x5LFFfC1nGH-Xxc8f3KjNE2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACoURw7JTFMzmcRZHmBchcWPC8x5LFFfC1nGH-Xxc8f3KjNE2Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35251
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

On Thu, Dec 06, 2012 at 03:28:17PM -0600, Shane McDonald wrote:

> I'm interested in the MSP71xx eval board, although I may be
> the only person in the world who cares.  Specifically, I use the
> msp71xx_defconfig.  3.7-rc8 compiles with gcc-4.6.3
> without requiring any patches.
> 
> I don't know when the last time the RM9000 was compilable,
> but I have no interest in that, nor do I have interest in the
> FPGA or eval board versions of the MSP7120 (no hardware to
> test with).
> 
> I had hoped that someone from PMC-Sierra would respond, but
> maybe they don't care anymore...

Being a crazy tradition set by the Sparc AP1000, I'm happy with a single
user :-)

The Yosemite stuff scores higher on my kill list anyway.  The board
support code was never too great but that's not the issue; the SOC's
network driver which is rotting away in the linux-mips.org git tree as
the last change that can't be merged upstream as it is, stopped even
compiling ages ago and while a superior replacement has been posted,
nobody cared enough to get it into mergeable shape.

Now that 3.7 is finally released, hasta la vista, Yosemite.

  Ralf
