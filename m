Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KK6sK06833
	for linux-mips-outgoing; Fri, 20 Apr 2001 13:06:54 -0700
Received: from ayr-74.ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KK6sM06830
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 13:06:54 -0700
Received: from ayrnetworks.com (IDENT:chua@localhost.localdomain [127.0.0.1])
	by ayr-74.ayrnetworks.com (8.11.0/8.11.0) with ESMTP id f3KK6q211501;
	Fri, 20 Apr 2001 13:06:52 -0700
Message-ID: <3AE096DC.ECB49D19@ayrnetworks.com>
Date: Fri, 20 Apr 2001 13:06:52 -0700
From: Bryan Chua <chua@ayrnetworks.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "George Gensure,,," <werkt@csh.rit.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: glibc build
References: <3AE08A99.50201@csh.rit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

CFLAGS=-D__PIC__ make all [check] install

the target "check" will not work if you are cross compiling, so you
might as well install...  You end up coming across this in several
places.

-- bryan

"George Gensure,,," wrote:

> Where is the CFLAGS that I should add to? In the Subdirectories?
>
> George
> werkt@csh.rit.edu
