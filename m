Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 18:59:38 +0200 (CEST)
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.15]:25053
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492702AbZJUQ7d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 18:59:33 +0200
Received: from mail156-va3-R.bigfish.com (10.7.14.243) by
 VA3EHSOBE005.bigfish.com (10.7.40.25) with Microsoft SMTP Server id
 8.1.340.0; Wed, 21 Oct 2009 16:59:22 +0000
Received: from mail156-va3 (localhost.localdomain [127.0.0.1])	by
 mail156-va3-R.bigfish.com (Postfix) with ESMTP id 617621C84DC;	Wed, 21 Oct
 2009 16:59:22 +0000 (UTC)
X-SpamScore: -26
X-BigFish: VPS-26(zz1432R98dN936eM62a3L103dKzz1202hzz5a6ciz32i6bh62h)
Received: by mail156-va3 (MessageSwitch) id 1256144356615119_31615; Wed, 21
 Oct 2009 16:59:16 +0000 (UCT)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.248])	by
 mail156-va3.bigfish.com (Postfix) with ESMTP id 77926BA8051;	Wed, 21 Oct 2009
 16:59:16 +0000 (UTC)
Received: from ausb3extmailp02.amd.com (163.181.251.22) by
 VA3EHSMHS036.bigfish.com (10.7.99.46) with Microsoft SMTP Server (TLS) id
 14.0.482.32; Wed, 21 Oct 2009 16:59:13 +0000
Received: from ausb3twp01.amd.com (ausb3twp01.amd.com [163.181.250.37])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 n9LGx8LV011291;	Wed, 21 Oct 2009 11:59:12 -0500
X-WSS-ID: 0KRVJ6K-01-VP5-02
X-M-MSG: 
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.7.0) with ESMTP id 2E76AD1017A;
	Wed, 21 Oct 2009 11:59:07 -0500 (CDT)
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 21 Oct 2009 11:59:11 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 21 Oct 2009 11:59:10 -0500
Received: from seurexmb1.amd.com ([165.204.9.130]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 21 Oct 2009 18:59:09 +0200
Received: from gwo.osrc.amd.com ([165.204.16.204]) by seurexmb1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 21 Oct 2009 18:59:08 +0200
Received: from erda.amd.com (erda.osrc.amd.com [165.204.15.17])	by
 gwo.osrc.amd.com (Postfix) with ESMTP id 3C9DE49C131;	Wed, 21 Oct 2009
 17:59:08 +0100 (BST)
Received: by erda.amd.com (Postfix, from userid 35569)	id 0762E8003; Wed, 21
 Oct 2009 18:59:07 +0200 (CEST)
Date:	Wed, 21 Oct 2009 18:59:07 +0200
From:	Robert Richter <robert.richter@amd.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	John Levon <levon@movementarian.org>,
	oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] oprofile/loongson2: rename cpu_type from godson2 to
 loongson2
Message-ID: <20091021165907.GJ11972@erda.amd.com>
References: <1256136706-27810-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1256136706-27810-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 21 Oct 2009 16:59:08.0538 (UTC) FILETIME=[CE0E6DA0:01CA526F]
X-Reverse-DNS: ausb3extmailp02.amd.com
Return-Path: <robert.richter@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips

On 21.10.09 22:51:46, Wu Zhangjin wrote:
> This patch try to unify the naming method between kernel and the
> user-space oprofile tool. 'Cause loongson is used instead of godson in
> most of the places, and just confer with the developer of the user-space
> tool, we are agreed to use loongson instead, which will help a lot to
> the future maintaining.
> 
> (This patch is very important to help the user-space support upstream,
>  so, Ralf, could you please merge it into your -queue branch, thanks!)
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Acked-by: Robert Richter <robert.richter@amd.com>

Ralf, please apply to your tree.

Thanks.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
