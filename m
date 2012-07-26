Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2012 21:42:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48236 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1901173Ab2GZTmY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jul 2012 21:42:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q6QJgOKf015190;
        Thu, 26 Jul 2012 21:42:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q6QJgNm2015189;
        Thu, 26 Jul 2012 21:42:23 +0200
Date:   Thu, 26 Jul 2012 21:42:23 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     kr kr <kr-jiffy@yandex.ru>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [mips32r1 cpu] Advice needed: "Machine Check exception - caused
 by multiple matching entries in the TLB"
Message-ID: <20120726194222.GA23351@linux-mips.org>
References: <194011342123405@web6e.yandex.ru>
 <20120720091602.GA15546@linux-mips.org>
 <189641343064148@web3g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189641343064148@web3g.yandex.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33987
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

On Mon, Jul 23, 2012 at 09:22:28PM +0400, kr kr wrote:

> But, in case of, say, Malta, we don't need to turn on (or turn off) some
> special CONFIG_* options in order to make it run MIPS-I binaries (which
> Debian provides), whereas MIPS32 binaries are native for the board?

No, there's nothing to be configured.  That why it's called backward
compatibility.

  Ralf
