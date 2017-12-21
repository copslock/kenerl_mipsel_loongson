Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 22:01:16 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:36857
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990437AbdLUVBJMRnwn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2017 22:01:09 +0100
Received: by mail-wr0-x244.google.com with SMTP id u19so19864901wrc.3;
        Thu, 21 Dec 2017 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+MdXkdR21+nW7ZBzHc1JhZ6l8CmkE64gt2QSAI9YpWw=;
        b=d90+UEdRjmfMRYbSdt0V13AvlJFDCOtARLgOD9GOr4VUc5XAbJX+XRNLCf+6EbzE8O
         PjLfVlCYkcjtzOzB6OJVPdDoapeZhurHmArn0OO0ZPGrcJV3kOfrJDk8GoUCRLgxdEfh
         ak4ZRZUksHKuXTG89PToSRGwmDs55akXDGnFCeKKO8AK9mKSxwbv4FPzDgDM0KcHbYJF
         EH7FHEBtPFsHhmeVZ+Q4njARmDsk7VRZK1YYhmHBrFkUTC17SjP+B+JPxTQOqrT+6duV
         tmHvInt65LIuUULcjC3VyGVE9T99AtlbVwqbAicodsnqwIjpHY5K/qjvQsbzpiV6XCHu
         JyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+MdXkdR21+nW7ZBzHc1JhZ6l8CmkE64gt2QSAI9YpWw=;
        b=ZwpWq/9glD/qNe0eg731X67cdJaBZQ3rSz9z0OpfqvIA2jG0LkitP7VRxEpG2Nwa2W
         MAnbDMN8TGREB6xsec3TaZDeOp43sDshr1lNnuWXl1eyMwzFZmYcPXVWyrOCWMxLR7hM
         ZH3FN+uTCwg8+fAjNAZTCHf6XaXe9/JK2q4FEetvloUv9ISc4anGV0LTLjnoCwn7vz6v
         kfMtZChwFD0dbQI7ta84SrkTOZ1K7kCagim5eY94eA+8l9DFQOzJvO7REMJPYCe+t96a
         Rxs8PBiD5rIvTRtz/2FUVO/VHUrx9Or1kksQor0CTMLEkZHGkCmKXyLh+pNA+w2rh0Mn
         KQsQ==
X-Gm-Message-State: AKGB3mLO4xwSlRrLG8F8JjsznJ/O5GM0qL+Fw79SRdbuKl/aX/TG8euX
        1JyWFPLvN+L3GUEoBKXi1OQ=
X-Google-Smtp-Source: ACJfBos140vuaAsDz336Mh9Sb3Fv/m/BEy+BZt5HhVnoBXiFHMpVGEPeoXmZbkygR3SAKy+Bnqx6qg==
X-Received: by 10.223.151.205 with SMTP id t13mr11578857wrb.271.1513890063682;
        Thu, 21 Dec 2017 13:01:03 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id m70sm4338264wma.36.2017.12.21.13.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Dec 2017 13:01:03 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CB72C10C0A0E; Thu, 21 Dec 2017 22:01:01 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        "# v4 . 11" <stable@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: fix incorrect mem=X@Y handling
Date:   Thu, 21 Dec 2017 22:00:59 +0100
Message-Id: <20171221210100.12002-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

From: Marcin Nowakowski <marcin.nowakowski@mips.com>

Change 73fbc1eba7ff added a fix to ensure that the memory range between
PHYS_OFFSET and low memory address specified by mem= cmdline argument is
not later processed by free_all_bootmem.
This change was incorrect for systems where the commandline specifies
more than 1 mem argument, as it will cause all memory between
PHYS_OFFSET and each of the memory offsets to be marked as reserved,
which results in parts of the RAM marked as reserved (Creator CI20's
u-boot has a default commandline argument 'mem=256M@0x0
mem=768M@0x30000000').

Change the behaviour to ensure that only the range between PHYS_OFFSET
and the lowest start address of the memories is marked as protected.

This change also ensures that the range is marked protected even if it's
only defined through the devicetree and not only via commandline
arguments.

Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
Cc: <stable@vger.kernel.org> # v4.11
---
v2: Use updated email adress, add tag for stable.
 arch/mips/kernel/setup.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 702c678de116..f19d61224c71 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -375,6 +375,7 @@ static void __init bootmem_init(void)
 	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
+	phys_addr_t ramstart = ~0UL;
 	bool bootmap_valid = false;
 	int i;
 
@@ -395,6 +396,21 @@ static void __init bootmem_init(void)
 	max_low_pfn = 0;
 
 	/*
+	 * Reserve any memory between the start of RAM and PHYS_OFFSET
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		ramstart = min(ramstart, boot_mem_map.map[i].addr);
+	}
+
+	if (ramstart > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
+				  BOOT_MEM_RESERVED);
+
+
+	/*
 	 * Find the highest page frame number we have available.
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
@@ -664,9 +680,6 @@ static int __init early_parse_mem(char *p)
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
 
-	if (start && start > PHYS_OFFSET)
-		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
-				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);
-- 
2.11.0
