Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2008 18:52:11 +0100 (BST)
Received: from zcars04f.nortel.com ([47.129.242.57]:53899 "EHLO
	zcars04f.nortel.com") by ftp.linux-mips.org with ESMTP
	id S28574084AbYEZRwJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 May 2008 18:52:09 +0100
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zcars04f.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id m4QHq0009427
	for <linux-mips@linux-mips.org>; Mon, 26 May 2008 17:52:00 GMT
Received: from [47.130.82.222] ([47.130.82.222] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 26 May 2008 13:52:00 -0400
Message-ID: <483AF8BC.7020603@nortel.com>
Date:	Mon, 26 May 2008 11:51:56 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: problems with dlsym() on MIPS, looking for advice
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 May 2008 17:52:00.0464 (UTC) FILETIME=[32C22D00:01C8BF59]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

I think this is a userspace/toolchain issue, so if that's offtopic for 
this list please let me know of a better resource.

We're using glibc 2.3.6 and gcc 3.4.4.  We've got some library code 
(that gets preloaded for debugging) something like this:

ee_sigaction_fptr = dlsym(RTLD_DEFAULT, "sigaction"); 
   if (ee_sigaction_fptr == sigaction) 
      	ee_sigaction_fptr = dlsym(RTLD_NEXT, "sigaction");

We have declared our own sigaction procedure which is extern in this 
code.  On non-MIPS arches (powerpc, x86, x86_64) the RTLD_DEFAULT call 
returns the address of our external procedure and the RTLD_NEXT call 
returns the real sigaction address in its appropriate library.

On MIPS, the DEFAULT returns the address of this libraries undefined 
symbol for the extern and NEXT returns our external procedure.  Putting 
in a second RTLD_NEXT call returned the real sigaction address.

This worked for most procedures we are looking for. However, during 
booting, we have an app that uses a specific library which has an extern 
for sigaction as well and now in the preloaded code we need a fourth 
call to dlsym to skip that one.

We tried recoding the above debug code to do one DEFAULT call and a loop 
of NEXT calls until it returns NULL.  It didn't.  It just kept returning 
the last pointer all the time. 


Has anyone seen anything like this?  Is there a known issue with dlsym() 
and certain toolchains?  (Maybe something like 
"http://busybox.net/lists/uclibc/2007-January/017150.html"?)


Any help you can provide would be appreciated.

Thanks,

Chris
