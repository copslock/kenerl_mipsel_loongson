Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jan 2003 14:11:41 +0000 (GMT)
Received: from gtwy.nap.wideopenwest.com ([IPv6:::ffff:64.233.207.11]:50871
	"EHLO pop-1.dnv.wideopenwest.com") by linux-mips.org with ESMTP
	id <S8225262AbTAaOLk> convert rfc822-to-8bit; Fri, 31 Jan 2003 14:11:40 +0000
Received: from localhost.localdomain (s233-106-251.nap.wideopenwest.com [64.233.251.106])
	by pop-1.dnv.wideopenwest.com (8.11.6/8.11.6) with ESMTP id h0VEGDX10245;
	Fri, 31 Jan 2003 08:16:13 -0600
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jason Ormes <jormes@wideopenwest.com>
Reply-To: jormes@wideopenwest.com
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: compiling mips64 problem
Date: Fri, 31 Jan 2003 08:14:51 -0600
User-Agent: KMail/1.4.3
Cc: linux-mips@linux-mips.org
References: <002801c2c8a6$a41f3470$4437e183@fermi.win.fnal.gov> <20030131105003.B31631@linux-mips.org>
In-Reply-To: <20030131105003.B31631@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301310814.51628.jormes@wideopenwest.com>
Return-Path: <jormes@wideopenwest.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jormes@wideopenwest.com
Precedence: bulk
X-list: linux-mips

On Friday 31 January 2003 03:50 am, Ralf Baechle wrote:
> On Thu, Jan 30, 2003 at 03:29:16PM -0600, Jason Ormes wrote:
> > could someone throw me a bone and let me know what I'm doing wrong?
>
> Hey, a new problem, seems you were creative ;-)
>
> What commands did you use to configure and compile this kernel?
>
>   Ralf
well,

I went into the linux folder and did a make menuconfig.  I changed the cpu 
selection to mips64 and went to the kernel hacking section and turned on the 
are you using a cross compiler option.  exited and saved.

commands used after that were

make ARCH=mips64 dep
make ARCH=mips64 all



any thoughts?
