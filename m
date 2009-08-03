Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2009 22:15:43 +0200 (CEST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:53109 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493370AbZHCUPh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2009 22:15:37 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAXidkqrR7O6/2dsb2JhbAC7XogpjnAFhBg
X-IronPort-AV: E=Sophos;i="4.43,316,1246838400"; 
   d="scan'208";a="222790481"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-1.cisco.com with ESMTP; 03 Aug 2009 20:15:21 +0000
Received: from sj-core-4.cisco.com (sj-core-4.cisco.com [171.68.223.138])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n73KFLIv008779;
	Mon, 3 Aug 2009 13:15:21 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-4.cisco.com (8.13.8/8.14.3) with ESMTP id n73KFLNm010931;
	Mon, 3 Aug 2009 20:15:21 GMT
Date:	Mon, 3 Aug 2009 13:15:21 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	GCC Help Mailing List <gcc-help@gcc.gnu.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Relocation problem with MIPS kernel modules
Message-ID: <20090803201521.GA24691@cuplxvomd02.corp.sa.net>
References: <20090730184923.GA27030@cuplxvomd02.corp.sa.net> <20090803092030.GB30431@linux-mips.org> <4A773B85.6010004@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A773B85.6010004@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1679; t=1249330521; x=1250194521;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Relocation=20problem=20with=20MIPS=20ke
	rnel=20modules
	|Sender:=20;
	bh=BwBoOYZ+vAhB+JoOza2wTtXVaHbwKtUkr8bFGcLJrbc=;
	b=SOeBVKorXGsXUOXnGJpcu1PJAGV+hEa0VkSvYdchQwp800eQ2GQgBNIzFp
	fqPCCMpqz6cELYqnxxZu101XJdnkLgLVUDzCQEfEztCuRfbsAOk78RZWfetx
	WIUaQpRCqj;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Mon, Aug 03, 2009 at 12:33:25PM -0700, David Daney wrote:
> Ralf Baechle wrote:
>> On Thu, Jul 30, 2009 at 11:49:23AM -0700, David VomLehn wrote:
>>
>>> To: GCC Help Mailing List <gcc-help@gcc.gnu.org>,
>>> 	Linux MIPS Mailing List <linux-mips@linux-mips.org>
>>> Subject: Relocation problem with MIPS kernel modules
>>> Content-Type: text/plain; charset=us-ascii
>>>
>>> I have a MIPS loadable kernel module that, when I try to insmod it, causes the
>>> kernel to emit the message:
>>>
>>> 	module xyz: dangerous relocation
...
>>
>> The GNU tools as an extension over the MIPS ABI allows an arbitrary number of
>> R_MIPS_HI16 relocations to be followed by a R_MIPS_LO16 symbol.  All
>> relocations of this sequence must use the same symbol, of course.  This is
>> a very old extension; I think it predates the Linux/MIPS port.
>>
>
> Actually I think it is the opposite:
>
> RELOCATION RECORDS FOR [.text]:
> OFFSET   TYPE              VALUE
> 00000000 R_MIPS_HI16       .bss+0x00000004
> 00000008 R_MIPS_LO16       .bss+0x00000004
> 00000014 R_MIPS_LO16       .bss+0x00000004
>
> We load the hi16 value into a register and then use multiple lo16  
> offsets for the follow loads and stores to the same location.  On a  
> read-modify-write we only want to load the base address one time.

This particular case is covered by the old MIPS Processor psABI:

	R_MIPS_LO16 entries without an R_MIPS_HI16 entry immediately preceding
	are orphaned and the previously defined R_MIPS_HI16 is used for
	computing the addend.

The code in module.c looks like it implements the extension to which Ralf
refers.

> David Daney

David VomLehn
