Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2CKNFh23875
	for linux-mips-outgoing; Tue, 12 Mar 2002 12:23:15 -0800
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2CKNC923872
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 12:23:12 -0800
Received: from localhost.localdomain (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id g2CJLlr18832
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 14:21:47 -0500
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by localhost.localdomain (8.11.6/8.11.6) with ESMTP id g2CJNBm15710
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 14:23:11 -0500
Received: from redhat.com (dhcp-166.hsv.redhat.com [172.16.17.166])
	by mx.hsv.redhat.com (8.11.6/8.11.0) with ESMTP id g2CJNEN05317
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 13:23:14 -0600
Message-ID: <3C8E5560.2090907@redhat.com>
Date: Tue, 12 Mar 2002 13:22:08 -0600
From: Lanny DeVaney <ldevaney@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: gdbserver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've looked back through the archives and find some references to 
problems configuring and/or building gdbserver for mips-linux.

I'm attempting to build gdb/gdbserver with --target=mips-linux as well, 
using gdb-5.1.1.  Have the earlier issues (they looked to be 1-2 years 
old) been resolved or am I still looking at a "manual build" process? 
 I'm getting lots of errors with the build, although the configure seems 
to go OK.  x86 host, linux-mips target.

Thanks for any help you can provide,
Lanny DeVaney
Red Hat, Inc.
