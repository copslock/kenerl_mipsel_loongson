Received:  by oss.sgi.com id <S42369AbQIOMDZ>;
	Fri, 15 Sep 2000 05:03:25 -0700
Received: from smtp.algor.co.uk ([62.254.210.199]:35278 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S42368AbQIOMCz>;
	Fri, 15 Sep 2000 05:02:55 -0700
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by kenton.algor.co.uk (8.9.3/8.8.8) with ESMTP id NAA21576;
	Fri, 15 Sep 2000 13:02:46 +0100 (GMT/BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id NAA10050;
	Fri, 15 Sep 2000 13:02:46 +0100 (BST)
Date:   Fri, 15 Sep 2000 13:02:46 +0100 (BST)
Message-Id: <200009151202.NAA10050@mudchute.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Arnold Niessen <arnold.niessen@philips.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-kernel@vger.kernel.org,
        Evgeni Eskenazi <eskenazi@natlab.research.philips.com>
Subject: Re: FPU problems porting 2.4.0 to Algorithmics P4032 MIPS board
In-Reply-To: <20000915120127.A1453@pc4755.natlab.research.philips.com>
References: <20000915120127.A1453@pc4755.natlab.research.philips.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Arnold,

> We've got a problem with the foating point support. With either 
> soft or hard FP support, some FP operation generate an exception, 
> e.g. cvt.w.d.
> 
> We tried both with and without support of FPE soft module, 
> compiled for R46xx and R5000 processors (As far as I
> understand there is no difference in FP support in the kernel 
> for these processor types).
> 
> We did not have these problems with the (2.2.12 MIPS Technologies
> based) port we made to this same board.

MIPS CPU floating-point units always give floating point
'unimplemented' exceptions when faced with unpalatable combinations of
operation and operand.  It's their way of telling you to go calculate
it yourself.

The 2.2.12 "MIPS Technologies" port incorporated Algorithmics'
floating point trap handler and FP emulation code to provide correct
IEEE-compatible floating point.  You should either move that on to
2.4.0 or find an equivalent solution.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / http://www.algor.co.uk
