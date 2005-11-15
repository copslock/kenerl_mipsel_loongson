Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 15:18:00 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:38100 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133540AbVKOPRn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Nov 2005 15:17:43 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 15 Nov 2005 07:19:39 -0800
  id 0028C449.4379FC8B.000024D6
Message-ID: <4379FBF4.1040505@jg555.com>
Date:	Tue, 15 Nov 2005 07:17:08 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl> <4371B87A.9040101@jg555.com> <4371FB46.1000805@gentoo.org> <4372304A.9080608@jg555.com>
In-Reply-To: <4372304A.9080608@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I've isolated the problem to 2.6.13-rc3. What I've done is built every 
kernel from 2.6.13-rc1 till it failed.

Also, Ralf, when I tried using git to pull those out of the git repo, 
they were missing files, had to use the cvs, not sure if you can verify 
it. I tried 2.6.13-rc1 and 2.6.13-rc2.

-- 
----
Jim Gifford
maillist@jg555.com
