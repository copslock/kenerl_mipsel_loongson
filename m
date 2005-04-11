Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 20:47:31 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:37163 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8226134AbVDKTrP>; Mon, 11 Apr 2005 20:47:15 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 11 Apr 2005 15:42:51 -0400
Message-ID: <425AD440.5050600@timesys.com>
Date:	Mon, 11 Apr 2005 15:47:12 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com>
In-Reply-To: <4256B524.2080509@timesys.com>
Content-Type: multipart/mixed;
 boundary="------------040309050204000803030403"
X-OriginalArrivalTime: 11 Apr 2005 19:42:51.0250 (UTC) FILETIME=[A59AD520:01C53ECE]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040309050204000803030403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch appears to fix my machine check problem on the 4kc. The 4kc 
shouldn't need an ssnop here, but this appears to fix it.

Greg Weeks

--------------040309050204000803030403
Content-Type: text/x-patch;
 name="mips.4kc.tlb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips.4kc.tlb.patch"

--- mips-malta4kcle-basic/arch/mips/mm/tlbex.c-orig
+++ mips-malta4kcle-basic/arch/mips/mm/tlbex.c
@@ -847,7 +847,6 @@
 
 	case CPU_R10000:
 	case CPU_R12000:
-	case CPU_4KC:
 	case CPU_SB1:
 	case CPU_4KSC:
 	case CPU_20KC:
@@ -874,6 +873,7 @@
 		tlbw(p);
 		break;
 
+	case CPU_4KC:
 	case CPU_4KEC:
 	case CPU_24K:
 		i_ehb(p);

--------------040309050204000803030403--
