Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2003 05:27:57 +0000 (GMT)
Received: from webmail29.rediffmail.com ([IPv6:::ffff:203.199.83.39]:19402
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8224939AbTBXF14>; Mon, 24 Feb 2003 05:27:56 +0000
Received: (qmail 30151 invoked by uid 510); 24 Feb 2003 05:27:04 -0000
Date: 24 Feb 2003 05:27:04 -0000
Message-ID: <20030224052704.30149.qmail@webmail29.rediffmail.com>
Received: from unknown (194.175.117.86) by rediffmail.com via HTTP; 24 feb 2003 05:27:04 -0000
MIME-Version: 1.0
From: "santosh kumar gowda" <ipv6_san@rediffmail.com>
Reply-To: "santosh kumar gowda" <ipv6_san@rediffmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: macro@ds2.pg.gda.pl, netdev@oss.sgi.com, linux-mips@linux-mips.org
Subject: Re: Re: Re: (no subject)
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <ipv6_san@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ipv6_san@rediffmail.com
Precedence: bulk
X-list: linux-mips



On Mon, 24 Feb 2003 Randy.Dunlap wrote :
> >
> >
> > On Sat, 22 Feb 2003 Maciej W. Rozycki wrote :
> >>On 21 Feb 2003, santosh kumar gowda wrote:
> >>
> >> > Following message is produced at the IAD terminal.....
> >> >
> >> > # Unable to handle kernel paging request at virtual 
>address
> >> > 00000000, epc == 802
> >> > 4ce74, ra == 802592a8
> >> > Oops in fault.c:do_page_fault, line 172:
> >>[...]
> >> > Suggestions/Tips are welcome.
> >>
> >>  Decode the oops first or nobody will be able to give any
> >>help.
> >
> > how do i decode the oops ??? help pls.
>
>Please see linux/REPORTING-BUGS and
>linux/Documentation/oops-tracing.txt .
>The latter will tell you how to use use 'ksymoops'
>to decode an oops message.

The Embedded Linux running on my MIPS based device has following 
cmds...

kallsyms  kill      killall   klogd     ksyms

Also, Flash ROM of the device is loaded with kernel and 
filesystem
images. so it not possible for me to browse through the source 
code.

-San
---------------------------------
