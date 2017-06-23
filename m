Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 18:13:57 +0200 (CEST)
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:19297 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993853AbdFWQNulG7H2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 18:13:50 +0200
Received: from localhost.localdomain ([92.140.158.134])
        by mwinf5d14 with ME
        id cGDj1v00D2uGBYk03GDjKe; Fri, 23 Jun 2017 18:13:45 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Jun 2017 18:13:45 +0200
X-ME-IP: 92.140.158.134
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     christophe.jaillet@wanadoo.fr, ralf@linux-mips.org,
        james.hogan@imgtec.com, Steven.Hill@cavium.com,
        david.daney@cavium.com
Cc:     linux-mips@linux-mips.org, kernel-janitors@vger.kernel.org
Subject: [RFC] MIPS: OCTEON: Spurious code in 'arch/mips/cavium-octeon/octeon-usb.c'
Date:   Fri, 23 Jun 2017 18:13:39 +0200
Message-Id: <20170623161339.7159-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.11.0
Return-Path: <christophe.jaillet@wanadoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.jaillet@wanadoo.fr
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

Hi,

The coccinelle script located at https://github.com/coccinelle/coccinellery/blob/master/notnull/notnull2.cocci
triggered a spurious code in 'arch/mips/cavium-octeon/octeon-usb.c'

It seems that 'dwc3_octeon_device_init()' can never return success (i.e. 0).
The 'do...while' loop exits only if 'node == NULL'. But, in such a case,
-ENODEV will be returned at the beginning of the loop.

I may miss something obvious, but I can't see how this code is supposed to
work.

Best regards.

CJ
