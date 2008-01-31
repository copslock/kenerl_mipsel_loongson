Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2008 18:26:00 +0000 (GMT)
Received: from zcars04f.nortel.com ([47.129.242.57]:15810 "EHLO
	zcars04f.nortel.com") by ftp.linux-mips.org with ESMTP
	id S20027062AbYAaSZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 Jan 2008 18:25:52 +0000
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zcars04f.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id m0VIPiP17842
	for <linux-mips@linux-mips.org>; Thu, 31 Jan 2008 18:25:44 GMT
Received: from [47.130.24.28] ([47.130.24.28] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 31 Jan 2008 13:25:13 -0500
Message-ID: <47A21286.3020009@nortel.com>
Date:	Thu, 31 Jan 2008 12:25:10 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: kexec on SMP mips64?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2008 18:25:13.0401 (UTC) FILETIME=[9EB93A90:01C86436]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips


Hi all,

We're starting work on an embedded highly-available product using dual 
Octeon cpus, and I'm looking into the possibility of using kexec/kdump 
as a "flight recorder" to dump fault information to a persistant storage 
location.

I saw the patch adding initial support for kexec, but I was curious 
about the current status.  Is anyone using kexec for mips64 SMP systems? 
  Is it known to be broken?  I'm just trying to get a feel for how much 
work might be involved.

Thanks,

Chris
