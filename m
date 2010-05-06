Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 09:20:29 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33452
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492128Ab0EFHTB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 09:19:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 89D2824C090;
        Thu,  6 May 2010 00:19:07 -0700 (PDT)
Date:   Thu, 06 May 2010 00:19:07 -0700 (PDT)
Message-Id: <20100506.001907.116374531.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/6] netdev: octeon_mgmt: Try not to drop TX packets
 when stopping the queue.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1273100593-11043-6-git-send-email-ddaney@caviumnetworks.com>
References: <1273100593-11043-1-git-send-email-ddaney@caviumnetworks.com>
        <1273100593-11043-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>
Date: Wed,  5 May 2010 16:03:12 -0700

> Stop the queue when we add the packet that will fill it instead of dropping the packet
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Applied.
