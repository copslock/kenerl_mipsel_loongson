Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jun 2018 20:21:11 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60974 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeFJSVBVjKd0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jun 2018 20:21:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D65153FA39;
        Sun, 10 Jun 2018 20:21:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D0q08O3GPzYw; Sun, 10 Jun 2018 20:21:00 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id F35233FA16;
        Sun, 10 Jun 2018 20:20:59 +0200 (CEST)
Date:   Sun, 10 Jun 2018 20:20:58 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@linux-mips.org
Cc:     "Maciej W. Rozycki" <macro@mips.com>
Subject: [RFC] MIPS: Align vmlinuz load address to a page boundary
Message-ID: <20180610182056.GA15738@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

The kexec system call seems to require that the vmlinuz loading address is
aligned to a page boundary. 4096 bytes is a fairly common page size, but
perhaps not the only possibility? Does kexec require additional alignments?

Fredrik

Signed-off-by: Fredrik Noring <noring@nocrew.org>

--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -44,12 +44,8 @@ int main(int argc, char *argv[])
 	vmlinux_size = (uint64_t)sb.st_size;
 	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
 
-	/*
-	 * Align with 16 bytes: "greater than that used for any standard data
-	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
-	 */
-
-	vmlinuz_load_addr += (16 - vmlinux_size % 16);
+	/* The kexec system call requires page alignment. */
+	vmlinuz_load_addr += (4096 - vmlinux_size % 4096);
 
 	printf("0x%llx\n", vmlinuz_load_addr);
 
