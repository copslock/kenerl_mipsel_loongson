Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 23:47:39 +0200 (CEST)
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36119 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993066AbeFSVrU3KNer (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 23:47:20 +0200
Received: by mail-yb0-f196.google.com with SMTP id x128-v6so483352ybg.3;
        Tue, 19 Jun 2018 14:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LT9TrtiRXCl2nVaT1mJwH3wuwflNX6wnuE0hTLu4Q3Y=;
        b=ueZw3XbLyxoso/9Gm+27IDCW+5Rjpkt1ejosO4jcCPuk2TYzEgIQ9UQI3BD/jA78RS
         r1QO+Cy7dXnTO3V6LyieTOjfoOMvWHLUjZeT4DvqhjIzGAGWEcl9PF9uob7XlbqYNkLb
         34Jlka+dcK6enY5E0sXJad3Qw9jZBbjQKM1r/GD2CMrjgbH2s21zGpp1r1BVv7Y47WC/
         wq5ECabh2LfGa+XA6oNJJ9GqblzyJZb96ehTbbmA/tg/W7pk5Yoty9NuR413SqUXjKkN
         mSga+VQ4h2wiBmrVX8F5Prj27jt2ZD65rdPlrFiZ5Qe0gqiwDCRYc62ic/xPs5pe3EUl
         GYQg==
X-Gm-Message-State: APt69E1J+DnPo4OlZuDDdQgi8VlilngIwIRb9A8myfmz2/EMkVP3SEAg
        47RiSNkETL2VZViFV5a9oszbahA=
X-Google-Smtp-Source: ADUXVKL1K/JDgTy1ecJl2I9TQj2Zcm6uezU6HIHNQ4R7oP1fBUt5mz28PxPUTK7kt88DxVPNfypN/w==
X-Received: by 2002:a25:b10d:: with SMTP id g13-v6mr7125131ybj.169.1529444834496;
        Tue, 19 Jun 2018 14:47:14 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 1/5] MIPS: octeon: use of_platform_populate to probe devices
Date:   Tue, 19 Jun 2018 15:47:06 -0600
Message-Id: <20180619214710.22066-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

of_platform_bus_probe is deprecated in favor of of_platform_populate.
of_platform_populate is stricter requiring compatible properties for
matching rather than name or type. Octeon uses compatible strings for
matching, so convert it to of_platform_populate.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db478904..2940e9cc3a04 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -1067,6 +1067,6 @@ int __init octeon_prune_device_tree(void)
 
 static int __init octeon_publish_devices(void)
 {
-	return of_platform_bus_probe(NULL, octeon_ids, NULL);
+	return of_platform_populate(NULL, octeon_ids, NULL, NULL);
 }
 arch_initcall(octeon_publish_devices);
-- 
2.17.1
