Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2Q2vNn32561
	for linux-mips-outgoing; Sun, 25 Mar 2001 18:57:23 -0800
Received: from lacrosse.corp.redhat.com (host154.207-175-42.redhat.com [207.175.42.154])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2Q2vMM32558
	for <linux-mips@oss.sgi.com>; Sun, 25 Mar 2001 18:57:22 -0800
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by lacrosse.corp.redhat.com (8.9.3/8.9.3) with ESMTP id VAA19802;
	Sun, 25 Mar 2001 21:57:11 -0500
Received: from redhat.com (IDENT:joe@dhcp-242.hsv.redhat.com [172.16.17.242] (may be forged))
	by mx.hsv.redhat.com (8.11.0/8.11.0) with ESMTP id f2Q2xLx21091;
	Sun, 25 Mar 2001 20:59:22 -0600
Message-ID: <3ABEB120.8020609@redhat.com>
Date: Sun, 25 Mar 2001 21:01:52 -0600
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
References: <00eb01c0b2c6$02c7ef60$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Kevin,

	It's Sunday night, and I always have screwy suggestions for the world at 
the end of the weekend, so bear with me...

	And as another worthy collegue noted, these opinions are mine and do not 
necesarily represent the stance of my company.

Kevin D. Kissell wrote:

> Here at MIPS Technologies, we use Linux internally
> for design verification, experiments, benchmarking,
> etc., and as a consequence Carsten Langgaard and
> myself have both been active in this forum, and have
> tried to help the general Linux/MIPS community as
> best we can with the limited time that we can dedicate
> to the problem, in terms of suggested patches, bug
> fixes, cleanups, integration of needed components
> like the FPU emulator, etc.
> 

	I have to say that the answers I've gotten on MIPS issues on this list has been exceptionally good, both from the MIPS team and the various other individuals.

> I have a question for those of you who are doing
> Linux work for *new* platforms (as opposed to the
> SGI/DEC legacy box support people).  IF, and I
> emphasize the word *if*, MIPS Technologies were
> make a bigger investment in MIPS/Linux technology,
> be it kernel enhancements, cross/native tools,
> userland ports, libraries, or whatever, what would
> be your prioritized "wish list"?
> 

Just some unsorted random ideas:

1. Would it be possible to lump some of the different MIPS variants together more closely? In my dream world I could build one kernel that would boot on every mips architecture. This way the work can be more general. As it stands now, if you want Tx39 or Vr41 variants you're working out of a different tree. With the number of SoC core products coming out at present, this predicament is only likely to get more serious. I know at one point in time you could boot a single ARM kernel on several different systems and it would adapt it's processor specifics at runtime. Such a design might help to bring the MIPS world together a bit.

2. Tools are always an issue, but as long as new cores keep coming along that have exceptions and additions to the ISA(s), it's going to be good business for gcc engineers... 

3. Using glibc in a cross development environment is slightly painful at this time for all architectures. MIPS is no different. Some general work on glibc would be good for the whole world. There has also been some work on other libraries (newlib and uClibc) for especially constrained environments. No MIPS/Linux support is available for either.

4. uClinux support for the systems without MMUs. There is considerable interest in this effort, but I think many people underestimate the magnitude of effort that will be required to have a truly solid port. This effort might be daunting for any one vendor, but could benefit all.

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9257
fax   : (256)-837-3839
