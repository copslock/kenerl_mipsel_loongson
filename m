Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 20:15:39 +0100 (BST)
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:1940 "EHLO
	smtp-out4.blueyonder.co.uk") by ftp.linux-mips.org with ESMTP
	id S20022692AbXGLTPh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 20:15:37 +0100
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1I948I-0003rM-5k; Thu, 12 Jul 2007 20:15:22 +0100
Received: from [80.192.9.150] (helo=[192.168.0.12])
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1I948F-0005rP-D3; Thu, 12 Jul 2007 20:15:21 +0100
From:	Alistair John Strachan <alistair@devzero.co.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] sb1250-duart.c: SB1250 DUART serial support
Date:	Thu, 12 Jul 2007 20:15:11 +0100
User-Agent: KMail/1.9.7
Cc:	Andy Whitcroft <apw@shadowen.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Mark Mason <mason@broadcom.com>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Joel Schopp <jschopp@austin.ibm.com>,
	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl> <469669F5.6070906@shadowen.org> <Pine.LNX.4.64N.0707121904211.3029@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0707121904211.3029@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707122015.12078.alistair@devzero.co.uk>
Return-Path: <alistair@devzero.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alistair@devzero.co.uk
Precedence: bulk
X-list: linux-mips

On Thursday 12 July 2007 19:16:20 Maciej W. Rozycki wrote:
> On Thu, 12 Jul 2007, Andy Whitcroft wrote:
[snip]
> > WARNING: declaring multiple variables together should be avoided
> > #372: FILE: drivers/serial/sb1250-duart.c:246:
> > +	unsigned int mctrl, status;
>
>  Well, this is probably superfluous -- why would anyone prefer:
>
> 	int r0;
> 	int r1;
> 	int r2;
> 	int r3;
> 	int r4;
>
> to:
>
> 	int r0, r1, r2, r3, r4;
>
> unconditionally?

Imagine you're working on a piece of kernel code that has a lot of parallel 
churn. Conflicts on lines like "int a,b,c,d;" are more likely to cause Andrew 
et al pain, which I guess is the rationale for discouraging it. Conversely, 
if the variables are kept separate, diff handles it fine.

I think as long as the variables are logically grouped, the pain is minimised, 
but there's a few good reasons for the verbose style.

-- 
Cheers,
Alistair.

137/1 Warrender Park Road, Edinburgh, UK.
