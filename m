Received:  by oss.sgi.com id <S42227AbQFXLNQ>;
	Sat, 24 Jun 2000 04:13:16 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10031 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42223AbQFXLMz>; Sat, 24 Jun 2000 04:12:55 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA06580
	for <linux-mips@oss.sgi.com>; Sat, 24 Jun 2000 04:18:07 -0700 (PDT)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA79317
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 24 Jun 2000 04:12:22 -0700 (PDT)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA05838
	for <linux@cthulhu.engr.sgi.com>; Sat, 24 Jun 2000 04:12:20 -0700 (PDT)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from bilbo.physik.uni-konstanz.de [134.34.144.31] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 2.05 #1 (Debian))
	id 135nrG-0000zA-00; Sat, 24 Jun 2000 13:12:18 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 2.05 #1 (Debian))
	id 135nrG-0004ZX-00; Sat, 24 Jun 2000 13:12:18 +0200
Date:   Sat, 24 Jun 2000 13:12:18 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     "Bradley D. LaRonde" <brad@ltc.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
Message-ID: <20000624131218.A17554@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: "Gleb O. Raiko" <raiko@niisi.msk.ru>,
	"Bradley D. LaRonde" <brad@ltc.com>,
	linux-mips <linux-mips@fnet.fr>, linux <linux@cthulhu.engr.sgi.com>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de> <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com> <39547DB3.4FF35339@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
In-Reply-To: <39547DB3.4FF35339@niisi.msk.ru>; from raiko@niisi.msk.ru on Sat, Jun 24, 2000 at 01:21:55PM +0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jun 24, 2000 at 01:21:55PM +0400, Gleb O. Raiko wrote:
[..snip..] 
> If you cross-compile, you just redefine most of the stuff like CcCmd,
> ArCmd, etc, anyway.
Yes, but you have to make sure the redefinitions don't get redefined
again, therefore IMHO an "#ifdef AsCmd" is needed. Otherwise the
definition in hosts.def will be overriden by the one in linux.cf.
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
