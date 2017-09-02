Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Sep 2017 21:34:40 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:36134
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991743AbdIBTe2YlzEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Sep 2017 21:34:28 +0200
Received: by mail-oi0-x241.google.com with SMTP id x184so2502611oia.3;
        Sat, 02 Sep 2017 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sG09Y6aDE70FvvrfF9e3iA5powfkQol6aTVIrKSrBgA=;
        b=XMDY3EWc4t/pEthLss2vGTL6wDqzM3WkwwhltozWRrf6GdM74WR/caCrDx/C4Rumrt
         9ayk9vXIGu0IzHY5qBr9rq6yI4oqO+sa1TjHM9FzIkH6AymOTegHBCbIOQ92FdtEkWnp
         PGIst49L9yyn4PgXAFBS/WMJdQhnToJbRsr58JYB5gwhsAhMh5tqVIQxMK6WuhNwKDOD
         4QYkkK1SwD24fBMKnuVNyJecCmA5aVkvifuaZRdi/UcCZ7xSRJ3Z0GS1z965vapXytXj
         uFE91ShbEFpvI9ZZyLz8c81nogJZQKMXHknBUqGb/Cv666doOfOsoCe5REyualQUogeo
         uZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sG09Y6aDE70FvvrfF9e3iA5powfkQol6aTVIrKSrBgA=;
        b=Eet7Bn8f/fsCvr0PemTZTHuzSaKiZcSYJgevWbCbRzp7TaXesZvdCH8sO7U87LFBaY
         oPG+YnF4w3jkAiI7gqKz1nyj8sobeE4bncCbYz5LozH7MlakMMU08jEevqdj+Bb5Njp1
         j/r/fz7ciR/7e2h6l/6myvNWXMsVjyN6JhKgPtqpbZI9CbRJBQYjn66yhSh/zsemKRLq
         EurzJYghu18bDUviow1uiAHJ01j7SyYz7kMOBa389qIYOZ/Dv6t55RQZjFIjP/PSvdpc
         1UP7ccmYbcVY1GyeeA/U7bxlC82qGEVYG1cG0JAifysb5MB/r2aIa3qfy9M9HEHuh69p
         F/UQ==
X-Gm-Message-State: AHPjjUitZIUvyX57MadK5naO5yh3IoWmPt9NIpXXTKdRB1RWk8DI1ngB
        8uz8lftlzQu1DGDvwwI=
X-Google-Smtp-Source: ADKCNb7rzeL8LmbNJXFgEdIOiZMUQcZSyCDjb+K8uzZ/JpKRpqYnEIj2Lnz5i9m0eFmBZJz5p200cA==
X-Received: by 10.202.244.78 with SMTP id s75mr5441491oih.207.1504380862316;
        Sat, 02 Sep 2017 12:34:22 -0700 (PDT)
Received: from bender.lan ([2001:470:d:73f:b0fd:7de5:8e98:d2eb])
        by smtp.gmail.com with ESMTPSA id e184sm4613924oih.35.2017.09.02.12.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Sep 2017 12:34:21 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, james.hogan@imgtec.com, john@phrozen.org,
        david.daney@cavium.com, paul.burton@imgtec.com,
        matt.redfearn@imgtec.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: Add James as MIPS co-maintainer
Date:   Sat,  2 Sep 2017 12:34:18 -0700
Message-Id: <20170902193418.5577-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com>
References: <33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Based on popular vote, designate James as a co-maintainer for the MIPS
architecture.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 317e72c230ca..68204d6bef2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8768,6 +8768,7 @@ S:	Maintained
 F:	drivers/usb/image/microtek.*
 
 MIPS
+M:	James Hogan <james.hogan@imgtec.com>
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-mips@linux-mips.org
 W:	http://www.linux-mips.org/
-- 
2.11.0
