Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2005 14:56:02 +0000 (GMT)
Received: from balu1.urz.unibas.ch ([IPv6:::ffff:131.152.1.51]:50133 "EHLO
	balu1.urz.unibas.ch") by linux-mips.org with ESMTP
	id <S8225773AbVCCOzq>; Thu, 3 Mar 2005 14:55:46 +0000
Received: from [192.168.1.102] (banana.cs.unibas.ch [131.152.55.9])
	by balu1.urz.unibas.ch (8.12.10/8.12.10) with ESMTP id j23EtiTL012084
	for <linux-mips@linux-mips.org>; Thu, 3 Mar 2005 15:55:44 +0100
Message-ID: <42272589.7000802@unibas.ch>
Date:	Thu, 03 Mar 2005 15:56:09 +0100
From:	Christophe Jelger <Christophe.Jelger@unibas.ch>
Organization: University of Basel
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Newbie : Cross-compiling module for wrt54g
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SMTP-Vilter-Version: 1.1.8
X-SMTP-Vilter-Virus-Backend: savse
X-SMTP-Vilter-Status: clean
X-SMTP-Vilter-savse-Virus-Status: clean
X-SMTP-Vilter-Unwanted-Backend:	attachment
X-SMTP-Vilter-attachment-Unwanted-Status: clean
Return-Path: <Christophe.Jelger@unibas.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Christophe.Jelger@unibas.ch
Precedence: bulk
X-list: linux-mips

Hi everybody,

Well I am a complete newbie to using MIPS devices and I would like to 
cross-compile an extra linux module for the Linksys wrt54g wireless 
router. The module is not a standard linux module, it is an underlay 
routing protocol (LUNAR) for wireless ad hoc networks.

I checked on the web, but I'm not sure on how I should proceed as many 
information I found seem outdated.

If somebody could help me to get on tracks, I'd of course appreciate. 
The issues I have are : tools to use, kernel-header files versions 
(wrt54g uses 2.4.20, means do I have to compile on a 2.4.20 machine ?), 
debugging on wrt54g (can I use standard log-file ?).

Looking forward to some help.

regards
Christophe
