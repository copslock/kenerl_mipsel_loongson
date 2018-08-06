Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 18:28:26 +0200 (CEST)
Received: from cpanel4.indieserve.net ([199.212.143.9]:53006 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994637AbeHFQ2WwR4cG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2018 18:28:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AUiCoM4TBWBMSspHa5/ys/BnJWlfjtdIBABlKvFNT9I=; b=Rat9C4TABjQqDomz65Ec6AstJT
        ktEBvARgm2KqmJWAnIWwtF54ywUOsc0aRFQI1aKzux6QD7Qu/FnpDkRjWaM1/MUApyoLrqjdMRcrZ
        P4u4zBFGTEK1jIKXFn915JzzduodehXEunXQVX7nA1qYxABHUDuviu+yYBblff4NvALGjt+soa0XP
        hIm/W4cknuu9W2GIW3F84VLd4zCmDC5/4brlyq5QvSgaceFjRLPhcaMQZskfmKyfHTTS7PXpeYv7V
        CUXyOC4ouuaA1aMNNFTNhslKesC8lksQddStk096olr6EwiaMk0tw0G/mwNOhU3bsdgHvMIPFxXoO
        NZKqRmBA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:38388 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fmiMl-00BRpf-El; Mon, 06 Aug 2018 12:28:20 -0400
Date:   Mon, 6 Aug 2018 12:26:48 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Subject: [PATCH] MIPS: Remove obsolete MIPS checks for DST node "chosen@0"
Message-ID: <alpine.LFD.2.21.1808061223350.24138@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
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


As there is precious little left in any DTS files referring to the
node "/chosen@0" as opposed to "/chosen", remove the two checks for
the former node name.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  if this patch is applied, there are only a couple more lines that
would need to be deleted to totally remove all refs to "chosen@0". at
the moment, i see no MIPS DTS files that refer to that node name.

diff --git a/arch/mips/generic/yamon-dt.c b/arch/mips/generic/yamon-dt.c
index b408dac722ac..7ba4ad5cc1d6 100644
--- a/arch/mips/generic/yamon-dt.c
+++ b/arch/mips/generic/yamon-dt.c
@@ -27,8 +27,6 @@ __init int yamon_dt_append_cmdline(void *fdt)

 	/* find or add chosen node */
 	chosen_off = fdt_path_offset(fdt, "/chosen");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_path_offset(fdt, "/chosen@0");
 	if (chosen_off == -FDT_ERR_NOTFOUND)
 		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
 	if (chosen_off < 0) {
@@ -220,8 +218,6 @@ __init int yamon_dt_serial_config(void *fdt)

 	/* find or add chosen node */
 	chosen_off = fdt_path_offset(fdt, "/chosen");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_path_offset(fdt, "/chosen@0");
 	if (chosen_off == -FDT_ERR_NOTFOUND)
 		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
 	if (chosen_off < 0) {

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
