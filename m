Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3C53b8d024038
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Apr 2002 22:03:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3C53bOm024037
	for linux-mips-outgoing; Thu, 11 Apr 2002 22:03:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3C53X8d024033
	for <linux-mips@oss.sgi.com>; Thu, 11 Apr 2002 22:03:34 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g3C542p26971;
	Thu, 11 Apr 2002 22:04:02 -0700
Date: Thu, 11 Apr 2002 22:04:01 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Rani Assaf <rani@paname.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question about r4k_clear_page_xxx()
Message-ID: <20020411220401.A26953@dea.linux-mips.net>
References: <20020410041408.G23127@paname.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020410041408.G23127@paname.org>; from rani@paname.org on Wed, Apr 10, 2002 at 04:14:08AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 10, 2002 at 04:14:08AM +0200, Rani Assaf wrote:

> I was cleaning  duplicate code between my port of  IDT RC32355 and the
> current tree. I want to use r4k_clear_page_d16() but the function uses
> store double (sd) which is not available on this processor.
> 
> What's the reason for having r4k_clear_page_xxx() use store double and
> not r4k_copy_page_xxx()??

The 32-bit kernel doesn't save or restore the upper 32-bits of general
purpose registers.  Therefore 64-bit stores can only be used with the
$zero register.

  Ralf
