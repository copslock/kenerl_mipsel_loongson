Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4E1IunC003745
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 18:18:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4E1Iuvp003743
	for linux-mips-outgoing; Mon, 13 May 2002 18:18:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from surfers.oz.agile.tv (fw.oz.agile.tv [210.9.52.165])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4E1InnC003740
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 18:18:51 -0700
Received: from agile.tv (tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.6/8.11.2) with ESMTP id g4E1J0E13875;
	Tue, 14 May 2002 11:19:00 +1000
Message-ID: <3CE06604.2050800@agile.tv>
Date: Tue, 14 May 2002 11:19:00 +1000
From: Liam Davies <liam.davies@agile.tv>
Reply-To: ldavies@agile.tv
Organization: AgileTV Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: deleted /dev/zero
References: <3CE061E0.8000909@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
> 
> I don't know how to re-produce this problem yet.  It seems a little 
> non-deterministic.  I would appreciate any insight into this problem.


The ltp mtest05 test had a bug in which it would remove /dev/zero when
it cleaned up. Have you got an updated ltp suite?

This is the fix that they did in late March to the mtest05 test.

/ltp/ltp/testcases/kernel/mem/mtest05/mmstress.c:246
-    if (strcmp(filename, "NULL") || strcmp(filename, "/dev/zero"))
+    if (strcmp(filename, "NULL") && strcmp(filename, "/dev/zero"))

I suppose that there may be other LTP tests that could have similar
bugs...


Cheers
Liam
