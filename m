Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 15:33:35 +0100 (BST)
Received: from host73.ipowerweb.com ([IPv6:::ffff:66.235.218.254]:1146 "EHLO
	host73.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8224990AbUIPOda>; Thu, 16 Sep 2004 15:33:30 +0100
Received: from cpanel by host73.ipowerweb.com with local (Exim 3.36 #1)
	id 1C7xI7-00032H-00
	for linux-mips@linux-mips.org; Thu, 16 Sep 2004 07:31:19 -0700
Received: from 61.11.17.87 ( [61.11.17.87])
	as user gautam@koperasw.com@localhost by koperasw.com with HTTP;
	Thu, 16 Sep 2004 07:31:19 -0700
Message-ID: <1095345079.4149a3b74bd1c@koperasw.com>
Date: Thu, 16 Sep 2004 07:31:19 -0700
From: gautam@koperasw.com
To: linux-mips@linux-mips.org
Subject: Problem with yamon (2.06) and TLB on Malta
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 61.11.17.87
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host73.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [32001 32001]
X-AntiAbuse: Sender Address Domain - host73.ipowerweb.com
Return-Path: <cpanel@host73.ipowerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gautam@koperasw.com
Precedence: bulk
X-list: linux-mips

Hi,
I am trying to write the kernel image to flash / IDE using yamon's disk write,
load,cp commands . I have a recurring error message that says "Mapped entry not
found in TLB" (something to that effect,just in case these are not the exact words).
For e.g. I get the error evenn when I do a memory erase at the flash address
sucessfully and later use the same starting address for cp .
Does the TLB need to be edited in any specific way or can I direct these
commands to execute without them needing to refer to the TLB?
I know the answer must be pretty apparent, but have already scoured through
google in vain searching for exact/relevant documentation.(and am pretty
desperate now!)
Thanks,
Gautam 
