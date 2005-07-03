Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jul 2005 03:17:41 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:57220 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8226107AbVGCCRZ>;
	Sun, 3 Jul 2005 03:17:25 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j632HMua016564;
	Sat, 2 Jul 2005 22:17:22 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j632HHu21188;
	Sat, 2 Jul 2005 22:17:17 -0400
Received: from vpn26-4.sfbay.redhat.com (vpn26-4.sfbay.redhat.com [172.16.26.4])
	by potter.sfbay.redhat.com (8.12.8/8.12.8) with ESMTP id j632HEWM024711;
	Sat, 2 Jul 2005 22:17:15 -0400
Subject: Re: -march=r10000 Support for MIPS Targets (Old 3.4.x Patch;
	requires porting, assistance requested)
From:	Eric Christopher <echristo@redhat.com>
To:	Kumba <kumba@gentoo.org>
Cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
In-Reply-To: <42C4CBDF.1030609@gentoo.org>
References: <42C0D94F.3030809@gentoo.org>
	 <200506281007.12754.stevenb@suse.de>  <42C4CBDF.1030609@gentoo.org>
Content-Type: text/plain
Date:	Sat, 02 Jul 2005 19:17:13 -0700
Message-Id: <1120357033.5829.5.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

>  
> the newer define_insn_reservation.  Not really having the free time to 
> constantly rebuild gcc to test to see if numbers were placed appropriately, I've 
> looked for other means to get this patch converted.

There's at least some usefulness in getting the rest of the cpu specific
bits added and worrying about the pipeline description later. If you
want to submit those parts that'd be great.

-eric
