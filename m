Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g43LkOwJ031764
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 3 May 2002 14:46:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g43LkOcR031763
	for linux-mips-outgoing; Fri, 3 May 2002 14:46:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g43LkKwJ031756
	for <linux-mips@oss.sgi.com>; Fri, 3 May 2002 14:46:20 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA00949;
	Fri, 3 May 2002 14:48:00 -0700
Message-ID: <3CD3052B.1050400@mvista.com>
Date: Fri, 03 May 2002 14:46:19 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: what is the right behavior of copy_to_user(0x0, ..., ...)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When running LTP, I notice that recent kernel has a kernel access fault:

<1>Unable to handle kernel paging request at virtual address 00000000, epc
== 80273860, ra == 80205aa4
Oops in fault.c:do_page_fault, line 204:
$0 : 00000000 10001f00 00000002 00000002 00000000 86df5e98 00000001 00000040
$8 : 00000000 00000000 00000001 ffffffff 00000002 802b4864 00000001 00000001
$16: 100003d8 00000000 00000002 86df5e98 00401080 10002df8 00000000 00000097
$24: 0000000a 802e7ab6                   86df4000 86df5e60 7fff7c60 80205aa4
Hi : 00000000
Lo : 00000000
epc  : 80273860    Not tainted
Status: 10001f03
Cause : 9080800c
  ....

Tracing error reveals that user process passed a NULL buffer pointer to 
sys_getpeername() syscall, probably intentionally.  Then it goes all the way 
down to copy_to_user(0x0, ..., ...) and caused a oops as above.

As a result of oops the user process is killed.  However I am not sure if this 
is the right way to respond to an ill argument.  copy_to_user() probably 
should catch this case and return some meaningful error back to the caller.

I am not sure what is the best way to achieve this.  Any thoughts?

Jun
