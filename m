Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 09:53:31 +0100 (BST)
Received: from bay1-f21.bay1.hotmail.com ([IPv6:::ffff:65.54.245.21]:63238
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225196AbTEAIx3>; Thu, 1 May 2003 09:53:29 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 1 May 2003 01:53:21 -0700
Received: from 4.3.108.196 by by1fd.bay1.hotmail.msn.com with HTTP;
	Thu, 01 May 2003 08:53:21 GMT
X-Originating-IP: [4.3.108.196]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Thu, 01 May 2003 01:53:21 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F21LXSNq5rwfvh00018d6b@hotmail.com>
X-OriginalArrivalTime: 01 May 2003 08:53:21.0829 (UTC) FILETIME=[1E50D550:01C30FBF]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I got passed the config issue, Thanks to all & Greg.

Now when I try making "make ARCH=mips", I get a lot of errors:

/usr/src/linux-2.4.20-6/include/linux/mm.h:188: parse error before 
`pte_addr_t'
/usr/src/linux-2.4.20-6/include/linux/mm.h:188: warning: no semicolon at end 
of
struct or union
/usr/src/linux-2.4.20-6/include/linux/mm.h:188: warning: no semicolon at end 
of
struct or union
/usr/src/linux-2.4.20-6/include/linux/mm.h:189: warning: type defaults to 
`int'
in declaration of `pte'
/usr/src/linux-2.4.20-6/include/linux/mm.h:189: warning: data definition has 
no
type or storage class
/usr/src/linux-2.4.20-6/include/linux/mm.h:208: parse error before `}'


I get more error like the ones above.

Please let me know the reason for the same.

Thanks,
-Mike.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
