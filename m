Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2008 21:59:55 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:17457 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28790551AbYF3U7t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jun 2008 21:59:49 +0100
X-IronPort-AV: E=Sophos;i="4.27,728,1204531200"; 
   d="scan'208";a="61578812"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-2.cisco.com with ESMTP; 30 Jun 2008 13:59:30 -0700
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m5UKxTXM008897
	for <linux-mips@linux-mips.org>; Mon, 30 Jun 2008 13:59:29 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m5UKxTpO014403
	for <linux-mips@linux-mips.org>; Mon, 30 Jun 2008 20:59:29 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 16:59:27 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 16:59:25 -0400
Received: from SAUSCUPEXCH01.corp.sa.net ([64.101.22.160]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 16:59:24 -0400
Received: from [127.0.0.1] ([64.101.20.200]) by SAUSCUPEXCH01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 13:59:23 -0700
Message-ID: <48694927.90906@cisco.com>
Date:	Mon, 30 Jun 2008 13:59:19 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, dan@codesourcery.com,
	rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
In-Reply-To: <87y74pxwyl.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2008 20:59:23.0885 (UTC) FILETIME=[2CD151D0:01C8DAF4]
X-ST-MF-Message-Resent:	6/30/2008 16:59
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1931; t=1214859569; x=1215723569;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20RFC=3A=20Adding=20non-PIC=20executable=
	20support=20to=20MIPS
	|Sender:=20;
	bh=d46fpFyQnkLvWhMuSyP2GJn34oMmpFnBKSSB07c8amQ=;
	b=a/WTrXH6h8DTPEdZh0YIKnJ4Eh9KXJmDJOPfIL0UGSHWlbXDt4uIZSrGJ9
	06F+o23Qm/XclKXdwKGrV9AMjLTClDTmA9qWJJ5cIQUhxMKCWWE6qYHbzg2O
	eO8oYW7BLN;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> [Sorry for the 3-way crosspost!]
> 
> One of the big holes in the MIPS ABI has always been the lack of support
> for non-PIC executables.
...

> I'll describe my implementation
> below, then compare it to what I understand CS's version to be.
> CS folks: please correct me if I'm wrong.

This sounds like really good stuff and, on first reading, it all seems to make 
sense to me. My only real concern is documentation of these changes. The MIPS ABI 
(http://math-atlas.sourceforge.net/devel/assembly/mipsabi32.pdf) is currently 
moribund. The document that describes it hasn't been updated in since 1996 and 
gcc is not fully conformant (see, for example, the assumptions required for 
correct stack backtracing). It would take significant work to resurrect this but 
it certainly would be helpful to have a current document that completely 
describes the MIPS ABI, or at least the current ELF format, as currently 
implemented on Linux, especially if it is to be extended. The logical home for 
something like this would probably be the Linux Standard Base project hosted by 
the Linux Foundation.

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
