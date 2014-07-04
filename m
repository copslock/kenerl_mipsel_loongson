Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 00:17:59 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859932AbaGDWRwsSza- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2014 00:17:52 +0200
Received: from localhost (c-76-28-255-20.hsd1.wa.comcast.net [76.28.255.20])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C2EC523;
        Fri,  4 Jul 2014 22:17:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.4 04/19] recordmcount/MIPS: Fix possible incorrect mcount_loc table entries in modules
Date:   Fri,  4 Jul 2014 15:15:14 -0700
Message-Id: <20140704221436.648412051@linuxfoundation.org>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <20140704221436.423715636@linuxfoundation.org>
References: <20140704221436.423715636@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Smith <alex.smith@imgtec.com>

commit 91ad11d7cc6f4472ebf177a6252fbf0fd100d798 upstream.

On MIPS calls to _mcount in modules generate 2 instructions to load
the _mcount address (and therefore 2 relocations). The mcount_loc
table should only reference the first of these, so the second is
filtered out by checking the relocation offset and ignoring ones that
immediately follow the previous one seen.

However if a module has an _mcount call at offset 0, the second
relocation would not be filtered out due to old_r_offset == 0
being taken to mean that the current relocation is the first one
seen, and both would end up in the mcount_loc table.

This results in ftrace_make_nop() patching both (adjacent)
instructions to branches over the _mcount call sequence like so:

  0xffffffffc08a8000:  04 00 00 10     b       0xffffffffc08a8014
  0xffffffffc08a8004:  04 00 00 10     b       0xffffffffc08a8018
  0xffffffffc08a8008:  2d 08 e0 03     move    at,ra
  ...

The second branch is in the delay slot of the first, which is
defined to be unpredictable - on the platform on which this bug was
encountered, it triggers a reserved instruction exception.

Fix by initializing old_r_offset to ~0 and using that instead of 0
to determine whether the current relocation is the first seen.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7098/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/recordmcount.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -163,11 +163,11 @@ static int mcount_adjust = 0;
 
 static int MIPS_is_fake_mcount(Elf_Rel const *rp)
 {
-	static Elf_Addr old_r_offset;
+	static Elf_Addr old_r_offset = ~(Elf_Addr)0;
 	Elf_Addr current_r_offset = _w(rp->r_offset);
 	int is_fake;
 
-	is_fake = old_r_offset &&
+	is_fake = (old_r_offset != ~(Elf_Addr)0) &&
 		(current_r_offset - old_r_offset == MIPS_FAKEMCOUNT_OFFSET);
 	old_r_offset = current_r_offset;
 
