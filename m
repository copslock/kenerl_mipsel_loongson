Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 22:10:03 +0100 (CET)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51586
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491998Ab1CDVKA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 22:10:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id E0EA924C087;
        Fri,  4 Mar 2011 13:10:31 -0800 (PST)
Date:   Fri, 04 Mar 2011 13:10:31 -0800 (PST)
Message-Id: <20110304.131031.189690288.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/12] netdev: mdio-octeon.c: Convert to use
 device tree.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1299267744-17278-11-git-send-email-ddaney@caviumnetworks.com>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
        <1299267744-17278-11-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>
Date: Fri,  4 Mar 2011 11:42:22 -0800

> Get the MDIO bus controller addresses from the device tree.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Acked-by: David S. Miller <davem@davemloft.net>
