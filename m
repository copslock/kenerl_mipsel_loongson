Received:  by oss.sgi.com id <S42200AbQF0J2n>;
	Tue, 27 Jun 2000 02:28:43 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:45836 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42189AbQF0J20>; Tue, 27 Jun 2000 02:28:26 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id CAA02757
	for <linux-mips@oss.sgi.com>; Tue, 27 Jun 2000 02:33:42 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id CAA40247 for <linux-mips@oss.sgi.com>; Tue, 27 Jun 2000 02:27:55 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA84262
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 27 Jun 2000 02:26:02 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06001
	for <linux@cthulhu.engr.sgi.com>; Tue, 27 Jun 2000 02:26:01 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 136rcx-0004pJ-00; Tue, 27 Jun 2000 11:25:55 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Tue, 27 Jun 2000 11:17:28 +0200
Date:   Tue, 27 Jun 2000 11:17:28 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        "Bradley D. LaRonde" <brad@ltc.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
Message-ID: <20000627111727.A2352@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@gmx.net>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>,
	Ralf Baechle <ralf@oss.sgi.com>,
	"Bradley D. LaRonde" <brad@ltc.com>,
	linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de> <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com> <39547DB3.4FF35339@niisi.msk.ru> <20000624131218.A17554@bilbo.physik.uni-konstanz.de> <20000625001255.C894@bacchus.dhis.org> <39585E84.3E75C76A@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <39585E84.3E75C76A@niisi.msk.ru>; from raiko@niisi.msk.ru on Tue, Jun 27, 2000 at 11:57:56AM +0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jun 27, 2000 at 11:57:56AM +0400, Gleb O. Raiko wrote:
> > Does X building ever need the hostcompiler?
> 
> This depends on your taste basically. If you want 'clean' build w/o
> stupid errors, you should define CROSS_COMPILE and other macros to be
> used diring cross compilation. After that, X understands there are
> hostcompiler and crosscompiler. Then, makedepend & Co are compiled by
> hostcompiler and X server itself are compiler by cross compiler. In
> principle, you may safely ignore all that stuff and be ready to build
> makedep & Co manually.
"define CROSS_COMPILE" is not perfect yet. E.g. xkbcomp is compiled for
target architecture(since it's needed there) but the build process also tries 
to execute it on the host, same for pswrap.
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
