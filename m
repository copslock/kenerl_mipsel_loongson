Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2009 17:07:46 +0000 (GMT)
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.15]:33497
	"EHLO VA3EHSOBE006.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20808688AbZBZRHo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Feb 2009 17:07:44 +0000
Received: from mail161-va3-R.bigfish.com (10.7.14.250) by
 VA3EHSOBE006.bigfish.com (10.7.40.26) with Microsoft SMTP Server id
 8.1.340.0; Thu, 26 Feb 2009 17:07:38 +0000
Received: from mail161-va3 (localhost.localdomain [127.0.0.1])	by
 mail161-va3-R.bigfish.com (Postfix) with ESMTP id CC40F81811A;	Thu, 26 Feb
 2009 17:07:37 +0000 (UTC)
X-BigFish: VPS-37(zz1432R62a3L98dR936eQ1805Mzzzzz32i6bh61h)
Received: by mail161-va3 (MessageSwitch) id 1235668056256418_29636; Thu, 26
 Feb 2009 17:07:36 +0000 (UCT)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail161-va3.bigfish.com (Postfix) with
 ESMTP id 21C01DC006A;	Thu, 26 Feb 2009 17:07:36 +0000 (UTC)
Received: from ausb3twp01.amd.com (ausb3twp01.amd.com [163.181.250.37])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 n1QH7TaF015392;	Thu, 26 Feb 2009 11:07:33 -0600
X-WSS-ID: 0KFONK9-01-9J7-01
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2C039194502;
	Thu, 26 Feb 2009 11:07:20 -0600 (CST)
Received: from sausexmb1.amd.com ([163.181.3.156]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 26 Feb 2009 11:07:28 -0600
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by sausexmb1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 26 Feb 2009 11:07:28 -0600
Received: from seurexmb1.amd.com ([165.204.82.130]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 26 Feb 2009 18:07:26 +0100
Received: from erda.amd.com ([165.204.85.17]) by seurexmb1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 26 Feb 2009 18:07:26 +0100
Received: by erda.amd.com (Postfix, from userid 35569)	id 066347FF9; Thu, 26
 Feb 2009 18:07:26 +0100 (CET)
Date:	Thu, 26 Feb 2009 18:07:25 +0100
From:	Robert Richter <robert.richter@amd.com>
To:	"M. Asselstine" <Mark.Asselstine@windriver.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	oprofile-list@lists.sf.net
Subject: Re: [PATCH] oprofile: VR5500 performance counter driver
Message-ID: <20090226170725.GM25042@erda.amd.com>
References: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com> <20090225165953.GF25042@erda.amd.com> <200902261130.48307.Mark.Asselstine@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <200902261130.48307.Mark.Asselstine@windriver.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 26 Feb 2009 17:07:26.0124 (UTC) FILETIME=[B2BD46C0:01C99834]
Return-Path: <robert.richter@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips

Thanks Mark.

On 26.02.09 11:30:48, M. Asselstine wrote:
> > > +	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))
> >
> > Do not use magic numbers.
> >
> 
> A comment will be added or a well named define.

I found this:

 arch/mips/include/asm/mipsregs.h:#define  CAUSEB_CE		28

Not sure if this is the same register. If so, you could add the macro
to mipsregs.h too.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
