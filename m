Received:  by oss.sgi.com id <S553996AbRBAIie>;
	Thu, 1 Feb 2001 00:38:34 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:63757 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553979AbRBAIiJ>; Thu, 1 Feb 2001 00:38:09 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14OFFl-0007SK-00; Thu, 01 Feb 2001 09:38:05 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14OFFk-0001ay-00; Thu, 01 Feb 2001 09:38:04 +0100
Date:   Thu, 1 Feb 2001 09:38:04 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Calvine Chew <calvine@sgi.com>
Cc:     'linux-mips' <linux-mips@oss.sgi.com>
Subject: Re: Building XFree86 4.0.2?
Message-ID: <20010201093804.A6104@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: Calvine Chew <calvine@sgi.com>,
	'linux-mips' <linux-mips@oss.sgi.com>
References: <43FECA7CDC4CD411A4A3009027999112267E49@sgp-apsa001e--n.singapore.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267E49@sgp-apsa001e--n.singapore.sgi.com>; from calvine@sgi.com on Thu, Feb 01, 2001 at 02:55:28PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 01, 2001 at 02:55:28PM +0800, Calvine Chew wrote:
> Thanks Guido. Do I need to patch rpm too? Will glibc 2.0.6-7 do or do I need
> 2.1.95?
2.0.6 will do the job fine. You need the glibc rpm along with the
devel-rpm from oss.sgi.com:/pub/linux/mips/glibc/mips-linux. Your
toolchains might be outdated too. Egcs 1.0.3a and binutils 2.8.1 are
known to work.
 -- Guido
