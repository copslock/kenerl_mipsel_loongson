Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA9LJfZ18719
	for linux-mips-outgoing; Fri, 9 Nov 2001 13:19:41 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA9LJe018713
	for <linux-mips@oss.sgi.com>; Fri, 9 Nov 2001 13:19:40 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA9LL4B12485;
	Fri, 9 Nov 2001 13:21:04 -0800
Message-ID: <3BEC4866.FEC62378@mvista.com>
Date: Fri, 09 Nov 2001 13:19:34 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: preemptible kernel for Linux/MIPS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Here is the patch you can try out.  Please give me your feedback.

http://linux.junsun.net/realtime-linux

Note a couple of things:

. it is against 2.4.10
. to apply it cleanly you need to check oss CVS tree on 10/30.  See readme.
. you can only run it on a board that is configured with CONFIG_NEW_IRQ.

An updated patch, probably against 2.4.14, will be made soon - hopefully. :-)

Jun
