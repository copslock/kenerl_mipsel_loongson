Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:53:45 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993981AbdDJQwBZWc4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:52:01 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF9C5B8E;
        Mon, 10 Apr 2017 16:51:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 058/110] MIPS: Add MIPS_CPU_FTLB for Loongson-3A R2
Date:   Mon, 10 Apr 2017 18:42:49 +0200
Message-Id: <20170410164204.475131289@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410164201.247583164@linuxfoundation.org>
References: <20170410164201.247583164@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 033cffeedbd11c140952b98e8639bf652091a17d upstream.

Loongson-3A R2 and newer CPU have FTLB, but Config0.MT is 1, so add
MIPS_CPU_FTLB to the CPU options.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15752/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cpu-probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1824,7 +1824,7 @@ static inline void cpu_probe_loongson(st
 		}
 
 		decode_configs(c);
-		c->options |= MIPS_CPU_TLBINV | MIPS_CPU_LDPTE;
+		c->options |= MIPS_CPU_FTLB | MIPS_CPU_TLBINV | MIPS_CPU_LDPTE;
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		break;
 	default:
