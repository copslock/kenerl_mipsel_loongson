Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 14:51:26 +0000 (GMT)
Received: from smtp104.plus.mail.re1.yahoo.com ([69.147.102.67]:65160 "HELO
	smtp104.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20024456AbXJ3OvR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 14:51:17 +0000
Received: (qmail 44545 invoked from network); 30 Oct 2007 13:09:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=Rt0BzKt0P/vNK/HzMw3kh1cNr9FYrpJa8sTeJoaNT6DrDTpDjb6/eT0rOGnwGVSktFTkTiJAK7z7US2y6CfccFH39l0eWN+tGESYeOlC6m4yqoTak234JDQy26TexMNm7vcclFCOY/VcTQF8sZJFm4ck6gIvHNc7tRi+UDt08PY=  ;
Received: from unknown (HELO ?192.168.254.6?) (jscottkasten@72.185.69.24 with login)
  by smtp104.plus.mail.re1.yahoo.com with SMTP; 30 Oct 2007 13:09:30 -0000
X-YMail-OSG: bLQBtnwVM1kUAokm4ggJmKwiKZnnT2hI4KTGDxgbiYO0QcUPvKlnqTXNn2z0hGqe_jjzckDzSA--
Date:	Tue, 30 Oct 2007 09:09:24 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	linux-mips@linux-mips.org
Subject: Re: 2.4.24-rc1 does not boot on SGI
In-Reply-To: <1193744519.7731.48.camel@scarafaggio>
Message-ID: <Pine.LNX.4.64.0710300904580.2570@pixie.tetracon-eng.net>
References: <1193468825.7474.6.camel@scarafaggio>  <20071030083106.GA16763@deprecation.cyrius.com>
  <1193733706.7731.15.camel@scarafaggio>  <Pine.SGI.4.60.0710300717080.2654@zeus.tetracon-eng.net>
 <1193744519.7731.48.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips



On Tue, 30 Oct 2007, Giuseppe Sacco wrote:

>> the closet and took care of it that way.  It sounds like the generic
>> serial stuff was broken a ways back.
>
> Using 2.6.18 debian kernel I hadn't any problem: the machine used to be
> a faxserver with hylafax (using a modem via the serial port).
>
> What kind of problem do you had with 2.6.18?
>

Well, hmm... That's good to know you had it working.  I'll check into it 
again.  I hooked the serial device up, fired up minicom and couldn't get 
any characters comming back.  Verified the line settings and all too. 
Finally tried the laptop, using the same cable, and all was fine.

To be honest, it wasn't entirely debian's kernel.  It was their source 
package, but I rebuilt with USB support.  When I get a chance, I'll look 
at this again.

-S-
