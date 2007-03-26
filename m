Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 22:13:12 +0100 (BST)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:61587 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20022759AbXCZVNK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 22:13:10 +0100
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id B141F8D1695;
	Mon, 26 Mar 2007 23:11:53 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	Thiemo Seufer <ths@networkno.de>
Subject: Re: [PATCH] Fix a warning in lib-64/dump_tlb.c
Date:	Mon, 26 Mar 2007 23:09:56 +0200
User-Agent: KMail/1.9.6
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <45FABA5A.5000007@int-evry.fr> <Pine.LNX.4.64N.0703211540520.2628@blysk.ds.pg.gda.pl> <20070321165521.GI2311@networkno.de>
In-Reply-To: <20070321165521.GI2311@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703262309.57577.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

Hello,

Here is the patch taking into account your remarks. Thanks !

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
------
diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
index 8232900..a320944 100644
--- a/arch/mips/lib-64/dump_tlb.c
+++ b/arch/mips/lib-64/dump_tlb.c
@@ -30,6 +30,7 @@ static inline const char *msk2str(unsigned int mask)
        case PM_64M:    return "64Mb";
        case PM_256M:   return "256Mb";
 #endif
+       default:        BUG();
        }
 }
