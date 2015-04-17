Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 14:36:45 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:55488 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009990AbbDQMgnniaXK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 14:36:43 +0200
Received: from localhost.localdomain (unknown [78.54.181.212])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id A15FF4C803A;
        Fri, 17 Apr 2015 14:34:22 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATH] MIPS: ath79: Various small fix to prepare OF support
Date:   Fri, 17 Apr 2015 14:36:13 +0200
Message-Id: <1429274178-4337-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

This first small serie allow using ZBOOT, fix a few errors in the
registers definitions and rework the DDR controller interface.
The DDR controller interface patch is mostly to simplify the IRQ
controller code before adding OF support.

Following this will a be serie that add the OF bindings and code
support for the core component of the SoC as well as a DTS for the
TL-WR1043ND.
