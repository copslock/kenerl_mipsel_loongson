Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OApLa10436
	for linux-mips-outgoing; Tue, 24 Apr 2001 03:51:21 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OApGM10423
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 03:51:16 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4C4AA7F3; Tue, 24 Apr 2001 12:51:14 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C7161F391; Tue, 24 Apr 2001 12:49:46 +0200 (CEST)
Date: Tue, 24 Apr 2001 12:49:46 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Michael Shmulevich <michaels@jungo.com>
Cc: Ryan Murray <rmurray@debian.org>, linux-mips@oss.sgi.com
Subject: Re: ld.so-1.9.x for mips
Message-ID: <20010424124946.E6256@paradigm.rfc822.org>
References: <3AE44D0A.9080003@jungo.com> <20010423170302.E4623@bacchus.dhis.org> <3AE52A87.9050403@jungo.com> <20010424012409.A17800@cyberhqz.com> <3AE53D4E.2010803@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AE53D4E.2010803@jungo.com>; from michaels@jungo.com on Tue, Apr 24, 2001 at 11:46:06AM +0300
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 24, 2001 at 11:46:06AM +0300, Michael Shmulevich wrote:

> The ld.so-1.9.11-15 that is on debian FTP site does not have any support 
> for mips ELF. This is the reason why I was asking Florian, how did he 
> manage to compile it for MIPS.

Its the ld.so package from potato which itself does not contain
the ld.so but "ldconfig". This was a misnaming for a while in debian.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
