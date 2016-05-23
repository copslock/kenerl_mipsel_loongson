Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 22:01:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37522 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27033511AbcEWUBslyZnY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 May 2016 22:01:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4NK1laV005204;
        Mon, 23 May 2016 22:01:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4NK1lgC005203;
        Mon, 23 May 2016 22:01:47 +0200
Date:   Mon, 23 May 2016 22:01:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
Message-ID: <20160523200147.GC24125@linux-mips.org>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160523152007.GB28729@linux-mips.org>
 <5743529A.4070506@gentoo.org>
 <20160523192219.GB24125@linux-mips.org>
 <57435CB4.5080609@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57435CB4.5080609@gentoo.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53625
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

On Mon, May 23, 2016 at 03:40:36PM -0400, Joshua Kinard wrote:

> >    * THP still has issues on R1x000 CPUs, so user beware.  YMMV.

As of now I think you can remove the "on R1x000 CPUs, " part, it seems.

> Might try some of those combinations and see if things improve on the Octeon?
> IP27 was equally affected by this, minus the bits about RAM and Impact Gfx.
> turning off THP, IP30 can run 64KB PAGE_SIZE without issue (compiles of
> packages is actually sped up quite significantly under >4KB PAGE_SIZE).
> 
> IP27 has a bug in it somewhere that causes an immediate Oops on 64KB PAGE_SIZE
> that I haven't traced down yet (I have the Oops saved somewhere if needed).  So
> I use 16KB on that system.

> An O2 w/ an RM7000 has virtually no issues at all with 64KB or 16KB PAGE_SIZE
> and THP, though it's been several months since I last booted my O2.

Rather different CPU and notably one that doesn't have any fancy
anti-alias protection afair.

  Ralf
