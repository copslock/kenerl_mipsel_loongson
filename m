Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f47I4qK17086
	for linux-mips-outgoing; Mon, 7 May 2001 11:04:52 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f47I4lF17052
	for <linux-mips@oss.sgi.com>; Mon, 7 May 2001 11:04:49 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f45GFZ201292;
	Sat, 5 May 2001 13:15:35 -0300
Date: Sat, 5 May 2001 13:15:35 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: drivers/chat/vt.c - keyboard click
Message-ID: <20010505131535.A1252@bacchus.dhis.org>
References: <20010504134958.A513@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504134958.A513@paradigm.rfc822.org>; from flo@rfc822.org on Fri, May 04, 2001 at 01:49:58PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 04, 2001 at 01:49:58PM +0200, Florian Lohoff wrote:

> Does any of the currently supported mips architectures actually support
> this ? I guess the RM200 could but i dont think that tree will actually work.
> 
> I suggest to apply this:

My plan was to eleminate all this mess and use CONFIG_PC_BEEPER instead.

  Ralf
