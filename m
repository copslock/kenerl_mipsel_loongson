Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 22:06:23 +0000 (GMT)
Received: from p3EE06889.dip.t-dialin.net ([IPv6:::ffff:62.224.104.137]:52688
	"EHLO p3EE06889.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225247AbVAaWGI>; Mon, 31 Jan 2005 22:06:08 +0000
Received: from 80-219-199-111.dclient.hispeed.ch ([IPv6:::ffff:80.219.199.111]:17831
	"EHLO xbox.hb9jnx.ampr.org") by linux-mips.net with ESMTP
	id <S869546AbVAaWGI>; Mon, 31 Jan 2005 23:06:08 +0100
Received: from 10.1.0.6 ([10.1.0.6])
	(authenticated bits=0)
	by xbox.hb9jnx.ampr.org (8.13.1/8.13.1) with ESMTP id j0VM5kUB024228
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 31 Jan 2005 23:05:47 +0100
Subject: Re: initial bootstrap and jtag
From:	Thomas Sailer <sailer@scs.ch>
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <ecb4efd10501311207faf0550@mail.gmail.com>
References: <ecb4efd10501311207faf0550@mail.gmail.com>
Content-Type: text/plain
Organization: Supercomputing Systems AG
Date:	Mon, 31 Jan 2005 23:05:36 +0100
Message-Id: <1107209136.5393.26.camel@gamecube.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Return-Path: <sailer@scs.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sailer@scs.ch
Precedence: bulk
X-list: linux-mips

On Mon, 2005-01-31 at 15:07 -0500, Clem Taylor wrote:
> We are finishing up the design of our new Au1550 based board. I was
> wondering if someone could recommend an ejtag wiggler. I need

I hacked a simple program that loads u-boot into SDRAM via EJTAG. The
processor is directly connected to the host parallel port. Booting the
processor takes somewhat less than a minute on my Pb1000 board. Not
particularily fast, but acceptable for my purpose.
http://www.baycom.org/~tom/ejtag/

Tom
