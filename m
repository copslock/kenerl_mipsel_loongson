Return-Path: <SRS0=V/Ym=WS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E623DC3A5A1
	for <linux-mips@archiver.kernel.org>; Thu, 22 Aug 2019 22:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E672082F
	for <linux-mips@archiver.kernel.org>; Thu, 22 Aug 2019 22:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfHVWcb (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:32:31 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:47178 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731886AbfHVWcb (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 22 Aug 2019 18:32:31 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 18:32:30 EDT
Received: from darkstar.musicnaut.iki.fi (85-76-87-181-nat.elisa-mobile.fi [85.76.87.181])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 2343DB0028;
        Fri, 23 Aug 2019 01:25:50 +0300 (EEST)
Date:   Fri, 23 Aug 2019 01:25:50 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, linux-mips@vger.kernel.org
Subject: r8169: regression on MIPS/Loongson
Message-ID: <20190822222549.GF30291@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

After upgrading from v5.2 to v5.3-rc5 on MIPS/Loongson board, copying
large files from network with scp started to fail with "Integrity error".
Bisected to:

f072218cca5b076dd99f3dfa3aaafedfd0023a51 is the first bad commit
commit f072218cca5b076dd99f3dfa3aaafedfd0023a51
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Thu Jun 27 23:19:09 2019 +0200

    r8169: remove not needed call to dma_sync_single_for_device

Any idea what goes wrong? Should this change be reverted?

A.
