Received:  by oss.sgi.com id <S42393AbQFWRzl>;
	Fri, 23 Jun 2000 10:55:41 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:895 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42182AbQFWRzU>;
	Fri, 23 Jun 2000 10:55:20 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA00886
	for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 10:50:23 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA04943 for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 10:53:34 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA51856
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 23 Jun 2000 10:51:45 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA02262
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jun 2000 10:51:34 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 135Xby-0004ky-00; Fri, 23 Jun 2000 19:51:26 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Fri, 23 Jun 2000 19:45:10 +0200
Date:   Fri, 23 Jun 2000 19:45:10 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     "Bradley D. LaRonde" <brad@ltc.com>
Cc:     linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
Message-ID: <20000623194510.A17791@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@gmx.net>,
	"Bradley D. LaRonde" <brad@ltc.com>,
	linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de> <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com>; from brad@ltc.com on Fri, Jun 23, 2000 at 01:46:39PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jun 23, 2000 at 01:46:39PM -0400, Bradley D. LaRonde wrote:
> Cool, thank you.
> 
> It looks like they won't break anything for me.  :-)
> 
> Except I did see that one place where you hard-coded gcc.  I cross-compile,
> but maybe that's OK anyway.  I will test on 4.0 CVS eventually and find out.
> :-)
The #define AsCmd gcc -c -x assemble-with-cpp was the only that caused
me trouble when crosscompiling. A patch for this is underway.
 -- Guido



-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
