Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2013 11:04:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57258 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823113Ab3BSKEabhhIE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Feb 2013 11:04:30 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r1JA4R91027943;
        Tue, 19 Feb 2013 11:04:28 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r1JA4P51027935;
        Tue, 19 Feb 2013 11:04:25 +0100
Date:   Tue, 19 Feb 2013 11:04:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     liguang <lig.fnst@cn.fujitsu.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: remove unecessary __linux__ check
Message-ID: <20130219100425.GB5256@linux-mips.org>
References: <1361261571-1556-1-git-send-email-lig.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1361261571-1556-1-git-send-email-lig.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35788
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

On Tue, Feb 19, 2013 at 04:12:51PM +0800, liguang wrote:

> sgidefs.h has strict check for __linux__,
> it seems too harsh, as far as I test, 2 cross
> compiler for mips will not define it automatically,
> and exit build process with error
> "#error Use a Linux compiler or give up".
> remove it will not hurt, I think.

My mailbox used to get flooded by people who attempted to build a kernel
using something like a mips-elf, mips-sde-elf or even stranger targets.
There are further differences than just the definition of __linux__ so
I eventually applied this check.

  Ralf
