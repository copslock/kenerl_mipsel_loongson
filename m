Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2017 02:35:32 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:33006
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdE3AfZNBSQ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2017 02:35:25 +0200
Received: by mail-pf0-x242.google.com with SMTP id f27so14090344pfe.0;
        Mon, 29 May 2017 17:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0UPnb+Q9JHKz3siK/d7krCagnzifot2HLtvVY9EB01I=;
        b=vLSoqEXziShqj7Iy7APNDY4k49bn7TTTK8txNpGuO+54jbsIQaqeUbmdzKEt8pohrU
         IkNiyhwQ29UPF3oxmjo7wtXTcoI6bS6DdeuMM4OYSU85qSjNffM1QgjQQ/xu/OVFojV5
         KD3h2wyVu+WVZ3iF5+1RK048TPE0DQ4AxSc30gV8yk+bRTNJJ59SRdRQ0p4IoceuvwpE
         OtsOBGUUHg2Hg9BMFitJcDe5sdRs3RykirpYH5KOg6A4IjVH30mbde6hmgcz9w/BNzdt
         feKXsUgelMqdPjSaVDeQt4e0UEMHG/J771YAOjdkS25b2pH3P0iAaQt4xiWEqZIrdu9i
         uz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0UPnb+Q9JHKz3siK/d7krCagnzifot2HLtvVY9EB01I=;
        b=UM5+xNTT/uZEeBgVv8cJp5NcBi3SdZzqVsY/8pj+TIQgR+xPCQsjp6yJAF6SrN6y1S
         spbQsu8Ocz0ycTIEtNeFfRhD9FDAUId/Brd/7qtTAOMqdujqvg54/BiNMpC+o9Lc/qoU
         0OEvxttOeYucfHZVO6PAdueBOipoiOMZOoysvtpTtvXom0mOvDIZIAb1RaauY0JeoDI2
         qly0lCslYjcwgmZ3Y2Ej4HAC4TnJdbVUyCKZ90PtYdwlU/ta3EdFpJVTX8pQs/Kt3cjR
         ZjagDPCniE+9Cq51xOog0CtF34fEuSV8oklxlgFalDKEnZj6S4UhVsagQpJST+d3Ge0Z
         qGBg==
X-Gm-Message-State: AODbwcASEBIGSUO0RH3ojeTUEigKYWgE+L9iD7JIaiqFypNp+2Ao3/LX
        lt1o81iTDnK6t+ezk54=
X-Received: by 10.98.34.22 with SMTP id i22mr20944982pfi.103.1496104519216;
        Mon, 29 May 2017 17:35:19 -0700 (PDT)
Received: from vostro (173-228-88-110.dsl.dynamic.fusionbroadband.com. [173.228.88.110])
        by smtp.gmail.com with ESMTPSA id m5sm21424612pgd.28.2017.05.29.17.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 May 2017 17:35:18 -0700 (PDT)
Date:   Mon, 29 May 2017 17:34:35 -0700
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Patrick McHardy <kaber@trash.net>, Florian Westphal <fw@strlen.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] MIPS: Alchemy: Remove reverted CONFIG_NETLINK_MMAP from
 db1xxx_defconfig
Message-ID: <20170530003435.GA2740@vostro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <nikitas.angelinas@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nikitas.angelinas@gmail.com
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

Netlink mmap support and the relevant CONFIG_NETLINK_MMAP option have been
reverted by commit d1b4c689d4130bcfd3532680b64db562300716b6 ("netlink:
remove mmapped netlink support").

Remove the occurrence of CONFIG_NETLINK_MMAP from db1xxx_defconfig.

Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
Cc: Patrick McHardy <kaber@trash.net>
Cc: Florian Westphal <fw@strlen.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>
---
 arch/mips/configs/db1xxx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index f0c8971030c4..0108bb9f1e37 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -77,7 +77,6 @@ CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
 CONFIG_IPV6_PIMSM_V2=y
 CONFIG_BRIDGE=y
-CONFIG_NETLINK_MMAP=y
 CONFIG_NETLINK_DIAG=y
 CONFIG_IRDA=y
 CONFIG_IRLAN=y
-- 
2.11.1
