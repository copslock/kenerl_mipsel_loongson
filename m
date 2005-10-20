Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 17:18:49 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:527
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3465718AbVJTQSc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 17:18:32 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 20 Oct 2005 09:18:27 -0700
Message-ID: <4357C352.2060308@avtrex.com>
Date:	Thu, 20 Oct 2005 09:18:26 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Patch: ATI Xilleon port 11/11 default config for xilleon STW
 5X226.
References: <17239.48636.650235.544443@dl2.hq2.avtrex.com> <Pine.LNX.4.62.0510201805240.12888@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0510201805240.12888@numbat.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2005 16:18:27.0160 (UTC) FILETIME=[E6F33580:01C5D591]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Thu, 20 Oct 2005, David Daney wrote:
> 
>>+#
>>+# Graphics support
>>+#
>>+# CONFIG_FB is not set
> 
> 
> Ooh, no frame buffer device? ;-)
> 

Sorry.  At one time I think a frame buffer device may have existed for 
the Xilleon, but I have never built or used it.

I should note that the support I posted to the list does not contain any 
of the media drivers for the Xilleon.  It can decode and display 2 
simultaneous HD MPEG streams and quite a bit of other things as well. 
However the media drivers are only available from ATI under NDA.

The Xilleon is used in products like the Roku Photobridge (with which I 
have no affiliation) which is somewhat hackable:

http://rokulabs.com/products/photobridge/index.php

It is also used in many HD televisions and PVR type products produced by 
  many name brand CE vendors.

David Daney
