Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4FBb3N08998
	for linux-mips-outgoing; Tue, 15 May 2001 04:37:03 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4FBb2F08994
	for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 04:37:02 -0700
Received: from cotw.com (laptop1.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id GAA19275;
	Tue, 15 May 2001 06:31:53 -0500
Message-ID: <3B0116BA.9CDA6C63@cotw.com>
Date: Tue, 15 May 2001 06:44:58 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Murphy <brian@murphy.dk>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Problem with module loading on a 2.4 kernel
References: <3B00FB7A.12AA394B@murphy.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Brian Murphy wrote:
> 
> When we try to load a module into a 2.4.3 kernel we get the following
> error:
> 
> # insmod /lib/modules/ipchains.o
> insmod: kernel: QM_SYMBOLS: Unknown error 716862128
> 
> does anyone know what the matter here.
> 
> The toolchain we use is based on the patched egcs-1.1.2 and
> binutils-2.8.1
> at oss.
> 
And thus your problem. You need a newer toolchain. The binutils and
gcc out of CVS. For binutils you can also use HJ Lu's with version
2.11.90.0.5 or better.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
