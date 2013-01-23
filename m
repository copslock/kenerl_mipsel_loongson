Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 13:14:00 +0100 (CET)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41395 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833402Ab3AWMN7htCFw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 13:13:59 +0100
Received: by mail-wi0-f174.google.com with SMTP id hq4so632404wib.13
        for <multiple recipients>; Wed, 23 Jan 2013 04:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Buu41WyhP5DF7zOdjjLGomDK9DtRxQrUi9HKagfUDuI=;
        b=JuTX+nuo9NjaKuU4FTaYFvp2x23nsGODtIUBJ/RLMhElI1+A2chZ9WoYwqpFVUte0D
         lxC0Ikd+t/E5kow81yJIQr4rvCRHW9/rU/wIDvMlOPea+/8ptZNBV56iQwKSRBrl6lmA
         awAluy7rvPGcfiskQJQRLmU41Sjr/itT1CeBsyTmVY0jwWGaJalLjnPCSOyIPFPwe9u3
         KSbdIyE1AqB5L4jvzwmEBacbhh136tyLeRO7qd0aXA4WZwewjn9sgWVHDY4azaPuA0Tt
         y0dJfbs5f+vJDbuDuT93wUA/4ehcbupjzpMBx7uqbhqdIxbqZLBGSdLQRN5i5vRhYP6A
         5P9Q==
MIME-Version: 1.0
X-Received: by 10.180.88.134 with SMTP id bg6mr2076897wib.26.1358943234005;
 Wed, 23 Jan 2013 04:13:54 -0800 (PST)
Received: by 10.216.72.134 with HTTP; Wed, 23 Jan 2013 04:13:53 -0800 (PST)
Date:   Wed, 23 Jan 2013 13:13:53 +0100
Message-ID: <CACna6ryD3SjLN-oauvVuRa+q7an8DaULj+Uj4bwFSzQf2WCvMw@mail.gmail.com>
Subject: Upcoming cross-tree build breakage on merge window
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     john@phrozen.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-mips@linux-mips.org,
        Network Development <netdev@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

I've noticed possible build breakage when two trees get merged:
net-next and linux-john (MIPS).

This is about two following commits:
http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git;a=commit;h=dd4544f05469aaaeee891d7dc54d66430344321e
http://git.linux-mips.org/?p=john/linux-john.git;a=commit;h=a008ca117bc85a9d66c47cd5ab18a6c332411919

The first one adds "bgmac" driver which uses asm/mach-bcm47xx/nvram.h
and nvram_getenv. The second one renames them.

Can you handle this in some clever way during merge window, please?

The fix is trivial:
1) Use <bcm47xx_nvram.h>
2) Use bcm47xx_nvram_getenv

-- 
Rafał
