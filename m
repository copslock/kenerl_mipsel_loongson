Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DLfk315151
	for linux-mips-outgoing; Thu, 13 Sep 2001 14:41:46 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DLfie15148
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 14:41:44 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 13 Sep 2001 21:42:47 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id OAA19342
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 14:40:25 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id QAA19050; Thu, 13 Sep 2001 16:41:05 -0500
Message-ID: <3BA12877.6030505@esstech.com>
Date: Thu, 13 Sep 2001 16:43:19 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010816
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: How can I determine which files are used?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Is there a recommended method of determining which files in the
Linux source tree are used with a given .config file?  I've already
removed the obvious things like unused entries in the arch directory
and a couple of driver directories, but is there a way to generate a
list of only the files that are used?

I know I've read discussions about someday splitting up the source code
into smaller blocks, but can someone point me towards information on how
to prune the existing source tree?

Thanks.

Gerald
