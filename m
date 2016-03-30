Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 23:43:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42536 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013481AbcC3VnXVa2tw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2016 23:43:23 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2ULhMRv018998;
        Wed, 30 Mar 2016 23:43:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2ULhMDx018997;
        Wed, 30 Mar 2016 23:43:22 +0200
Date:   Wed, 30 Mar 2016 23:43:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips/defconfigs: Remove CONFIG_IPV6_PRIVACY
Message-ID: <20160330214321.GA12508@linux-mips.org>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
 <1459338168-29334-3-git-send-email-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459338168-29334-3-git-send-email-bp@alien8.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52800
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

On Wed, Mar 30, 2016 at 01:42:45PM +0200, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Option is long gone, see
> 
>   5d9efa7ee99e ("ipv6: Remove privacy config option.")
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-mips@linux-mips.org

Thanks, applied.

  Ralf
