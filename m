Received:  by oss.sgi.com id <S42392AbQFWRpk>;
	Fri, 23 Jun 2000 10:45:40 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:35181 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42182AbQFWRpX>; Fri, 23 Jun 2000 10:45:23 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA03853
	for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 10:50:36 -0700 (PDT)
	mail_from (brad@ltc.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA42399
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 23 Jun 2000 10:44:51 -0700 (PDT)
	mail_from (brad@ltc.com)
Received: from ltc.com (ltc.ltc.com [38.149.17.171]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id KAA03645
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jun 2000 10:44:42 -0700 (PDT)
	mail_from (brad@ltc.com)
Received: from gw1.ltc.com (gw1.ltc.com [38.149.17.163]) by ltc.com (NTMail 3.03.0017/1.afdd) with ESMTP id pa313315 for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jun 2000 13:48:57 -0400
Message-ID: <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com>
From:   "Bradley D. LaRonde" <brad@ltc.com>
To:     "Guido Guenther" <agx@bert.physik.uni-konstanz.de>
Cc:     "linux-mips" <linux-mips@fnet.fr>,
        "linux" <linux@cthulhu.engr.sgi.com>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de>
Subject: Re: XFree 4.0.1 on mips, mipsel
Date:   Fri, 23 Jun 2000 13:46:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Cool, thank you.

It looks like they won't break anything for me.  :-)

Except I did see that one place where you hard-coded gcc.  I cross-compile,
but maybe that's OK anyway.  I will test on 4.0 CVS eventually and find out.
:-)

Regards,
Brad

----- Original Message -----
From: "Guido Guenther" <agx@bert.physik.uni-konstanz.de>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "linux-mips" <linux-mips@fnet.fr>; "linux" <linux@cthulhu.engr.sgi.com>
Sent: Friday, June 23, 2000 1:07 PM
Subject: Re: XFree 4.0.1 on mips, mipsel


> On Fri, Jun 23, 2000 at 01:09:03PM -0400, Bradley D. LaRonde wrote:
> [..snip..]
> > May I have a copy of those patches for review?
> They look basically like this(Imake.cf additionally checks for mipsel):
>
> --
> GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
>
