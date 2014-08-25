Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 16:42:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53034 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006715AbaHYOmmJz6vP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 16:42:42 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PEgfkA031653;
        Mon, 25 Aug 2014 16:42:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PEge48031652;
        Mon, 25 Aug 2014 16:42:40 +0200
Date:   Mon, 25 Aug 2014 16:42:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wei.Yang@windriver.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MIPS:KDUMP: set a right value to
 kexec_indirection_page variable
Message-ID: <20140825144240.GD25892@linux-mips.org>
References: <1406806949-27039-1-git-send-email-Wei.Yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1406806949-27039-1-git-send-email-Wei.Yang@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42224
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

On Thu, Jul 31, 2014 at 07:42:29PM +0800, Wei.Yang@windriver.com wrote:

> From: Yang Wei <Wei.Yang@windriver.com>
> 
> Since there is not indirection page in crash type, so the vaule of the head
> field of kimage structure is not equal to the address of indirection page but
> IND_DONE. so we have to set kexec_indirection_page variable to the address of
> the head field of image structure.

Applied, thanks.

Your patch applies to 3.8-stable and newer only.  If you happen to have
patches for older kernels, I'd appreciate if you post them.

Thanks,

  Ralf
