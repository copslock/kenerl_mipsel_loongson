Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBUNW1W21747
	for linux-mips-outgoing; Sun, 30 Dec 2001 15:32:01 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBUNVog21744
	for <linux-mips@oss.sgi.com>; Sun, 30 Dec 2001 15:31:50 -0800
Received: from uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04963
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 16:13:06 -0800 (PST)
	mail_from (ralf@linux-mips.net)
Received: from eddie (root@eddie.uni-koblenz.de [141.26.4.17])
	by uni-koblenz.de (8.9.3/8.9.3) with SMTP id BAA23096
	for <linux-mips@oss.sgi.com>; Fri, 28 Dec 2001 01:09:56 +0100 (MET)
Received: from dea.linux-mips.net by eddie (SMI-8.6/KO-2.0)
	id BAA18940; Fri, 28 Dec 2001 01:09:53 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBRLJxK01602;
	Thu, 27 Dec 2001 19:19:59 -0200
Date: Thu, 27 Dec 2001 19:19:59 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, dony.he@huawei.com,
   linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
Message-ID: <20011227191959.B1553@dea.linux-mips.net>
References: <20011226013221.A737@dea.linux-mips.net> <20011227.105518.74756316.nemoto@toshiba-tops.co.jp> <20011227011222.A16695@dea.linux-mips.net> <20011227.125122.71082554.nemoto@toshiba-tops.co.jp> <20011227022936.A19397@dea.linux-mips.net> <3C2B45D3.B938CA44@eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2B45D3.B938CA44@eicon.com>; from tommy.christensen@eicon.com on Thu, Dec 27, 2001 at 05:01:23PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 27, 2001 at 05:01:23PM +0100, Tommy S. Christensen wrote:

> Great! But please make sure that the cache is flushed after the pages
> are allocated instead of before.
> 
> With 2.4.9 that still had the cache-flushing in vmalloc_area_pages(), I
> got cache aliasing problems in low memory situations (since alloc_page()
> will re-schedule when no pages are available).

Correct; I fixed that one.  That's actually a nasty one, affects all
previous Linux releases.  I wonder how this one went unnoticed for so long.
Probably because loading modules is a relativly rare event or so.

  Ralf
