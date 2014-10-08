Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 03:33:26 +0200 (CEST)
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:48578 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010187AbaJHBdYOZ1PZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 03:33:24 +0200
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-05v.sys.comcast.net with comcast
        id 0RZ91p00456HXL001RZENe; Wed, 08 Oct 2014 01:33:14 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-po-12v.sys.comcast.net with comcast
        id 0RZD1p0033aNLgd01RZDhs; Wed, 08 Oct 2014 01:33:14 +0000
Message-ID: <54349450.50505@gentoo.org>
Date:   Tue, 07 Oct 2014 21:33:04 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: IP22/IP32: Add line to arch/mips/Makefile archhelp
 about vmlinux.32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1412731994;
        bh=G0gWFmrKQfofmCao1SuyrttCDhr3qpcTPqbXWZ0vwCQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=oXBglvUYOiSKacfElh8HMbPEX7BKxjkiWE3gI2MdcQqcJ8bfitt6FzQY4eD8DlEV6
         t7pFhCyXgkt/239rTaJZvy0Nz9F8BxULJSk2JEePOwBEJHK4f2dm7kzsGoi7+cM11w
         NmhDBbNvpfK0cTI8Q1tL6qSYpui6Y7B/wLh8keypG54E//PMC9R7teabfCuCGTeJdq
         D0Dze9FThC8XQU5ndv18JkWPRMCu4SyQIXkz+e8qlODybrrqO5Na6O/EsX0/Byl3V6
         AZM24TTfo0v7gYCJvec6pTf3pwR7iVpjZxCc1U1S1FA1VmJ59z1QmdhtOKaOcBo3ph
         nHvNWp8T88ElQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Building a 64bit kernel for the SGI O2 (IP32) and the SGI Indy (IP22) uses the
'vmlinux.32' target, which converts the output 64-bit 'vmlinux' image into a
32-bit wrapped image.  This is needed for certain revisions of the IP22 and
IP32 ARCS PROMs to boot correctly, but this target is missing from the
'archhelp' info that is emitted by 'make help'.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index faa7aa4..ed6911c 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -365,6 +365,7 @@ define archhelp
 	echo '  vmlinux.ecoff        - ECOFF boot image'
 	echo '  vmlinux.bin          - Raw binary boot image'
 	echo '  vmlinux.srec         - SREC boot image'
+	echo '  vmlinux.32           - 64-bit boot image wrapped in 32bits (IP22/IP32)'
 	echo '  vmlinuz              - Compressed boot(zboot) image'
 	echo '  vmlinuz.ecoff        - ECOFF zboot image'
 	echo '  vmlinuz.bin          - Raw binary zboot image'
