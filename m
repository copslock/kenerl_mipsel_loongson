Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f81GaN715321
	for linux-mips-outgoing; Sat, 1 Sep 2001 09:36:23 -0700
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f81GaLd15318
	for <linux-mips@oss.sgi.com>; Sat, 1 Sep 2001 09:36:21 -0700
Received: from csh.rit.edu (unknown [129.21.60.133])
	by mcp.csh.rit.edu (Postfix) with ESMTP id 3B672109
	for <linux-mips@oss.sgi.com>; Sat,  1 Sep 2001 12:36:20 -0400 (EDT)
Message-ID: <3B91089E.5050900@csh.rit.edu>
Date: Sat, 01 Sep 2001 12:11:10 -0400
From: George Gensure <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: segfaults with 2.4.8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm running an r5000 indy with the latest (as of 8/31/01) cvs kernel and 
the fast-sysmips patch, and I'm having segfaults and strange errors in 
building tools like gcc and in building X.  The sysmips is correcting 
things like find, but I can't have these other errors (meant for lab 
machines).  Any takers?

George
werkt@csh.rit.edu
