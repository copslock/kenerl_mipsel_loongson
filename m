Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 20:31:59 +0000 (GMT)
Received: from smtp104.rog.mail.re2.yahoo.com ([IPv6:::ffff:206.190.36.82]:27818
	"HELO smtp104.rog.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225260AbULHUbx>; Wed, 8 Dec 2004 20:31:53 +0000
Received: from unknown (HELO ?192.168.1.100?) (charles.eidsness@rogers.com@24.157.59.167 with plain)
  by smtp104.rog.mail.re2.yahoo.com with SMTP; 8 Dec 2004 20:31:41 -0000
Message-ID: <41B764AB.5070201@ieee.org>
Date: Wed, 08 Dec 2004 15:31:39 -0500
From: Charles Eidsness <charles.eidsness@ieee.org>
Reply-To: charles.eidsness@ieee.org
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Au1000 Ethernet Driver using NAPI
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <charles.eidsness@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.eidsness@ieee.org
Precedence: bulk
X-list: linux-mips

Hi All,

I was having a problem running a streaming audio application on my 
Au1000 processor when the Ethernet port was being bombarded with 
packets. All of the interrupt servicing was hogging my precious 
processing power and there was nothing left for my app. There's a new 
method for writing Ethernet drivers called NAPI which resolves this 
issue (somewhat). I converted the au1000's Ethernet driver to use this 
method. If you're interested you can find a patch that applys my changes 
to the most recent kernel here:

http://members.rogers.com/charles.eidsness/linux-au1000_eth.napi.patch

Cheers,
Charles
