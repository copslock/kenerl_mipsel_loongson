Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f857GaM15216
	for linux-mips-outgoing; Wed, 5 Sep 2001 00:16:36 -0700
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f857GXd15212
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 00:16:33 -0700
Received: from csh.rit.edu (anna.csh.rit.edu [129.21.60.133])
	by mcp.csh.rit.edu (Postfix) with ESMTP id AE4EBE5
	for <linux-mips@oss.sgi.com>; Wed,  5 Sep 2001 03:16:26 -0400 (EDT)
Message-ID: <3B95C9C5.8070500@csh.rit.edu>
Date: Wed, 05 Sep 2001 02:44:21 -0400
From: George Gensure <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: recent kernel probs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've been keeping busy trying to keep a working kernel for a set of lab 
machines (indy r5ks) running linux, and as of a couple of days ago, I 
haven't been able to build a kernel that does not simply blank the 
screen and draw a non-blinking cursor where the mouse had been in the 
prom.  I can boot from the stock vmlinux-2.4.3.ecoff kernel, and i can 
write that kernel to the volume header to boot locally.  However, when I 
try to rebuild and boot a later kernel, with the X-ish support that I 
need, it errors as above.  It feels as if I've done something to the 
system to deserve this kind of punishment.  Can anyone help?

Thanks
George
werkt@csh.rit.edu
