Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2010 03:20:50 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45966
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492102Ab0DBBUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Apr 2010 03:20:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 51A6024C020;
        Thu,  1 Apr 2010 18:20:46 -0700 (PDT)
Date:   Thu, 01 Apr 2010 18:20:45 -0700 (PDT)
Message-Id: <20100401.182045.106908204.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 0/2] Fix ethernet driver for Octeon based Movidis
 hardware
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com>
References: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>
Date: Thu,  1 Apr 2010 18:17:53 -0700

> The Movidis X16 bootloader doesn't enable the mdio bus.  The first
> patch fixes this by enabling the mdio bus when the driver is
> initialized.
> 
> Also the addresses of the PHYs was unknown for this device.  The
> second patch adds the corresponding PHY addresses.
> 
> With both patches applied I can successfully use all eight Ethernet
> ports.
> 
> Please consider for 2.6.34.  Since Octeon is an embedded MIPS SOC it
> is unlikely to break the kernel for any workstations.  Any or all of
> these could be considered for merging via Ralf's linux-mips.org tree.

Ralf please merge this via your MIPS tree, thanks:

Acked-by: David S. Miller <davem@davemloft.net>
