Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 02:01:38 +0100 (CET)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43458
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493401Ab0AGBBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 02:01:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 383C424C140;
        Wed,  6 Jan 2010 17:01:39 -0800 (PST)
Date:   Wed, 06 Jan 2010 17:01:38 -0800 (PST)
Message-Id: <20100106.170138.71108684.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 2/3] Staging: Octeon Ethernet: Clean up and convert to
 NAPI.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1262825836-9457-2-git-send-email-ddaney@caviumnetworks.com>
References: <4B4530F3.1070701@caviumnetworks.com>
        <1262825836-9457-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 25526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4576

From: David Daney <ddaney@caviumnetworks.com>
Date: Wed,  6 Jan 2010 16:57:15 -0800

> Convert the driver to be a reasonably well behaved NAPI citizen.  Also
> clean up memory allocation and tx buffer accounding code.  Remove some
> configuration #defines and other unused code that are not applicable
> to the in-tree driver.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Please seperate the cleanups and conversion to NAPI into seperate
patches.

Doing both at the same time makes your patch impossible to review.
