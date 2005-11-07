Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 22:21:55 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:26542 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8135586AbVKGWV2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2005 22:21:28 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 07 Nov 2005 14:22:41 -0800
  id 0022907D.436FD3B1.00000139
Message-ID: <436FD396.9080807@jg555.com>
Date:	Mon, 07 Nov 2005 14:22:14 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <436D3DF7.5000002@gentoo.org>
In-Reply-To: <436D3DF7.5000002@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I've talked to a few others, who are having similar issues also Kumba, I 
made a diff of 2.6.12 and 2.6.14, trying to figure out what's causing 
this. Looks like some major rewrites have occured in some areas.

If anyone would like to view the diff I have it on my website, 
http://ftp.jg555.com/mips_diff.txt

-- 
----
Jim Gifford
maillist@jg555.com
