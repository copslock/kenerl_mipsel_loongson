Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:16:30 +0100 (BST)
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:50793 "EHLO
	imf24aec.mail.bellsouth.net") by ftp.linux-mips.org with ESMTP
	id S20041098AbWHHMQY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:16:24 +0100
Received: from ibm68aec.bellsouth.net ([74.236.202.48])
          by imf24aec.mail.bellsouth.net with ESMTP
          id <20060808121538.GCJC25563.imf24aec.mail.bellsouth.net@ibm68aec.bellsouth.net>
          for <linux-mips@linux-mips.org>; Tue, 8 Aug 2006 08:15:38 -0400
Received: from [192.168.1.96] (really [74.236.202.48])
          by ibm68aec.bellsouth.net with ESMTP
          id <20060808121538.ZCZE1187.ibm68aec.bellsouth.net@[192.168.1.96]>
          for <linux-mips@linux-mips.org>; Tue, 8 Aug 2006 08:15:38 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <9C151BA9-326D-4B57-81AA-4A8CEEF45945@willmert.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To:	linux-mips@linux-mips.org
From:	craigslist <craigslist@willmert.com>
Subject: FB Driver for DbAu1100
Date:	Tue, 8 Aug 2006 08:15:20 -0400
X-Mailer: Apple Mail (2.752.2)
Return-Path: <craigslist@willmert.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: craigslist@willmert.com
Precedence: bulk
X-list: linux-mips

Has anyone done any work on the framebuffer driver for the DbAu1100  
board? I'm on 2.6.10 and it appears that the code was written for a  
2.4 kernel and never updated, therefore, it does not compile. Some  
data structures were apparently removed that were being used by the  
au1100 fb driver.

Thanks

Stefan Willmert
