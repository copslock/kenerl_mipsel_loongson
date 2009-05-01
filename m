Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 18:29:58 +0100 (BST)
Received: from terminus.zytor.com ([198.137.202.10]:43449 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20027183AbZEAR3v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 18:29:51 +0100
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n41HIPSU028658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 May 2009 10:18:25 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id n41HIOqU009097;
	Fri, 1 May 2009 10:18:24 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n41HIK58014054;
	Fri, 1 May 2009 10:18:22 -0700
Message-ID: <49FB2EDC.9050300@zytor.com>
Date:	Fri, 01 May 2009 10:18:20 -0700
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Sam Ravnborg <sam@ravnborg.org>
CC:	Tim Abbott <tabbott@MIT.EDU>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Waseem Daher <wdaher@MIT.EDU>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@MIT.EDU>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bryan Wu <cooloney@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@uclinux.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	Mikael Starvik <starvik@axis.com>,
	Paul Mackerras <paulus@samba.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@twiddle.net>,
	Roman Zippel <zippel@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	user-mode-linux-devel@lists.sourceforge.net,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss sections.
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu> <1241121253-32341-2-git-send-email-tabbott@mit.edu> <20090501091848.GB18326@uranus.ravnborg.org> <alpine.DEB.1.10.0905010951100.3955@vinegar-pot.mit.edu> <49FB2449.1010301@zytor.com> <20090501171717.GA26401@uranus.ravnborg.org>
In-Reply-To: <20090501171717.GA26401@uranus.ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.94.2/9309/Thu Apr 30 20:55:03 2009 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

Sam Ravnborg wrote:
> On Fri, May 01, 2009 at 09:33:13AM -0700, H. Peter Anvin wrote:
>> Tim Abbott wrote:
>>> On Fri, 1 May 2009, Sam Ravnborg wrote:
>>>
>>>> On Thu, Apr 30, 2009 at 03:54:08PM -0400, Tim Abbott wrote:
>>>>> +#define __PAGE_ALIGNED_DATA	.section ".data.page_aligned", "aw", @progbits
>>>>> +#define __PAGE_ALIGNED_BSS	.section ".bss.page_aligned", "aw", @nobits
>>>> It is my understanding that the linker will automatically
>>>> assume nobits for section names starting with .bss and likewise
>>>> progbits for section names starting with .data - so we can leave them out?
>>> I believe that is correct.
>>>
>> ... but that doesn't mean it's the right thing to do.
>>
>> It's better to be fully explicit when macroizing this kind of stuff.
>> This is part of why macroizing it is good: it means we end up with *one*
>> place that determines this stuff, not some magic heuristics in the linker.
> 
> Do you know if we can use % in place of @?
> I could see that gas supports both - at least in trunk in cvs.
> 

I think it might depend on the architecture(!)... but it would
definitely have to be an issue with testing a bunch of different versions.

What's wrong with @?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
