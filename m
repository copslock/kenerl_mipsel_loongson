Received:  by oss.sgi.com id <S42217AbQFWRIa>;
	Fri, 23 Jun 2000 10:08:30 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:33635 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42182AbQFWRIQ>;
	Fri, 23 Jun 2000 10:08:16 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA23077
	for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 10:03:18 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA76918 for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 10:06:30 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA24008
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 23 Jun 2000 10:04:43 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06189
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jun 2000 10:04:41 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from ernie.physik.uni-konstanz.de (bert.physik.uni-konstanz.de) [134.34.144.19] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 135Wsr-0004fV-00; Fri, 23 Jun 2000 19:04:49 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Fri, 23 Jun 2000 18:55:54 +0200
Date:   Fri, 23 Jun 2000 18:55:54 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     "Bradley D. LaRonde" <brad@ltc.com>
Cc:     linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
Message-ID: <20000623185553.A20888@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@gmx.net>,
	"Bradley D. LaRonde" <brad@ltc.com>,
	linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <014f01bfdd33$8877b3c0$0701010a@ltc.com>; from brad@ltc.com on Fri, Jun 23, 2000 at 12:53:19PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jun 23, 2000 at 12:53:19PM -0400, Bradley D. LaRonde wrote:
> ----- Original Message -----
> From: "Guido Guenther" <guido.guenther@gmx.net>
[..snip..] 
> Hmm... I use XFree 4.0 on my mipsel platform with no core paches (just some
> config stuff and some kdrive stuff).
> 
> What do your patches do?
It adds the neccessary config stuff to config/cf and sorts out the proper 
architecture dependent routines in xfree86/os-support.
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
