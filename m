Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 00:18:55 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44691 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492430Ab0BWXSv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 00:18:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1NNInYo002656;
        Wed, 24 Feb 2010 00:18:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1NNImYE002654;
        Wed, 24 Feb 2010 00:18:48 +0100
Date:   Wed, 24 Feb 2010 00:18:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, wuzhangjin@gmail.com
Subject: Re: [PATCH -queue] loongson2: fix compile error on
 arch/mips/oprofile/op_model_loongson2.c
Message-ID: <20100223231848.GA31516@linux-mips.org>
References: <201002211846.22504.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201002211846.22504.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 21, 2010 at 06:46:22PM +0100, Florian Fainelli wrote:

> flags is now an unused variable, causing a build failure due to -Werror
> being turned on.

Thanks, fixed that in the original patch that broke things.

  Ralf
