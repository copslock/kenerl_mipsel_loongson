Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7M0qct02585
	for linux-mips-outgoing; Tue, 21 Aug 2001 17:52:38 -0700
Received: from hp5030-int.trinity200.org (adsl-64-173-206-186.dsl.renocs.nvbell.net [64.173.206.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7M0qb902582
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 17:52:37 -0700
Received: from oss.sgi.com (tmoss@hmpiii2.trinity200.org [10.0.0.9])
	by hp5030-int.trinity200.org (8.11.1/8.11.1) with ESMTP id f7M0qnO27347;
	Tue, 21 Aug 2001 17:52:49 -0700
Message-ID: <3B830249.4060708@oss.sgi.com>
Date: Tue, 21 Aug 2001 17:52:25 -0700
From: Tim Moss <linux-mips@oss.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010819
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
CC: ralf@gnu.org
Subject: serial console bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

If I am connected to my Challenge S server via serial console using 
minicom from Linux and minicom dies (eg - the X server where minicom was 
running from crashes), the Challenge box resets. I haven't done really 
extensive testing but this error is definitely recreatable.

My current kernel is 2.4.5. I compiled it myself from CVS but I'm pretty 
sure this also happened with the precompiled 2.4.3 kernel from the oss 
ftp site.
