Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 13:04:09 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:34130
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdBNMDjTy78R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 13:03:39 +0100
Received: by mail-wr0-x241.google.com with SMTP id c4so1832325wrd.1;
        Tue, 14 Feb 2017 04:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YA4eWvAb8bc9yZ+q2W5912S6qIDQDAok3tIeSEIjDKM=;
        b=I5Kkq5d/mw3cvTLZsuUYrVeWd2MNVTNhPl45qfDO/WOh7Dpolt1EiZmqSbiAp8r+nh
         QGwo9uSHqZp5iH8Si4amRO5TBzWYFrsokkCLE9xA276zCZq/AJ+D4CXHFe8K4QFCe/cV
         7lVF2pBdvtGnIS1LMvvhbFH3xHLdamSeG7Mo5lAs+b5xbNpMxq68UCBPid7ItQyh0cvS
         1tJ1easreaZ9bRz6/Up0/SBejZf+x+HSah2Q9iHUw2Xoz4JjuHInfS44fNK2odsIy6PB
         STs/2DcomBnALKqUskN+k7ORSG7jxxNrXIxRPLdyco1o7OJNGHJzfCoDQCEqEV6rx10w
         Ylkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YA4eWvAb8bc9yZ+q2W5912S6qIDQDAok3tIeSEIjDKM=;
        b=KT5yI8hyWTUO2RL8d1o0r7kFZSOrsBfjAwAFryif06Tly2OVqWOMoUrkC8rEnOrqoJ
         ZhMXAuNdUWJOPAbRaf177g3/QfZ3KVjKnMLvwhejXcgfh/AAqfBCfd8oWUYqRc07PyMV
         HIUguRa7UN9JDiobNaArx0nlklFRCLNbgqL81Nzfy6EikRRdoYQSFuhbXyxL0uEWMYnU
         KQOlFTBR+GY58O/EQO4zZoJf3fokeH8p/M6d2RfZMnkVU4qniNrYaCr+nuLj83AD5BsV
         +d48uUcBFKkYGXq2pwJc8TSo32sFYPmgXUXxCH2dLjBvkHqPsHqjRNc+yH6L6JGcjEtd
         Nt7g==
X-Gm-Message-State: AMke39k6UQGJEsNnbc9gM0aql6fnbE1b0USiJez+PBY4Qo3AxrieX8CKNrIvf6gu5Gv3Ag==
X-Received: by 10.223.162.153 with SMTP id s25mr26898405wra.149.1487073814078;
        Tue, 14 Feb 2017 04:03:34 -0800 (PST)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_05_020 (p200300C023CC14391746B39401FFCB78.dip0.t-ipconnect.de. [2003:c0:23cc:1439:1746:b394:1ff:cb78])
        by smtp.gmail.com with ESMTPSA id e71sm1030339wma.8.2017.02.14.04.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 04:03:33 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/3] MIPS: Alchemy: add devboard machine type to cpuinfo
Date:   Tue, 14 Feb 2017 13:03:26 +0100
Message-Id: <20170214120328.240326-2-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170214120328.240326-1-manuel.lauss@gmail.com>
References: <20170214120328.240326-1-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

prints the devboard name in cpuinfo "machine" line.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/alchemy/devboards/db1xxx.c b/arch/mips/alchemy/devboards/db1xxx.c
index 2d47f951121a..c9ad28995cd2 100644
--- a/arch/mips/alchemy/devboards/db1xxx.c
+++ b/arch/mips/alchemy/devboards/db1xxx.c
@@ -2,6 +2,7 @@
  * Alchemy DB/PB1xxx board support.
  */
 
+#include <asm/prom.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
 
@@ -97,6 +98,7 @@ arch_initcall(db1xxx_arch_init);
 
 static int __init db1xxx_dev_init(void)
 {
+	mips_set_machine_name(board_type_str());
 	switch (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
 	case BCSR_WHOAMI_DB1000:
 	case BCSR_WHOAMI_DB1500:
-- 
2.11.1
