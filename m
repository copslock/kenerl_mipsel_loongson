Received:  by oss.sgi.com id <S42299AbQIILCz>;
	Sat, 9 Sep 2000 04:02:55 -0700
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.30]:28464 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S42297AbQIILCm>; Sat, 9 Sep 2000 04:02:42 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.31] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 2.05 #1 (Debian))
	id 13XiOp-0004sh-00; Sat, 9 Sep 2000 13:02:19 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13XiOp-0001ok-00; Sat, 09 Sep 2000 13:02:19 +0200
Date:   Sat, 9 Sep 2000 13:02:19 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: glibc again
Message-ID: <20000909130219.A6979@bilbo.physik.uni-konstanz.de>
References: <20000909000736.A6050@bilbo.physik.uni-konstanz.de> <20000908191612.B17687@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000908191612.B17687@chem.unr.edu>; from wesolows@chem.unr.edu on Fri, Sep 08, 2000 at 07:16:12PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 08, 2000 at 07:16:12PM -0700, Keith M Wesolowski wrote:
> I'm astonished it only complained about unresolved symbols. If you
> leave it as is, it tries to link in your build system's libraries. I
> always replace the two with full paths to the mips libraries. I'm
> fairly sure this is also in my cross-build faq.
Acutally it really first tried to link in the glibc in /lib, which I
overrided with LDFLAGS=-L/u/l/mips-linux/...
I couldn't find anything about it in the cross-mips faq. But IMHO it
would be worth a note(maybe also in the mips-howto?).
Regards,
 -- Guido 

-- 
GPG-Public Key: finger agx@debian.org
