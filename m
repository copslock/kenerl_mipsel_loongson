Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 16:17:23 +0100 (BST)
Received: from news.ti.com ([IPv6:::ffff:192.94.94.33]:10955 "EHLO
	dragon.ti.com") by linux-mips.org with ESMTP id <S8225238AbTGBPRV>;
	Wed, 2 Jul 2003 16:17:21 +0100
Received: from dlep51.itg.ti.com ([157.170.141.75])
	by dragon.ti.com (8.12.9/8.12.9) with ESMTP id h62FHE1p016123
	for <linux-mips@linux-mips.org>; Wed, 2 Jul 2003 10:17:15 -0500 (CDT)
Received: from dlep98.itg.ti.com (localhost [127.0.0.1])
	by dlep51.itg.ti.com (8.12.9/8.12.9) with ESMTP id h62FHEBO029472
	for <linux-mips@linux-mips.org>; Wed, 2 Jul 2003 10:17:14 -0500 (CDT)
Received: from dlee70.itg.ti.com (dlee70.itg.ti.com [157.170.135.145])
	by dlep98.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA08595
	for <linux-mips@linux-mips.org>; Wed, 2 Jul 2003 10:17:14 -0500 (CDT)
Received: by dlee70.itg.ti.com with Internet Mail Service (5.5.2653.19)
	id <NZW1N230>; Wed, 2 Jul 2003 10:17:13 -0500
Received: from ti.com (cbc0794930.isr.asp.ti.com [137.167.176.14]) by dile70.itg.ti.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id NN6XFQKZ; Wed, 2 Jul 2003 18:16:30 +0300
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: linux-mips@linux-mips.org
Message-ID: <3F02F74F.5050300@ti.com>
Date: Wed, 02 Jul 2003 18:16:31 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: do_ri
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

Hello dearest all,

Can anyone please enlighten me about the do_ri function ? I could not
find any reference to what it does and when it's  called anywhere.

The real reason I'm asking is because I get BUG() somewhere
in that function and I can not figure when it's getting called.

10x.

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 
