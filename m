Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 17:04:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47546 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008806AbaLOQEpVD3Re (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 17:04:45 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBFG4fNS027053;
        Mon, 15 Dec 2014 17:04:41 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBFG4exl027052;
        Mon, 15 Dec 2014 17:04:40 +0100
Date:   Mon, 15 Dec 2014 17:04:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/2 resend] USB: host: Remove hard-coded octeon platform
 information for ehci/ohci
Message-ID: <20141215160439.GA26674@linux-mips.org>
References: <20141215132628.GA20109@alberich>
 <20141215132841.GB20109@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215132841.GB20109@alberich>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44679
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

On Mon, Dec 15, 2014 at 02:28:41PM +0100, Andreas Herrmann wrote:

> Instead rely on device tree information for ehci and ohci.
> 
> This was suggested with
> http://www.linux-mips.org/archives/linux-mips/2014-05/msg00307.html

Please use the permanent link from that page:

  http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1401358203-60225-4-git-send-email-alex.smith%40imgtec.com

The non-permanent links might change.

  Ralf
