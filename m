Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 06:39:59 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:64012 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225348AbTISFj5>;
	Fri, 19 Sep 2003 06:39:57 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h8J5N1O10698;
	Fri, 19 Sep 2003 01:23:01 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h8J5dlL14550;
	Fri, 19 Sep 2003 01:39:47 -0400
Received: from ghostwheel.sfbay.redhat.com (vpn26-2.sfbay.redhat.com [172.16.26.2])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h8J5dkw26945;
	Thu, 18 Sep 2003 22:39:46 -0700
Subject: Re: recent binutils and mips64-linux
From: Eric Christopher <echristo@redhat.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
In-Reply-To: <20030919.122940.45519247.nemoto@toshiba-tops.co.jp>
References: <20030918212727.GA24686@nevyn.them.org>
	 <1063940280.2423.13.camel@ghostwheel.sfbay.redhat.com>
	 <20030919.122940.45519247.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Message-Id: <1063949984.2537.0.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 18 Sep 2003 22:39:45 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-09-18 at 20:29, Atsushi Nemoto wrote:
> >>>>> On Thu, 18 Sep 2003 19:58:00 -0700, Eric Christopher <echristo@redhat.com> said:
> echristo> mips-linux-gcc -mabi=32 -march=64bitarch is my suggestion.
> 
> But mips64 kernel assumes that the kernel itself is compiled with
> "-mabi=64".  For example, some asm routines pass more than 4 arguments
> via aN registers.

Yes, but then you aren't abi compliant are you? If you want n64 then say
n64. If you want o32 extended to 64-bit registers then use o64.

-eric

-- 
Eric Christopher <echristo@redhat.com>
