Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3HHYd119117
	for linux-mips-outgoing; Tue, 17 Apr 2001 10:34:39 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3HHYXM19113
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 10:34:35 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3HHXtY07807;
	Tue, 17 Apr 2001 14:33:55 -0300
Date: Tue, 17 Apr 2001 14:33:55 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: ld.script.in  Missing  PROVIDE (etext = .);
Message-ID: <20010417143355.G7177@bacchus.dhis.org>
References: <3AD5BCF9.862FCE33@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD5BCF9.862FCE33@cotw.com>; from samcconn@cotw.com on Thu, Apr 12, 2001 at 07:34:33AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 12, 2001 at 07:34:33AM -0700, Scott A McConnell wrote:

> Shouldn't there be a :
> 
>  PROVIDE (etext = .);

No.  Why?

  Ralf
