Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 01:07:40 +0000 (GMT)
Received: from gtwy.nap.wideopenwest.com ([IPv6:::ffff:64.233.207.11]:19849
	"EHLO pop-2.dnv.wideopenwest.com") by linux-mips.org with ESMTP
	id <S8225240AbTBEBHj> convert rfc822-to-8bit; Wed, 5 Feb 2003 01:07:39 +0000
Received: from localhost.localdomain (s233-106-251.nap.wideopenwest.com [64.233.251.106])
	by pop-2.dnv.wideopenwest.com (8.11.6/8.11.6) with ESMTP id h151Dq325828;
	Tue, 4 Feb 2003 19:13:52 -0600
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jason Ormes <jormes@wideopenwest.com>
Reply-To: jormes@wideopenwest.com
To: Andrew Clausen <clausen@melbourne.sgi.com>
Subject: Re: kernel boot error.
Date: Tue, 4 Feb 2003 19:12:28 -0600
User-Agent: KMail/1.4.3
Cc: linux-mips@linux-mips.org
References: <200302041841.10507.jormes@wideopenwest.com> <20030205004345.GI27302@pureza.melbourne.sgi.com>
In-Reply-To: <20030205004345.GI27302@pureza.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302041912.28491.jormes@wideopenwest.com>
Return-Path: <jormes@wideopenwest.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jormes@wideopenwest.com
Precedence: bulk
X-list: linux-mips

Its an ip27 origin 200 with what hinv -v reports as a 

adapter IOC3 Rev 1, (pci id 2)
        controller multi function SuperIO
        controller Ethernet Rev 1

I did a little searching online 
anhttp://www.scd.ucar.edu/nets/docs/procs/SGI-100mbps/SGI-auto.htmld found a 
lot of references to origins having problems with the autonegotiation timing 
out to fast, but the only fix that I've found has to do with editing part of 
the kernel.  here's a link to one that I found. 
http://www.scd.ucar.edu/nets/docs/procs/SGI-100mbps/SGI-auto.html 

could this be part of the problem?

Thanks for the quick response, atleast I know I'm not alone.
Jason


On Tuesday 04 February 2003 06:43 pm, Andrew Clausen wrote:
> On Tue, Feb 04, 2003 at 06:41:10PM -0600, Jason Ormes wrote:
> > hello,
> >
> > can someone help me with this error?  Is this because the network failed?
>
> I'm getting exactly the same problem.  What machine are you using?
> I'm using an ip27 (origin 200), and an acenic network card.
>
> It seems that there all kinds of PCI hacks in the ip27 support,
> and I'm currently trying to figure out how to get this card working...
>
> Cheers,
> Andrew
