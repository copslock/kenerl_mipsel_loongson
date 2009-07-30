Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2009 23:26:54 +0200 (CEST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:42109 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493746AbZG3V0s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Jul 2009 23:26:48 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAIuscUqrR7O6/2dsb2JhbAC6bYgnkDYFhBc
X-IronPort-AV: E=Sophos;i="4.43,297,1246838400"; 
   d="scan'208";a="191353315"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-2.cisco.com with ESMTP; 30 Jul 2009 21:26:39 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n6ULQcpg021771;
	Thu, 30 Jul 2009 14:26:38 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id n6ULQccg014311;
	Thu, 30 Jul 2009 21:26:38 GMT
Date:	Thu, 30 Jul 2009 14:26:38 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	GCC Help Mailing List <gcc-help@gcc.gnu.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Relocation problem with MIPS kernel modules
Message-ID: <20090730212638.GA16548@cuplxvomd02.corp.sa.net>
References: <20090730184923.GA27030@cuplxvomd02.corp.sa.net> <4A71F15E.8040507@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A71F15E.8040507@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=963; t=1248989199; x=1249853199;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Relocation=20problem=20with=20MIPS=20ke
	rnel=20modules
	|Sender:=20;
	bh=li3nbzur8X+gznwzoV5byj8jDjS35fLU0F85fxEvXnA=;
	b=pTVeetsz4n2ajMdihBTsZ9lBch1I1t5lfQXUDtYT/Qk4Msn4T4H9YCvwEt
	cLz39EXsA1j9fijRpD0ZWrQTRaq2Vqj7GE8h/fBkTAWGxzK3QfLYV7f8PhZ4
	rACvB+7s0Z;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Thu, Jul 30, 2009 at 12:15:42PM -0700, David Daney wrote:
> David VomLehn wrote:
>> I have a MIPS loadable kernel module that, when I try to insmod it, causes the
>> kernel to emit the message:
>>
>> 	module xyz: dangerous relocation
...
>> So, who the heck knows what gcc and the linker are really generating and can
>> anyone suggest an algorithm for handling R_MIPS_HI16/R_MIPS_LO16 relocation
>> entries correctly?
>
> Without seeing your object module I am guessing.
>
> Q: What version of binutils and GCC are you using?
>
> It is the assembler's responsibility to properly sort the relocations.  
> Some versions of binutils have bugs in this area.  If you are not using  
> 2.19.1, I suggest that you upgrade.
>
> Unless you are compiling with -fsection-anchors there should be pairs of  
> R_MIPS_HI16/R_MIPS_LO16 relocations.

We are downrev in our tool set; I'll try a newer version. Thanks!

> David Daney

David VomLehn
