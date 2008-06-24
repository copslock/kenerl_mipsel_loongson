Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 18:45:37 +0100 (BST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:53416 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20041712AbYFXRp3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 18:45:29 +0100
X-IronPort-AV: E=Sophos;i="4.27,697,1204520400"; 
   d="scan'208";a="12070395"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-1.cisco.com with ESMTP; 24 Jun 2008 13:45:21 -0400
Received: from rtp-core-2.cisco.com (rtp-core-2.cisco.com [64.102.124.13])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m5OHjLVK016075
	for <linux-mips@linux-mips.org>; Tue, 24 Jun 2008 13:45:21 -0400
Received: from sausatlsmtp1.sciatl.com ([192.133.217.33])
	by rtp-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m5OHjLWv018513
	for <linux-mips@linux-mips.org>; Tue, 24 Jun 2008 17:45:21 GMT
Received: from default.com ([192.133.217.33]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 13:45:20 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 13:45:19 -0400
Received: from SAUSCUPEXCH01.corp.sa.net ([64.101.22.160]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 13:45:19 -0400
Received: from [127.0.0.1] ([64.101.20.200]) by SAUSCUPEXCH01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 10:45:18 -0700
Message-ID: <486132A3.2000507@cisco.com>
Date:	Tue, 24 Jun 2008 10:45:07 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: function call on MIPS (newbie question)
References: <4860C9FD.60103@ict.tuwien.ac.at>
In-Reply-To: <4860C9FD.60103@ict.tuwien.ac.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jun 2008 17:45:18.0163 (UTC) FILETIME=[10F2AA30:01C8D622]
X-ST-MF-Message-Resent:	6/24/2008 13:45
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2061; t=1214329521; x=1215193521;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20function=20call=20on=20MIPS=20(newbie=2
	0question)
	|Sender:=20
	|To:=20Harald=20Krapfenbauer=20<krapfenbauer@ict.tuwien.ac.
	at>;
	bh=qSISNRgjPFqKC3pDpDMS4LjADo/VtG9cDEvaK6q6OUU=;
	b=peqNlZkBVcTiUtA9lA1Jf+z6pAvsS4jweYL+w7pRCywI5ioSuCe1JlupWp
	K2rKbpDE4jcmeRbyAabXSJC2UtU0PJz2j1jf/JP4XdmsymMopvznw/5agoMi
	EX1zFY3ANw;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Harald Krapfenbauer wrote:
> Hi!
> 
> I'm a newbie to the MIPS architecture and I want to port some program to
> MIPS.
> I must call a function within the .text segment with 2 simple
> parameters. So I figured out the following code
...
> 
> The code is written to the stack, the SP and the PC are then set to the
> beginning of the code on the stack.

Unlike x86 architectures, the MIPS architecture generally does not have hardware 
to synchronize data and instructions caches. When writing code for execution on 
the MIPS processor, you need to be sure that you flush the data cache and 
invalidate the instruction cache before trying to execute the code. On most MIPS 
processors, you can use the SYNCI instruction to do this. Take a look at the 
documentation for this instruction in "MIPS32® Architecture for Programmers 
Volume II: The MIPS32® Instruction Set". It has sample code on how to properly do 
this in an unprivileged application. You can get to this manual, as well as other 
MIPS manuals, at:

      http://www.mips.com/products/product-materials/processor/mips-architecture/

You will need to register for a free account to download this.

You can also use the cacheflush system call to synchronize the data and 
instruction caches.
-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
