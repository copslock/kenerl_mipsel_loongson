Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 22:17:01 +0200 (CEST)
Received: from sj-iport-3.cisco.com ([171.71.176.72]:48347 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493411AbZJVUQz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 22:16:55 +0200
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=dvomlehn@cisco.com; l=2184; q=dns/txt;
  s=sjiport03001; t=1256242615; x=1257452215;
  h=from:sender:reply-to:subject:date:message-id:to:cc:
   mime-version:content-transfer-encoding:content-id:
   content-description:resent-date:resent-from:resent-sender:
   resent-to:resent-cc:resent-message-id:in-reply-to:
   references:list-id:list-help:list-unsubscribe:
   list-subscribe:list-post:list-owner:list-archive;
  z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>|Subject:
   =20Re:=20Got=20trap=20No.23=20when=20booting=20mips32=20?
   |Date:=20Thu,=2022=20Oct=202009=2013:16:45=20-0700
   |Message-ID:=20<20091022201645.GA15619@cuplxvomd02.corp.s
   a.net>|To:=20"wilbur.chan"=20<wilbur512@gmail.com>|Cc:=20
   Linux=20MIPS=20Mailing=20List=20<linux-mips@linux-mips.or
   g>|MIME-Version:=201.0|Content-Transfer-Encoding:=208bit;
  bh=Jq5CB0mjza3GMk4oo2hkdB33y/QI6NwHZaHn9zgf9pw=;
  b=iI60zTmgU5fZQeNYYWvbwTLiMlg4jz8yztxq/Ztm/+sWzWAZUYIOl+rb
   /SuDmfroe50zSG3AcA9fzM7okvol5vJgkTc7/dvSZJvOwICHM0583lvbh
   iqNOE+yizNn+jrivPB/RG2ES1gmvmeMNNLP5MgxNEp8q2v5YNMwCxZPNi
   I=;
Authentication-Results:	sj-iport-3.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACNa4EqrR7Ht/2dsb2JhbADEEIkgCI8pgkUJCIFpBIFdew
X-IronPort-AV: E=Sophos;i="4.44,607,1249257600"; 
   d="scan'208";a="198358832"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-3.cisco.com with ESMTP; 22 Oct 2009 20:16:46 +0000
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id n9MKGjEU004576;
	Thu, 22 Oct 2009 20:16:46 GMT
Date:	Thu, 22 Oct 2009 13:16:45 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	"wilbur.chan" <wilbur512@gmail.com>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Got trap No.23 when booting mips32 ?
Message-ID: <20091022201645.GA15619@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

>And I found that , as a matter of  fact , kernel has registered No.23 as a trap.
>
>In trap_init :
>
>/*
>1419          * Only some CPUs have the watch exceptions.
>1420          */
>1421         if (cpu_has_watch)
>1422                 set_except_vector(23, handle_watch);
>
>
>So, if a No.23 "signal" happened , kernel should  invoke handle_watch instead.
>
>
>But why here kernel complained ? and why kernel entered the IRQ branch
>(do_IRQ) rather than trap branch?

It looks like you are confusing interrupts and exceptions. Exceptions
are a generally a change in the flow of execution of a processor due to
a condition internal to the processor. So, a divide by zero is an a exception.

An interrupt is a change in execution flow due to a device external to the
processor. Keyboards use interrupts to indicate that a key has been
pressed.

Things can be slightly confusing on the MIPS processor because interrupts
are normally treated as a type of exception. In this case, the exception
type in the ExcCode field of the Cause register is "Int". If your system
uses the external vectored interrupt controller, it will not use an
exception and will instead use an array of interrupt handlers.

In your case, you are getting interrupt request (IRQ) number 23. The message
you are getting indicates that no device driver has told the kernel that
it can handle this interrupt. I suggest that you consult the documentation
for your system to determine which device is using IRQ 23 and ensure that
you have a device driver installed for that device. It is unusual that
a device would cause an interrupt without actions from the device driver;
you might want to investigate the possibility that your system is
incorrectly configured, causing the incorrect IRQ to be generated.

I suggest reading the book, "See MIPS Run Linux" by Dominic Sweetman, to learn
more about the low level details of interrupts and exceptions on the MIPS
processor. For exact details, consult "MIPS32® Architecture For Programmers
Volume III: The MIPS32® Privileged Resource Architecture", available at
mips.com (you need to sign up for a free account)

David VL
