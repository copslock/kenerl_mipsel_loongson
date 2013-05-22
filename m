Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 09:53:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60597 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822969Ab3EVHxbIBj3s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 May 2013 09:53:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4M7rR6N012533;
        Wed, 22 May 2013 09:53:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4M7rO6i012508;
        Wed, 22 May 2013 09:53:24 +0200
Date:   Wed, 22 May 2013 09:53:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "open list:IOC3 ETHERNET DRIVER" <linux-mips@linux-mips.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/19] net/ethernet/sgi/ioc3-eth: Use module_pci_driver
 to register driver
Message-ID: <20130522075324.GA10769@linux-mips.org>
References: <1369176146-19383-1-git-send-email-peterhuewe@gmx.de>
 <1369177096-19674-12-git-send-email-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369177096-19674-12-git-send-email-peterhuewe@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36517
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

On Wed, May 22, 2013 at 12:58:07AM +0200, Peter Huewe wrote:

Looks good.

  Ralf
