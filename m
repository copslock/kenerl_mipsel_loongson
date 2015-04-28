Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 07:51:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64920 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011910AbbD1Fve2sQmW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 07:51:34 +0200
X-IronPort-AV: E=Sophos;i="5.11,662,1422918000"; 
   d="scan'208";a="137870830"
Received: from 198.67.28.109.rev.sfr.net (HELO hadrien) ([109.28.67.198])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Apr 2015 07:51:30 +0200
Date:   Tue, 28 Apr 2015 07:51:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@localhost6.localdomain6
To:     linux-mips@linux-mips.org
Subject: question about vrc4173_cardu.c
Message-ID: <alpine.DEB.2.02.1504280751160.2081@localhost6.localdomain6>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia.lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47112
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

Hello,

Is there any need to keep drivers/pcmcia/vrc4173_cardu.c in the kernel?  
It contains the code INIT_WORK(&socket->tq_work, cardu_bh, socket);.  
INIT_WORK has not had three arguments since Linux 2.6.19, so I don't think 
that it is possible for this code to compile.

julia
