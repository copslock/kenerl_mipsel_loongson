Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:11:49 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38236 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010139AbbGLXLVLDTse (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:11:21 +0200
Received: by iggf3 with SMTP id f3so9262842igg.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=j0DduYbkUMhU/LSJP8CsNDp/PVklut2KQ7AlUCdYcqc=;
        b=EF5vQaYXZG6TH9W5AxCpIjkddEoipyVEGBtpeocWs0MDx1hnnn5odTApB9q8+6R90u
         w6XPYQRzZu+a9SRxcRR/tk56obX2ijDYDLotJ4eaEuxANmyTckGxgsVMIEGK3veo8fFT
         iJnfBcWHzot4f+CMhAhEjXZk0Dng+LpjFoM1P2OI5WNHo0361OgyDWqgEWl9UuukVSMT
         ZPzjyGi8w2QVLYFrS8OQSsqP5F+dH4OF85+Rqq5BNt72gYptKxHOUkEeY4tsjNsY9Ei4
         AznZxqREFmF2hbSUgd3ch1dNq45s/6oEopbs0V65rVQyhzxaw6VhYuS9bJhbKuxZAnsG
         Ot+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=j0DduYbkUMhU/LSJP8CsNDp/PVklut2KQ7AlUCdYcqc=;
        b=Vw047CBr6pLFGTgrvBMyG7eWHuevcl+epG5PwtOM1wiDfIOQrBFDnJaJpr6tDjWcsU
         WcoaINUW2hBV9GNkBwyZB+NeDV2oaNFAO1OkxCHfurOujCqSXA2Q8pP6AX0ihwPnTUA/
         5obfpHmOtz6TlSh0/DvC4szZQC51OU8AiwdJFcNCN+zKaYWRxj7sItbZnXdWlZYnPx7F
         2MBO2p489IvFlB7sLJkS2EdPMdnCn6C2h2+n2IzceiW8ORCEe83/o6qjWZFYwMa4ZusD
         pMzbmuMUzahkYeDqup4unjHZ4aleETVGVgxvdmjRym8XmAbjSOa1DCUTL8T/L9buO1Uc
         wLmw==
X-Gm-Message-State: ALoCoQmVGkVPuE1a5leUukqgV+seM+wu4dmRd9Rup0d4esckaf+riWg0ZIk7eBs53CNCOAvRZ1G5
X-Received: by 10.107.137.87 with SMTP id l84mr15621585iod.119.1436742675542;
        Sun, 12 Jul 2015 16:11:15 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id b140sm11390140ioe.9.2015.07.12.16.11.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:11:14 -0700 (PDT)
Subject: [PATCH 3/9] MIPS: VPE: Exit vpe_release() early if vpe_run() isn't
 defined
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:11:12 -0500
Message-ID: <20150712231112.11177.382.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

vpe_run() is a weak symbol.  If there's no definition of it, its value is
zero.

If vpe_run is zero, return failure early.  We're going to fail anyway, so
there's no point in getting a VPE and attempting to load it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/kernel/vpe.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 11da314..72cae9f 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -821,13 +821,18 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
+	if (!vpe_run) {
+		pr_warn("VPE loader: ELF load failed.\n");
+		return -ENOEXEC;
+	}
+
 	v = get_vpe(aprp_cpu_index());
 	if (v == NULL)
 		return -ENODEV;
 
 	hdr = (Elf_Ehdr *) v->pbuffer;
 	if (memcmp(hdr->e_ident, ELFMAG, SELFMAG) == 0) {
-		if ((vpe_elfload(v) >= 0) && vpe_run) {
+		if (vpe_elfload(v) >= 0) {
 			vpe_run(v);
 		} else {
 			pr_warn("VPE loader: ELF load failed.\n");
