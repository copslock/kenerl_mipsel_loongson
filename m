Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 10:39:04 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:12699 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133435AbWGGJiz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 10:38:55 +0100
Received: from lagash (88-106-172-167.dynamic.dsl.as9105.com [88.106.172.167])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id BDC2845769; Fri,  7 Jul 2006 11:38:54 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FymnU-0005CR-0x; Fri, 07 Jul 2006 10:38:52 +0100
Date:	Fri, 7 Jul 2006 10:38:51 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix build failure in op_model_mipsxx.c
Message-ID: <20060707093851.GC4274@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

this fixes a build warning which gets handled as -Werror.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>


diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index a09c5f9..a175d67 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -49,6 +49,7 @@ static inline unsigned int r_c0_ ## r ##
 	default:							\
 		BUG();							\
 	}								\
+	return 0;							\
 }									\
 									\
 static inline void w_c0_ ## r ## n(unsigned int value)			\
@@ -65,6 +66,7 @@ static inline void w_c0_ ## r ## n(unsig
 	default:							\
 		BUG();							\
 	}								\
+	return;								\
 }									\
 
 __define_perf_accessors(perfcntr, 0, 2)
