Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2012 14:00:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33572 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903608Ab2GTMAI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2012 14:00:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q6KC06rr029900;
        Fri, 20 Jul 2012 14:00:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q6KC05nc029897;
        Fri, 20 Jul 2012 14:00:05 +0200
Date:   Fri, 20 Jul 2012 14:00:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Long <codeblue@inbox.lv>
Cc:     linux-mips@linux-mips.org
Subject: Re: development board?
Message-ID: <20120720120005.GC15546@linux-mips.org>
References: <50085CB4.3030205@gmx.de>
 <20120720113817.GA14576@inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120720113817.GA14576@inbox.lv>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33945
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

On Fri, Jul 20, 2012 at 11:38:17AM +0000, John Long wrote:

> If this is too expensive or you really prefer a dev board instead of an SBC
> then what about MIPS Malta? They don't list the price on their site but it
> is supposed to be a good board with good doc and I believe various BSD
> support it in addition to Linux.
> http://www.mips.com/products/development-kits/

The Malta is very expensive and also is a very old design.  On top of that
a Malta is just an ATX-format base board which needs a CPU card.  A
typical CPU card contains one or two of the biggest FPGAs money can buy
so the CPU itself can be replaced by loading a bitfile.  That is very
appealing to hardware developers but the FPGA dictate a very juicy price.

  Ralf
