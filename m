Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 03:58:15 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:43274 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225446AbTISC6L>;
	Fri, 19 Sep 2003 03:58:11 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h8J2fHO03501;
	Thu, 18 Sep 2003 22:41:17 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h8J2w4L04575;
	Thu, 18 Sep 2003 22:58:04 -0400
Received: from unused (vpn26-7.sfbay.redhat.com [172.16.26.7])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h8J2w1w21860;
	Thu, 18 Sep 2003 19:58:03 -0700
Subject: Re: recent binutils and mips64-linux
From: Eric Christopher <echristo@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
In-Reply-To: <20030918212727.GA24686@nevyn.them.org>
References: <20030918212727.GA24686@nevyn.them.org>
Content-Type: text/plain
Message-Id: <1063940280.2423.13.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 18 Sep 2003 19:58:00 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-09-18 at 14:27, Daniel Jacobowitz wrote:
> I'm sure this has been discussed already...
> 
> The Linux kernel currently uses among other things, -Wa,-32,-mgp64.  The
> point is to use 32-bit ELF and 64-bit instructions.  But nowadays binutils
> requires that the ABI explicitly match the width of GP registers.
> 
> Can gas still do ELF32 in with 64-bit registers?  If so, what the heck is
> the command-line magic?

Discussed on irc :)

mips-linux-gcc -mabi=32 -march=64bitarch is my suggestion.

otherwise, -mabi=o64 is o32 extended to 64-bit registers.

-eric

-- 
Eric Christopher <echristo@redhat.com>
