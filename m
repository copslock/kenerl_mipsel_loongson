Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 17:22:01 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:42656 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225004AbVAaRVm>; Mon, 31 Jan 2005 17:21:42 +0000
Received: from 204.127.205.142 (unknown[204.127.205.161](misconfigured sender))
          by comcast.net (sccrmhc11) with SMTP
          id <2005013117213201100cnehoe>; Mon, 31 Jan 2005 17:21:33 +0000
Received: from [69.243.71.130] by 204.127.205.142;
	Mon, 31 Jan 2005 17:21:31 +0000
From:	bkalthouse@comcast.net
To:	thomas.petazzoni@enix.org; mlachwani@mvista.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Running RM9000 in SMP mode
Date:	Mon, 31 Jan 2005 17:21:31 +0000
Message-Id: <013120051721.5237.41FE691900066C640000147522058844840A9C9A01089B040E050D@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender:	YmthbHRob3VzZUBjb21jYXN0Lm5ldA==
Return-Path: <bkalthouse@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkalthouse@comcast.net
Precedence: bulk
X-list: linux-mips

Hi,

I am starting a project using a PMC Sierra  RM9222 processor.  Could anyone that has used the RM9200 family please recommend a distribution and tool-chain?  What has been your experience with Linux on this processor?  What secrets and limitations have you found along the way?  I am new to MIPS and SMP.

Thanks,
Bryan Althouse



Hello,


Has anyone tried to use the RM9000 processor in SMP mode ? Is code
available for it ?


Thanks,

Thomas



Hello Thomas

The Rm9000x2 revision 1.1 and 1.0 does not have support for the five state MOESI protocol and can only support SMP if appropriate hacks are applied to the memory management code. The revision 1.2 of the chip does support MOESI protocol and SMP. I am sure PMC can provide you with the necessary sources. Which board are you using?


Thanks
Manish Lachwani
