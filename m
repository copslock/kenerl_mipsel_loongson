Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 02:52:31 +0000 (GMT)
Received: from s306.secure.ne.jp ([IPv6:::ffff:211.9.215.133]:57097 "HELO
	s306.secure.ne.jp") by linux-mips.org with SMTP id <S8225321AbULPCwZ>;
	Thu, 16 Dec 2004 02:52:25 +0000
Received: (qmail 31622 invoked from network); 16 Dec 2004 11:52:04 +0900
Received: from unknown (HELO koseki) (163.139.182.183)
  by 0 with SMTP; 16 Dec 2004 11:52:04 +0900
Message-ID: <006201c4e31a$79171ff0$2100a8c0@koseki>
From: "Tatsuya Koseki" <koseki@shimafuji.co.jp>
To: "Ralf Baechle" <ralf@linux-mips.org>,
	"Linux MIPS mailing list" <linux-mips@linux-mips.org>
References: <009001c4e1ba$54a431f0$2100a8c0@koseki> <20041215131753.GC27935@linux-mips.org>
Subject: Re: kernel 2.6.9 patch
Date: Thu, 16 Dec 2004 11:53:41 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <koseki@shimafuji.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: koseki@shimafuji.co.jp
Precedence: bulk
X-list: linux-mips

I find this message,
  http://www.linux-mips.org/archives/linux-mips/2004-10/msg00256.html

Thank you  for reply.


> On Tue, Dec 14, 2004 at 05:53:02PM +0900, Tatsuya Koseki wrote:
> 
> > Subject: kernel 2.6.9 patch
> > Date: Tue, 14 Dec 2004 17:53:02 +0900
> > Content-Type: text/plain;
> > charset="iso-2022-jp"
> > 
> > Please review 
> > 
> > 
> > --- linux/include/asm/stackframe.h.old Tue Dec 14 17:49:38 2004
> > +++ linux/include/asm/stackframe.h Tue Dec 14 17:50:35 2004
> > @@ -244,6 +244,10 @@
> >    nor v1, $0, v1
> >    and v0, v1
> >    or v0, a0
> > +
> > +  li v1,2
> > +  or v0,v1
> > +
> >    mtc0 v0, CP0_STATUS
> >    LONG_L v1, PT_EPC(sp)
> >    MTC0 v1, CP0_EPC
> 
>  o Your patch got corrupted by using a differnet indentation so couldn't be
>    applied anyway
>  o When posting a patch, post an explanation.  If the purpose of a patch
>    isn't obvious it'll likely be ignroed.
>  o This bug was already fixed in CVS.
>  o The issue only affected new-born processes, so there is no reason to
>    burden the fix on every exception taken.
>  o Why using two instruction if one would be sufficient.
> 
>   Ralf
> 
