Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5ND61H10826
	for linux-mips-outgoing; Sat, 23 Jun 2001 06:06:01 -0700
Received: from web1.lanscape.net (web1.lanscape.net [64.240.156.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5ND60V10821
	for <linux-mips@oss.sgi.com>; Sat, 23 Jun 2001 06:06:00 -0700
Received: from fisch.cyrius.com (localhost [127.0.0.1])
	by web1.lanscape.net (8.9.3/8.9.3) with ESMTP id IAA21415;
	Sat, 23 Jun 2001 08:05:54 -0500
Received: by fisch.cyrius.com (Postfix, from userid 1000)
	id E55F122CF5; Fri, 22 Jun 2001 21:58:33 +0200 (CEST)
Date: Fri, 22 Jun 2001 21:58:33 +0200
From: Martin Michlmayr <tbm@cyrius.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: A confusing oops dump ...
Message-ID: <20010622215833.A7210@fisch.cyrius.com>
References: <3B326224.DE937DAA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B326224.DE937DAA@mvista.com>; from jsun@mvista.com on Thu, Jun 21, 2001 at 02:07:48PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

* Jun Sun <jsun@mvista.com> [20010621 14:07]:
> Oops in fault.c:do_page_fault, line 172:

Is this related to the oops I get when booting my DECstation or are
these separate issues?

Unable to handle kernel paging request at virtual address 00000004, epc == 80053f48, ra == 80053f00
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 10002000 80720410 00000000 80720410 00000000 00001090 00000001
$8 : 00000000 00000000 00000000 00000000 801ed867 fffffff7 ffffffff 81097470
$16: 81092000 00010000 00000000 80048020 fffffff4 00010f00 80721090 80720fe0
$24: 00000001 0000000a                   80720000 80720f58 00000000 80053f00
epc  : 80053f48
Status: 10002004
Cause : 30000008
Process  (pid: 0, stackpage=80720000)
Stack: 8005b7c4 00000001 000000c0 8005b488 801e703c 800f574c 00000000 00000000
       00000000 80720f7c 80720f7c 00000023 00000000 00000000 00000000 80720f7c
       80720f7c 00000023 00010f00 00010000 00000000 80048020 30464354 a0002f88
       00000200 001220d2 44208a0a 8004d5d0 00000000 ffffffff ffffffff 00000000
       8004deac bc180001 00010f00 00000000 80721090 bc180001 801ed867 fffffff7
       00000000 ...
Call Trace: [<8005b7c4>] [<8005b488>] [<800f574c>] [<80048020>] [<8004d5d0>] [<8004deac>]
Code: 24630010  8e0501d4  8e030218 <8ca20004> 00000000  0043102b 1040030f  2414fff5  40046000
