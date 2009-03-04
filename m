Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 21:50:49 +0000 (GMT)
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:40412
	"EHLO VA3EHSOBE001.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S21365705AbZCDVuq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Mar 2009 21:50:46 +0000
Received: from mail211-va3-R.bigfish.com (10.7.14.252) by
 VA3EHSOBE001.bigfish.com (10.7.40.21) with Microsoft SMTP Server id
 8.1.340.0; Wed, 4 Mar 2009 21:50:40 +0000
Received: from mail211-va3 (localhost.localdomain [127.0.0.1])	by
 mail211-va3-R.bigfish.com (Postfix) with ESMTP id 213DA11F81FD;	Wed,  4 Mar
 2009 21:50:40 +0000 (UTC)
X-BigFish: VPS-47(zz1432R62a3L98dR936eQ1805M179dRzzzzz32i6bh61h)
Received: by mail211-va3 (MessageSwitch) id 1236203438642915_25220; Wed,  4
 Mar 2009 21:50:38 +0000 (UCT)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])	(using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate
 requested)	by mail211-va3.bigfish.com (Postfix) with ESMTP id 83A7570057;
	Wed,  4 Mar 2009 21:50:38 +0000 (UTC)
Received: from ausb3twp02.amd.com ([163.181.250.38])	by
 ausb3extmailp01.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 n24LoUFe022070;	Wed, 4 Mar 2009 15:50:33 -0600
X-WSS-ID: 0KG04NW-02-D1A-01
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp02.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 26D0F16A063B;
	Wed,  4 Mar 2009 15:50:20 -0600 (CST)
Received: from sausexmb2.amd.com ([163.181.3.157]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 4 Mar 2009 15:50:32 -0600
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by sausexmb2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 4 Mar 2009 15:50:32 -0600
Received: from seurexmb1.amd.com ([165.204.82.130]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 4 Mar 2009 22:50:30 +0100
Received: from erda.amd.com ([165.204.85.17]) by seurexmb1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 4 Mar 2009 22:50:29 +0100
Received: by erda.amd.com (Postfix, from userid 35569)	id BC97D800E; Wed,  4
 Mar 2009 22:50:29 +0100 (CET)
Date:	Wed, 4 Mar 2009 22:50:29 +0100
From:	Robert Richter <robert.richter@amd.com>
To:	"M. Asselstine" <Mark.Asselstine@windriver.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	oprofile-list@lists.sf.net
Subject: Re: [PATCH V2] oprofile: VR5500 performance counter driver
Message-ID: <20090304215029.GT10085@erda.amd.com>
References: <20090225165953.GF25042@erda.amd.com> <1235681374-19952-1-git-send-email-mark.asselstine@windriver.com> <20090303110755.GD10085@erda.amd.com> <200903041253.03682.Mark.Asselstine@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <200903041253.03682.Mark.Asselstine@windriver.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 04 Mar 2009 21:50:29.0864 (UTC) FILETIME=[3C50D680:01C99D13]
Return-Path: <robert.richter@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips

On 04.03.09 12:53:03, M. Asselstine wrote:
> > the Kconfig option for CONFIG_CPU_R5500 is still missing otherwise the
> > patch itself looks fine.
> >
> 
> Hmmm, what tree are you looking at? I see it in Linus' tree as well as Ralf's 
> .29 RCs and master.

Ahh, sorry. Was accidentally greping for CPU_VR5500. It is already
upstream.

Thanks Mark,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
