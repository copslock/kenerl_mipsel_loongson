Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2011 13:03:58 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:36390 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492129Ab1HRLDs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2011 13:03:48 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p7IB3fNV019583
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 18 Aug 2011 04:03:43 -0700
Date:   Thu, 18 Aug 2011 04:03:41 -0700 (PDT)
Message-Id: <20110818.040341.498460978855618496.davem@davemloft.net>
To:     manuel.lauss@googlemail.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH RESEND 4/8] MIPS: au1xxx: au1xxx-ide: remove
 pb1200/db1200 header dep
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1313658718-14144-1-git-send-email-manuel.lauss@googlemail.com>
References: <1313658718-14144-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Thu, 18 Aug 2011 04:03:44 -0700 (PDT)
X-archive-position: 30893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13152

From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Thu, 18 Aug 2011 11:11:58 +0200

> au1xxx-ide uses defines from the pb1200/db1200 headers:
> get DBDMA ID through platform resource information,
> hardcode register spacing.  The only 2 users of this driver (and
> the only boards it can really work on realiably) use the same
> register layout.
> 
> Cc: linux-ide@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> Resend: adding old-IDE Maintainer David Miller to CC's
> I'd like for this to go through the MIPS tree, as other changes in it
> depend on it.

Acked-by: David S. Miller <davem@davemloft.net>
