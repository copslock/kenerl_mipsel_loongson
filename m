Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9PMFDb06679
	for linux-mips-outgoing; Thu, 25 Oct 2001 15:15:13 -0700
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9PMFB006675
	for <linux-mips@oss.sgi.com>; Thu, 25 Oct 2001 15:15:11 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id PAA16365;
	Thu, 25 Oct 2001 15:15:06 -0700 (PDT)
Date: Thu, 25 Oct 2001 15:15:06 -0700
From: Geoffrey Espin <espin@idiom.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: RedHat 7.1/mips update
Message-ID: <20011025151506.A13071@idiom.com>
References: <20011024121646.A6520@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20011024121646.A6520@lucon.org>; from H . J . Lu on Wed, Oct 24, 2001 at 12:16:46PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H.J.

> I updated my RedHat 7.1/mips port. There are quite a few changes. Check it
> out.

Thanks... works great, as did the last one, as far as I could tell.
Sadly, the only fix I wanted didn't make it in:

 mipsel-linux-gcc ...
 Assembler messages:  
 Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.
 Warning: The -march option is incompatible to -mipsN and therefore ignored.

Oh, well.  :-)

Geoff
-- 
Geoffrey Espin
espin@idiom.com
