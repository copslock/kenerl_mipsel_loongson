Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3JH508d007604
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Apr 2002 10:05:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3JH507L007603
	for linux-mips-outgoing; Fri, 19 Apr 2002 10:05:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from web11906.mail.yahoo.com (web11906.mail.yahoo.com [216.136.172.190])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3JH4w8d007589
	for <linux-mips@oss.sgi.com>; Fri, 19 Apr 2002 10:04:58 -0700
Message-ID: <20020419170605.41020.qmail@web11906.mail.yahoo.com>
Received: from [209.243.184.133] by web11906.mail.yahoo.com via HTTP; Fri, 19 Apr 2002 10:06:05 PDT
Date: Fri, 19 Apr 2002 10:06:05 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Equivalent of ioperm / iopl in linux mips ?
To: Linux-MIPS <linux-mips@oss.sgi.com>
In-Reply-To: <20020221095505.A28496@lucon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I would like to access Io ports from a user land
application. I found a MINI HOWTO giving an exmaple
using ioperm / iopl and then outb, inb. Searching the
mips source code I see that sys_ioperm returns
"ENOSYS" function not implemented.

Does anyone know how to implement ioperm / iopl type
functionality on a mips system. Any example code would
be appreciated.

Wayne.

__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
