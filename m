Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 01:07:28 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.200]:44304 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133528AbWAZBHK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 01:07:10 +0000
Received: by uproxy.gmail.com with SMTP id m3so57106uge
        for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 17:11:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=dv6RGeVsUOuJAWQgAnpd6Ks0qpkblHwbQLulaSgcIhEfFcXnJ+UxYuhMq/vLeOWUXvn9m7+r+JFOqnV7cgK8nHX80Oz7vR1G9JnV4Eh0cQX/RR6HmjCgdtajALya0PkFA+6Gsao5OIUz/GcnqZvVhHqcJ5ueThwJ4v50wBaM2og=
Received: by 10.67.23.20 with SMTP id a20mr579026ugj;
        Wed, 25 Jan 2006 17:11:37 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id m1sm607980uge.2006.01.25.17.11.36;
        Wed, 25 Jan 2006 17:11:37 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Thu, 26 Jan 2006 04:29:28 +0300 (MSK)
Date:	Thu, 26 Jan 2006 04:29:25 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Andrew Morton <akpm@osdl.org>
Cc:	linux-kernel@vger.kernle.org, linux-mips@linux-mips.org
Subject: [PATCH] mips: gdb-stub.c: fix parse error before ; token
Message-ID: <20060126012925.GB11091@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/kernel/gdb-stub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/gdb-stub.c
+++ b/arch/mips/kernel/gdb-stub.c
@@ -178,7 +178,7 @@ int kgdb_enabled;
  */
 static DEFINE_SPINLOCK(kgdb_lock);
 static raw_spinlock_t kgdb_cpulock[NR_CPUS] = {
-	[0 ... NR_CPUS-1] = __RAW_SPIN_LOCK_UNLOCKED;
+	[0 ... NR_CPUS-1] = __RAW_SPIN_LOCK_UNLOCKED,
 };
 
 /*
