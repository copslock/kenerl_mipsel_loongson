Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IKO3R18374
	for linux-mips-outgoing; Wed, 18 Apr 2001 13:24:03 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IKO2M18371
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 13:24:02 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 3167DF18F; Wed, 18 Apr 2001 13:23:24 -0700 (PDT)
Date: Wed, 18 Apr 2001 13:23:24 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Ralph Metzler <rjkm@convergence.de>
Cc: Quinn Jensen <jensenq@Lineo.COM>, linux-mips@oss.sgi.com
Subject: Re: Linux on LSI EZ4102
Message-ID: <20010418132323.A25356@foobazco.org>
References: <15062.17293.403963.722517@valen.metzler> <3ADDBFA2.7030608@Lineo.COM> <15069.58552.717979.620325@valen.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15069.58552.717979.620325@valen.metzler>; from rjkm@convergence.de on Wed, Apr 18, 2001 at 09:02:16PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 18, 2001 at 09:02:16PM +0200, Ralph Metzler wrote:

> I first based my port on the Linux version from linux-vr.sourceforge.net
> which is a modified 2.4.0test9. Now it seems others have problems with
> caching on that kernel with other MIPS architectures too. 
> So, I'll better move to one of the 2.4.3-ac kernels first. I saw that
> they contain quite a few changes, especially in the cache handling. 

Any -ac kernel contains at most the same changes that are in the oss
tree.  Trees other than the oss one, including ac, are likely to
contain more bugs.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
