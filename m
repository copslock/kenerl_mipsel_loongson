Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 17:44:22 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:47284 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823005Ab3H3PnyfUXaO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Aug 2013 17:43:54 +0200
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 0/3] MIPS: add uImage build target
Date:   Fri, 30 Aug 2013 16:42:39 +0100
Message-ID: <1377877362-15650-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_30_16_43_05
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

This adds a uImage build target for MIPS. The first two patches clean up
the Makefiles slightly to allow the load and entry address to be passed
nicely to arch/mips/boot/Makefile, and the final patch adds the uImage
targets.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org

Changes in v2:
 - Split into several patches to add refactoring which avoids duplicated
   load/entry address calculations (Florian).
 - Disable uImage targets when load address < 0xffffffff80000000 (e.g.
   SGI IP27).

James Hogan (3):
  MIPS: refactor boot and boot/compressed rules
  MIPS: refactor load/entry address calculations
  MIPS: add uImage build target

 arch/mips/Makefile                 | 34 +++++++++++++++++++++++++++++-----
 arch/mips/boot/.gitignore          |  1 +
 arch/mips/boot/Makefile            | 15 +++++++++++++++
 arch/mips/boot/compressed/Makefile |  2 +-
 arch/mips/lasat/image/Makefile     |  6 ++----
 5 files changed, 48 insertions(+), 10 deletions(-)

-- 
1.8.1.2
