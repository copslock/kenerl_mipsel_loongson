Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4E12knC003325
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 18:02:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4E12kd0003324
	for linux-mips-outgoing; Mon, 13 May 2002 18:02:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4E12inC003317
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 18:02:44 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA04326;
	Mon, 13 May 2002 18:02:56 -0700
Message-ID: <3CE061E0.8000909@mvista.com>
Date: Mon, 13 May 2002 18:01:20 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: deleted /dev/zero 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am running some stress tests (such as ltp, netperf, lmbench, etc) on the SMP 
swarm board.  Once in a while I notice /dev/zero will get deleted.  This 
causes all kinds of weired problems (such as internal gcc error.  Why?)

I don't know how to re-produce this problem yet.  It seems a little 
non-deterministic.  I would appreciate any insight into this problem.

Jun
