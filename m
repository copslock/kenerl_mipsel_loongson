Received:  by oss.sgi.com id <S553714AbRBGX4s>;
	Wed, 7 Feb 2001 15:56:48 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:48352 "EHLO dea.waldorf-gmbh.de")
	by oss.sgi.com with ESMTP id <S553687AbRBGX4e>;
	Wed, 7 Feb 2001 15:56:34 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f17NoIS24931;
	Wed, 7 Feb 2001 15:50:18 -0800
Date:   Wed, 7 Feb 2001 15:50:17 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jim Freeman <jfree@sovereign.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: merges into stock kernel tree
Message-ID: <20010207155017.A24908@bacchus.dhis.org>
References: <20010207111342.A27046@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010207111342.A27046@sovereign.org>; from jfree@sovereign.org on Wed, Feb 07, 2001 at 11:13:42AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Feb 07, 2001 at 11:13:42AM -0700, Jim Freeman wrote:

> Not having a variety of mips hw to play with, what is the functional
> status of mips as shipped in the mainstream kernel?
> 
> How does that status compare to the functional status of the
> current mips in cvs?

32-bit kernel was never functional; 64-bit kernel should compile again
if Linus accepts my latest batch of patches.

> What's on the todo list prior to another merge into the upstream?

As usual - rework anything that isn't suitable to be merged into Linus'
tree.

  Ralf
