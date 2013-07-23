Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jul 2013 00:28:07 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43331 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727Ab3GWW2FMiB9z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jul 2013 00:28:05 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F7CDAC3;
        Tue, 23 Jul 2013 22:27:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [ 091/103] MIPS: Octeon: Dont clobber bootloader data structures.
Date:   Tue, 23 Jul 2013 15:26:42 -0700
Message-Id: <20130723220431.420250347@linuxfoundation.org>
X-Mailer: git-send-email 1.8.3.rc0.20.gb99dd2e
In-Reply-To: <20130723220418.532514378@linuxfoundation.org>
References: <20130723220418.532514378@linuxfoundation.org>
User-Agent: quilt/0.60-5.1.1
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37366
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

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

commit d949b4fe6d23dd92b5fa48cbf7af90ca32beed2e upstream.

Commit abe77f90dc (MIPS: Octeon: Add kexec and kdump support) added a
bootmem region for the kernel image itself.  The problem is that this
is rounded up to a 0x100000 boundary, which is memory that may not be
owned by the kernel.  Depending on the kernel's configuration based
size, this 'extra' memory may contain data passed from the bootloader
to the kernel itself, which if clobbered makes the kernel crash in
various ways.

The fix: Quit rounding the size up, so that we only use memory
assigned to the kernel.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/5449/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -996,7 +996,7 @@ void __init plat_mem_setup(void)
 	cvmx_bootmem_unlock();
 	/* Add the memory region for the kernel. */
 	kernel_start = (unsigned long) _text;
-	kernel_size = ALIGN(_end - _text, 0x100000);
+	kernel_size = _end - _text;
 
 	/* Adjust for physical offset. */
 	kernel_start &= ~0xffffffff80000000ULL;
