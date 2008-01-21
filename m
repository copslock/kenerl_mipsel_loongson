Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jan 2008 18:09:59 +0000 (GMT)
Received: from zcars04e.nortel.com ([47.129.242.56]:47251 "EHLO
	zcars04e.nortel.com") by ftp.linux-mips.org with ESMTP
	id S28580006AbYAUSJv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Jan 2008 18:09:51 +0000
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id m0LI5vS10502
	for <linux-mips@linux-mips.org>; Mon, 21 Jan 2008 18:05:57 GMT
Received: from [47.130.27.231] ([47.130.27.231] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 21 Jan 2008 13:09:41 -0500
Message-ID: <4794DFE1.5040805@nortel.com>
Date:	Mon, 21 Jan 2008 12:09:37 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: quick question on 64-bit values with 32-bit inline assembly
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2008 18:09:41.0515 (UTC) FILETIME=[CB2535B0:01C85C58]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

Hi all,

We're running a 64-bit kernel and 32-bit userspace.  We've got some code 
that is trying to get a 64-bit timestamp in userspace.

The following code seems to work fine in the kernel but in userspace it 
appears to be swapping the two words in the result.

gethrtime(void)
{
    unsigned long long result;

    asm volatile ("rdhwr %0,$31" : "=r" (result));
    return result;
}

Do I need to do something special because userspace is 32-bit?  If so, 
can someone point me to a reference?

Thanks,

Chris Friesen
