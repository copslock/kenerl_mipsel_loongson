Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IKYgs18897
	for linux-mips-outgoing; Wed, 18 Apr 2001 13:34:42 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IKYfM18894
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 13:34:41 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id PAA02538;
	Wed, 18 Apr 2001 15:34:18 -0500
Message-ID: <3ADDFD6A.AD0DDE4A@cotw.com>
Date: Wed, 18 Apr 2001 15:47:38 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
References: <20010418141959.A24473@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> 
> I've been trying to make this patch work as part of a complete
> toolchain, based on glibc.  In addition to a little snag (when building
> glibc for big-endian mips you need an equivalent change in the target
> format), I hit a serious shared library error - nothing linked
> dynamically worked.  This is the cause:
> 
Yes, I have a patch against GLIBC. Go to my FTP site here:

    ftp://ftp.cotw.com/pub/linux/nino/toolchain

It is currently a hack as I have not figured out how to construct a
patch for GLIBC since it will break the other MIPS targets. See if
it helps.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
