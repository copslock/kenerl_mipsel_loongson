Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2012 15:34:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59727 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903637Ab2G3New (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2012 15:34:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q6UDYnui032036;
        Mon, 30 Jul 2012 15:34:49 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q6UDYlM2032035;
        Mon, 30 Jul 2012 15:34:47 +0200
Date:   Mon, 30 Jul 2012 15:34:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org,
        FlorianSchandinat@gmx.de
Subject: Re: [PATCH] Fix newport con crashes
Message-ID: <20120730133447.GA29993@linux-mips.org>
References: <20120730105416.DBB961D1CF@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120730105416.DBB961D1CF@solo.franken.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33997
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

On Mon, Jul 30, 2012 at 12:54:16PM +0200, Thomas Bogendoerfer wrote:

> Because of commit e84de0c61905030a0fe66b7210b6f1bb7c3e1eab
> [MIPS: GIO bus support for SGI IP22/28] newport con is now taking over
> console from dummy con, therefore it's necessary to resize the VC to
> the correct size to avoid crashes and garbage on console
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

I've applied your patch to master and the affected -stable branches of the
lmo git tree.

Florian, since this is a driver specific to certain MIPS platforms I'd like
to merge it through the MIPS tree with your ack, if that's ok?

Thanks folks,

  Ralf
