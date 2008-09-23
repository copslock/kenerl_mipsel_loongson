Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 20:01:03 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:43901 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28655783AbYIWSte (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Sep 2008 19:49:34 +0100
X-IronPort-AV: E=Sophos;i="4.33,294,1220227200"; 
   d="scan'208";a="81553452"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-1.cisco.com with ESMTP; 23 Sep 2008 18:49:21 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m8NInL6C015635
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 11:49:21 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m8NInLdR028818
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 18:49:21 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Sep 2008 14:49:20 -0400
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Sep 2008 14:49:19 -0400
Received: from [127.0.0.1] ([64.101.20.200]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Sep 2008 14:49:18 -0400
Message-ID: <48D93A23.3020302@cisco.com>
Date:	Tue, 23 Sep 2008 11:49:07 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Patch 0/6] MIPS: Hardware watch register support for gdb (version
 5).
References: <48D89470.5090404@avtrex.com>
In-Reply-To: <48D89470.5090404@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2008 18:49:18.0956 (UTC) FILETIME=[15D46AC0:01C91DAD]
X-ST-MF-Message-Resent:	9/23/2008 14:49
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1403; t=1222195761; x=1223059761;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Patch=200/6]=20MIPS=3A=20Hardware=20wat
	ch=20register=20support=20for=20gdb=20(version=0A=205).
	|Sender:=20;
	bh=NxxbECB6X5rdfcRm5hjOUCBRmVt6+2XgeONNDWb0j3E=;
	b=nJspz9t82YfcsFzAy5ClwksXrKG4uMCMK9kHfx+I9Xxj6MC/4BKk2ittfh
	p9x+3ULLh3vaVitOYD/OzeXGllGpxli0KF3wS438yr8VHUt5ntooARVm8Y/b
	X3KuIiLNQT;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:

> To follow is my fifth pass at MIPS watch register support.

I'd like to add a feature request, understanding fully that the response may very 
well be, "interesting idea, now show us a patch"--can we have an interface that 
would allow kernel-space allocation of watchpoint registers?

The rationale is that we have found it quite useful to have kernel and driver 
code set watchpoints for debugging purposes. I would not expect that kernel space 
code could grab watchpoint registers already in use by ptrace, and that ptrace 
would be free to allocate all watchpoint registers not in use for kernel space 
purposes, i.e. there would be no watchpoint registers permanently allocated for 
kernel space usage.




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
