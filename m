Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 19:06:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:59787 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022447AbXCWTGW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 19:06:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2NJ6JhQ026945;
	Fri, 23 Mar 2007 19:06:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2NJ6HKY026944;
	Fri, 23 Mar 2007 19:06:17 GMT
Date:	Fri, 23 Mar 2007 19:06:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, miklos@szeredi.hu,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070323190617.GA26884@linux-mips.org>
References: <20070324.004146.41631259.anemo@mba.ocn.ne.jp> <36E4692623C5974BA6661C0B18EE8EDF6CD389@MAILSERV.hcrest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD389@MAILSERV.hcrest.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 23, 2007 at 11:47:20AM -0400, Ravi Pratap wrote:

> ~/fuse/example$ mkdir /tmp/fuse
> ~/fuse/example$ ./hello /tmp/fuse
> ~/fuse/example$ ls -l /tmp/fuse
> total 0
> -r--r--r--  1 root root 13 Jan  1  1970 hello
> ~/fuse/example$ cat /tmp/fuse/hello
> Hello World!
> ~/fuse/example$ fusermount -u /tmp/fuse
> ~/fuse/example$
> 
> 
> It hangs when you do ls -l /tmp/fuse, in the above example.

Yes, that's perfectly reproducable here (running a VSMP kernel on a 34K).
So the fix I posted earlier was good but I did a few tweaks to it anyway.
Will commit to all 2.6 -stable branch and master later.

  Ralf
