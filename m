Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2008 22:29:19 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:55638 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28792996AbYF3V3O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jun 2008 22:29:14 +0100
X-IronPort-AV: E=Sophos;i="4.27,728,1204531200"; 
   d="scan'208";a="120604026"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-6.cisco.com with ESMTP; 30 Jun 2008 14:29:05 -0700
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m5ULT54i032369
	for <linux-mips@linux-mips.org>; Mon, 30 Jun 2008 14:29:05 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id m5ULT5ir013889
	for <linux-mips@linux-mips.org>; Mon, 30 Jun 2008 21:29:05 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 17:29:04 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 17:29:02 -0400
Received: from [127.0.0.1] ([64.101.20.200]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 17:29:02 -0400
Message-ID: <48695012.4080306@cisco.com>
Date:	Mon, 30 Jun 2008 14:28:50 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>, binutils@sourceware.org,
	gcc@gcc.gnu.org, linux-mips@linux-mips.org,
	rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home> <48694927.90906@cisco.com> <20080630211950.GA30847@caradoc.them.org>
In-Reply-To: <20080630211950.GA30847@caradoc.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2008 21:29:02.0105 (UTC) FILETIME=[50B82890:01C8DAF8]
X-ST-MF-Message-Resent:	6/30/2008 17:29
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1633; t=1214861345; x=1215725345;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20RFC=3A=20Adding=20non-PIC=20executable=
	20support=20to=20MIPS
	|Sender:=20;
	bh=MMLRENXuDm3nVLwyN8zhWRyyhbMUurA2KSi/l/2LCnA=;
	b=oS7lCy4JbNlp1sWE/JN7xBZleRP+tRI/sj+pVe1AkCHrSoThf79emk4Fja
	otkaXkYkoNWbVa3PuH0ncDo8dRMs00WfqRh+9/plB/SwKSCmasAvyySJ49LR
	FkshQRnGgGaUtqRNwYN+fmPjJcdMkApSJepSwEJEeSUyNR5Y8VkD4=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> On Mon, Jun 30, 2008 at 01:59:19PM -0700, David VomLehn wrote:
>> This sounds like really good stuff and, on first reading, it all seems to 
>> make sense to me. My only real concern is documentation of these changes. 
> 
> FWIW, I'll be posting our version of this project shortly, and it
> includes an ABI supplement.  Supplemental to a somewhat hypothetical
> document, but there you go...

Also, FWIW, if there is interest in trying to get an Linux Standard Base working 
group for the MIPS Processor, one of the LSB Steering Committee members used to 
be Chair of the MIPS ABI Group Technical Committee, which wrote the MIPS ABI. 
And, uh, yeah, I'll admit it, I used to chair the TC, too, once upon a time. So, 
we actually still have some people around who at least used to know something 
about it...

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
