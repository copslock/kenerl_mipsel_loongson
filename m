Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Aug 2013 10:52:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:34202 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815746Ab3HSIwEBmdHl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Aug 2013 10:52:04 +0200
X-IronPort-AV: E=Sophos;i="4.89,912,1367964000"; 
   d="scan'208";a="29716856"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Aug 2013 10:51:57 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 0/6] simplify platform_get_resource_byname/devm_ioremap_resource
Date:   Mon, 19 Aug 2013 10:51:50 +0200
Message-Id: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.7.8.6
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37583
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

devm_ioremap_resource often uses the result of a call to
platform_get_resource_byname as its last argument.  devm_ioremap_resource
does appropriate error handling on this argument, so error handling can be
removed from the call to platform_get_resource_byname.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l,f;
expression list es;
@@

(
  res = f(...);
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  e = devm_ioremap_resource(e1, res);
|
- res = f(es);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = f(es);
  e = devm_ioremap_resource(e1, res);
)
// </smpl>

In practice, f is always platform_get_resource_byname (or
platform_get_resource, which was handled by a previous patch series).  And
the call to platform_get_resource_byname always immediately precedes the
call to devm_ioremap_resource.
