Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ONQqA10535
	for linux-mips-outgoing; Thu, 24 May 2001 16:26:52 -0700
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4ONQpF10532
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 16:26:51 -0700
Received: from csh.rit.edu (anna.csh.rit.edu [129.21.60.133])
	by mcp.csh.rit.edu (Postfix) with ESMTP id 960911225
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 19:26:50 -0400 (EDT)
Message-ID: <3B0D990B.6090301@csh.rit.edu>
Date: Thu, 24 May 2001 19:28:11 -0400
From: George Gensure <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre3 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: crti.o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Anyone know what the problem is when building the latest gcc when I get 
a problem doing the final linking of the libgcc subdir?  after listing a 
whole bunch of object files, (not including crti.o) the linker errors 
out, saying that it can't find crti.o.  I've been muddling through this 
for a while and just can't figure the problem out exactly...

George
werkt@csh.rit.edu
