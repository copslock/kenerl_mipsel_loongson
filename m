Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 13:41:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52231 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007476AbbFELl30GCg2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jun 2015 13:41:29 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t55BfSLD001949;
        Fri, 5 Jun 2015 13:41:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t55BfSYF001946;
        Fri, 5 Jun 2015 13:41:28 +0200
Date:   Fri, 5 Jun 2015 13:41:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/2]: MIPS: IP27: Xtalk detection cleanups
Message-ID: <20150605114127.GC26432@linux-mips.org>
References: <556366E4.70407@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556366E4.70407@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47885
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

On Mon, May 25, 2015 at 02:16:04PM -0400, Joshua Kinard wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> 
> This is the second patch of two to clean up/update the Xtalk detection
> code used by IP27 with some of the code used in the IP30 port.
> 
> This specific patch replaces some of the IP27 Xtalk detection code with
> methods used in the IP30 port, and converts the Xtalk devices into
> platform devices.

Hm...  that all is good cleanup but registration as platform device doesn't
help if there's no matching platform driver.  I assume you have something
like that as part of your yet unpublished patches?

  Ralf
