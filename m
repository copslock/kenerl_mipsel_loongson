Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 04:18:17 +0200 (CEST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:36714 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491849AbZHDCSK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 04:18:10 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEADc3d0qrR7PD/2dsb2JhbAC8PIgpjw8FgkCBWA
X-IronPort-AV: E=Sophos;i="4.43,318,1246838400"; 
   d="scan'208";a="359738060"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-6.cisco.com with ESMTP; 04 Aug 2009 02:18:01 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n742I1jm009102;
	Mon, 3 Aug 2009 19:18:01 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id n742I08R001012;
	Tue, 4 Aug 2009 02:18:00 GMT
Date:	Mon, 3 Aug 2009 19:18:01 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	GCC Help Mailing List <gcc-help@gcc.gnu.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Relocation problem with MIPS kernel modules
Message-ID: <20090804021800.GA14627@cuplxvomd02.corp.sa.net>
References: <20090730184923.GA27030@cuplxvomd02.corp.sa.net> <20090803092030.GB30431@linux-mips.org> <4A773B85.6010004@caviumnetworks.com> <20090803201521.GA24691@cuplxvomd02.corp.sa.net> <20090803235536.GB22543@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090803235536.GB22543@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1809; t=1249352281; x=1250216281;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Relocation=20problem=20with=20MIPS=20ke
	rnel=20modules
	|Sender:=20;
	bh=6w5qH6tFpo6FIo1bh7rrjStGktrnabyq0Oxoq+uewF4=;
	b=Vs1hvEHV0B9aS+StId072B4RpRhqGEC+R6Fvsx2X8Qlfuh4pss0c21q77Z
	Tpjo6bl3izhBaHbW+8JJWTfY+A2l2bblgOq9xzzNsdZXWCUqRTreHV60Fc+C
	6A4INnBgQY;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, Aug 04, 2009 at 12:55:36AM +0100, Ralf Baechle wrote:
> On Mon, Aug 03, 2009 at 01:15:21PM -0700, David VomLehn wrote:
> 
> > > Actually I think it is the opposite:
> > >
> > > RELOCATION RECORDS FOR [.text]:
> > > OFFSET   TYPE              VALUE
> > > 00000000 R_MIPS_HI16       .bss+0x00000004
> > > 00000008 R_MIPS_LO16       .bss+0x00000004
> > > 00000014 R_MIPS_LO16       .bss+0x00000004
> > >
> > > We load the hi16 value into a register and then use multiple lo16  
> > > offsets for the follow loads and stores to the same location.  On a  
> > > read-modify-write we only want to load the base address one time.
> > 
> > This particular case is covered by the old MIPS Processor psABI:
> > 
> > 	R_MIPS_LO16 entries without an R_MIPS_HI16 entry immediately preceding
> > 	are orphaned and the previously defined R_MIPS_HI16 is used for
> > 	computing the addend.
> > 
> > The code in module.c looks like it implements the extension to which Ralf
> > refers.
> 
> Which is useful for for branch delay slot scheduling like:
> 
> 	...
> 	j	1f
> 	lui	a0, %hi16(hello)
> 	...
> 	j	1f
> 	lui	a0, %hi16(hello)
> 	...
> 1:	jal	printf
> 	addiu	a0, %lo16(hello)
> 
> hello:	.asciz	"hello, hola\n"
> 
> The next and logical extension would be to permit multiple R_MIPS_LO16
> records following a sequence of one or more R_MIPS_HI16 relocs as long as
> all relate to the same symbol - which would be simple to support in the
> kernel.

This is what the orphaned R_MIPS_LO16 entries mentioned in the psABI quote
are all about. The existing relocation code handles this in most cases, but
could be juiced up a bit to do the check to verify the symbols match between
the current R_MIPS_LO16 entry and the last R_MIPS_HI16 entry.

>   Ralf

David VomLehn
