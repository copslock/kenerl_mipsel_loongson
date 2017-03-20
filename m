Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 17:51:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58324 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993878AbdCTQuu3wqw9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Mar 2017 17:50:50 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2KGonYG014520;
        Mon, 20 Mar 2017 17:50:49 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2KGonnc014519;
        Mon, 20 Mar 2017 17:50:49 +0100
Date:   Mon, 20 Mar 2017 17:50:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 4.4 08/35] MIPS: Update lemote2f_defconfig for
 CPU_FREQ_STAT change
Message-ID: <20170320165049.GH14919@linux-mips.org>
References: <20170316142906.685052998@linuxfoundation.org>
 <20170316142907.261390617@linuxfoundation.org>
 <1489939579.2852.72.camel@decadent.org.uk>
 <20170320101530.GD14919@linux-mips.org>
 <20170320162957.GB23463@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320162957.GB23463@kroah.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57400
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

On Mon, Mar 20, 2017 at 05:29:57PM +0100, Greg Kroah-Hartman wrote:

> > I don't think so, I don't get warnings for "make ARCH=mips lemote2f_defconfig"
> 
> Ok, is it worth reverting as this is an issue on later kernels?

Same answer as for the other patch - I can't imagine it's going to cause
any problems.

  Ralf
