Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PKhEe16554
	for linux-mips-outgoing; Wed, 25 Apr 2001 13:43:14 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3PKhAM16551
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 13:43:12 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3PI9FT09018;
	Wed, 25 Apr 2001 15:09:15 -0300
Date: Wed, 25 Apr 2001 15:09:15 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "George Gensure,,," <werkt@csh.rit.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: /dev/psaux
Message-ID: <20010425150914.A8971@bacchus.dhis.org>
References: <3AE70E1E.6050005@csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE70E1E.6050005@csh.rit.edu>; from werkt@csh.rit.edu on Wed, Apr 25, 2001 at 01:49:18PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 25, 2001 at 01:49:18PM -0400, George Gensure,,, wrote:
> Date: Wed, 25 Apr 2001 13:49:18 -0400
> From: "George Gensure,,," <werkt@csh.rit.edu>
> To: linux-mips@oss.sgi.com
> Subject: /dev/psaux
> 
> Can someone give me some valid major and minor numbers for a ps/2 mouse 
> on an Indy?

That's an ordinary PS/2 mouse, same as on PC so that's:

crw-rw-r--   1 root     root      10,   1 Apr 24 23:41 /dev/psaux

  Ralf
