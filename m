Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 01:48:54 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:41089 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133793AbVLFBse (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2005 01:48:34 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 05 Dec 2005 17:48:11 -0800
  id 00098009.4394EDDB.00005B6D
Message-ID: <4394EDC8.9080301@jg555.com>
Date:	Mon, 05 Dec 2005 17:47:52 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Scott Ashcroft <scott.ashcroft@talk21.com>
CC:	linux-mips@linux-mips.org
Subject: Re: pci_iomap issues?
References: <20051206002312.60357.qmail@web86303.mail.ukl.yahoo.com>
In-Reply-To: <20051206002312.60357.qmail@web86303.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

How many machines are affected by multiple pci busses. I can only thing 
of the Origin systems. Couldn't we get a base iomap.c in and add one's 
specific to the multiple bus machines?

-- 
----
Jim Gifford
maillist@jg555.com
