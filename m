Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2006 14:02:55 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:41735 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133710AbWCPOCo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Mar 2006 14:02:44 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 63DD664D3D; Thu, 16 Mar 2006 14:11:57 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 257EA66ED5; Thu, 16 Mar 2006 14:11:27 +0000 (GMT)
Date:	Thu, 16 Mar 2006 14:11:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Sibyte: Fix race in sb1250_gettimeoffset().
Message-ID: <20060316141127.GS25322@deprecation.cyrius.com>
References: <S8133620AbWCPM6I/20060316125808Z+139@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S8133620AbWCPM6I/20060316125808Z+139@ftp.linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* linux-mips@linux-mips.org <linux-mips@linux-mips.org> [2006-03-16 12:57]:
> Commit: 186326fa1e0360450b927ee5b21fb8db028fe7ba
> 
> +void __init swarm_time_init(void)
> +{
> +	/* Setup HPT */
> +	sb1250_hpt_setup();
> +}

This leads to compiler errors on 1480 because sb1250_hpt_setup() is
not defined.  We need something like the patch below (or possibly a
proper fix?):


[MIPS] don't call sb1250_hpt_setup on 1480

sb1250_hpt_setup() should not be called on the 1480 board since it's
note defined there, leading to a linking error.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index b661d24..4a93f1d 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -72,8 +72,10 @@ const char *get_system_type(void)
 
 void __init swarm_time_init(void)
 {
+#if defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	/* Setup HPT */
 	sb1250_hpt_setup();
+#endif
 }
 
 void __init swarm_timer_setup(struct irqaction *irq)

-- 
Martin Michlmayr
http://www.cyrius.com/
