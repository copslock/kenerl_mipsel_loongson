Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Aug 2013 17:44:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43830
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828015Ab3HMPn4m9jzF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Aug 2013 17:43:56 +0200
X-IronPort-AV: E=Sophos;i="4.89,870,1367964000"; 
   d="scan'208";a="23862017"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Aug 2013 17:43:50 +0200
Date:   Tue, 13 Aug 2013 17:43:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: question about drivers/net/ethernet/sgi
Message-ID: <alpine.DEB.2.02.1308131742100.2263@hadrien>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia.lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia.lawall@lip6.fr
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

The files in drivers/net/ethernet/sgi (meth.c and ioc3-eth.c) both use
alloc_skb.  Is there a reason why they do not use netdev_alloc_skb, like
most other ethernet drivers?

thanks,
julia
