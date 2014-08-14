Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 16:22:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52403 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6901459AbaHNOWWOKKCV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Aug 2014 16:22:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7EEMLBi016907
        for <linux-mips@linux-mips.org>; Thu, 14 Aug 2014 16:22:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7EEMLOU016906
        for linux-mips@linux-mips.org; Thu, 14 Aug 2014 16:22:21 +0200
Date:   Thu, 14 Aug 2014 16:22:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Re: [ADMIN] Outages on linux-mips.org
Message-ID: <20140814142221.GF21008@linux-mips.org>
References: <20140813121919.GK11869@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140813121919.GK11869@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42096
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

On Wed, Aug 13, 2014 at 02:19:20PM +0200, Ralf Baechle wrote:

> In the past days there have been several outages of services provided
> by linux-mips.org due excessive load on the machine, crashes of the VM
> and its hosts system.  Resolving this is going to take some time so
> please bear with me while the machine is suffering for you ;-)

For the moment the problem appears to be under control even though
the system is processing a bunch of -stable kernels.  Touch wood ...

File corruption appears to have been limited to the mail spool so some
in transit email has been lost and you may want to consider resending.  As
for postings to the list you can check in the web archive if your posting
made it; patches to the linux-mips mailing list should also show up in
patchwork almost immediately.

  Ralf
