Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2014 22:35:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17423 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822083AbaCZVfKaVzSc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2014 22:35:10 +0100
X-IronPort-AV: E=Sophos;i="4.97,737,1389740400"; 
   d="scan'208";a="64902681"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Mar 2014 22:35:04 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-hams@vger.kernel.org
Subject: [PATCH 0/7] replace del_timer by del_timer_sync
Date:   Wed, 26 Mar 2014 22:33:38 +0100
Message-Id: <1395869625-15209-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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

These patches replace del_timer by del_timer_sync in module_exit functions.
