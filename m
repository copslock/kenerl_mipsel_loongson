Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 05:31:03 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:46391
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990476AbdKQEa5NuReO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 05:30:57 +0100
Received: by mail-pg0-x242.google.com with SMTP id z184so1034093pgd.13
        for <linux-mips@linux-mips.org>; Thu, 16 Nov 2017 20:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=knWGb7v5cZX6e2s/N6Z8ILpWA5fZwEqNB5wXTDRykdk=;
        b=dlnQWRt0rTsRCrd/gbIcSsoMcCveWtfnLZ0I5yMSwZuJUvXtOSLuzq8/3UhSXsfreO
         Rac+Rw3SWwbI7klcedvhshdEmDhfbKhK+W5xdhv5NL4ZM6aP/HNgyx9R2PoIiDJhLy30
         P2THtSbm+6ONOOYkg0DHbs6GqXQYOyXC/B/tbfsM58OoHs0HDntPtl5iqrG8I2WMOFnN
         mefSZ0zbaVwKqIwhdRKLINwkRmtUKYF3zM8Wb38y9m6+CNhTZm+ZGJcUMftCgFh4At4a
         glG3YbVWuevQqofSxy6OAWCUW9SBWPGxe3huWVsbVpCRQvej3rLFSX0dxIoL5/gj7dow
         /BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=knWGb7v5cZX6e2s/N6Z8ILpWA5fZwEqNB5wXTDRykdk=;
        b=g8vWXeKQ8iltXFEIU81DFoUJHDfk8MYs77XuDSTxSTAlTzwzlHl0JO1R/3YqjvQpBS
         yEFU3cs3k+XjpW3/8U/SqKdLmyW12rEdDrVk6v+xkIBrPlvIVUrmZjpsoltSQlxMdywD
         eZgUT28ye1ZKDEihfz6mC3CfRsCuGXe4BWcbzMZne1lGzxg3Vl0C3Q3nDlfm/3sOoR5k
         GRldQ67/kUpwmxOPB6t6O7XV9lZLVUCtp9pAtJYZecwailG4hAJ9fch3ksFEHxj1KkIa
         k7NYMk/YqOesB1JAdguKcSyjV9iSFVjXCT4QUfynRpRVJbOMWT5e4vstgkFf/++3KwIe
         LfpQ==
X-Gm-Message-State: AJaThX49ODyEDGpxMm+ZtXGMpKdjLjll6OVYbngNlPUQLXAo046Ajz3n
        F2MXlhsei9sBDWDx66YjuUrEjA==
X-Google-Smtp-Source: AGs4zMbyRIlQ8nitge4oIZ4LoHC1FYzZ/OnTiqT8Mdvqi7jWWz0Z6jLk3zvZDcs0aDlWywzTT1OGDg==
X-Received: by 10.159.207.149 with SMTP id z21mr3940379plo.258.1510893051227;
        Thu, 16 Nov 2017 20:30:51 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id a7sm4084984pgc.81.2017.11.16.20.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 20:30:50 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-mips@linux-mips.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V10 4/4] libsas: Align sata_device's rps_resp on a cacheline
Date:   Fri, 17 Nov 2017 12:30:51 +0800
Message-Id: <1510893051-376-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

The rps_resp buffer in ata_device is a DMA target, but it isn't
explicitly cacheline aligned. Due to this, adjacent fields can be
overwritten with stale data from memory on non-coherent architectures.
As a result, the kernel is sometimes unable to communicate with an
SATA device behind a SAS expander.

Fix this by ensuring that the rps_resp buffer is cacheline aligned.

This issue is similar to that fixed by Commit 84bda12af31f93 ("libata:
align ap->sector_buf") and Commit 4ee34ea3a12396f35b26 ("libata: Align
ata_device's id on a cacheline").

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 include/scsi/libsas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 0f9cbf9..6df6fe0 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -159,11 +159,11 @@ struct expander_device {
 
 struct sata_device {
 	unsigned int class;
-	struct smp_resp        rps_resp; /* report_phy_sata_resp */
 	u8     port_no;        /* port number, if this is a PM (Port) */
 
 	struct ata_port *ap;
 	struct ata_host ata_host;
+	struct smp_resp rps_resp ____cacheline_aligned; /* report_phy_sata_resp */
 	u8     fis[ATA_RESP_FIS_SIZE];
 };
 
-- 
2.7.0
