Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 09:50:25 +0100 (BST)
Received: from 12-234-18-241.client.attbi.com ([IPv6:::ffff:12.234.18.241]:57216
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225196AbTEAIuX>; Thu, 1 May 2003 09:50:23 +0100
Received: from localhost.localdomain (greglaptop [127.0.0.1])
	by localhost.localdomain (8.12.8/8.12.5) with ESMTP id h418oKnm001900
	for <linux-mips@linux-mips.org>; Thu, 1 May 2003 01:50:20 -0700
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.8/8.12.8/Submit) id h418oJQR001898
	for linux-mips@linux-mips.org; Thu, 1 May 2003 01:50:19 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 1 May 2003 01:50:18 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: GCC -O2 failure for mipsel
Message-ID: <20030501085018.GA1885@greglaptop.attbi.com>
Mail-Followup-To: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
References: <3EB0B329.9030603@ict.ac.cn> <16048.55936.346808.522687@cuddles.redhat.com> <3EB0DDC6.5080108@ict.ac.cn> <16048.57054.224964.883062@cuddles.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16048.57054.224964.883062@cuddles.redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Thu, May 01, 2003 at 09:46:22AM +0100, Andrew Haley wrote:
> Fuxin Zhang writes:
>  >  Thanks, -fno-strict-aliasing works.
>  > --The actual code can't be changed: because it is part of spec cpu2000:)
> 
> Perhaps SPEC need to have ISO C explained to them...

It's just there so you can't turn on aliasing for reasonable base
options. It's all a conspiracy, I tell you...

greg
