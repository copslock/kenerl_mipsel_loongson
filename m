Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 09:46:33 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:53262 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225196AbTEAIqb>;
	Thu, 1 May 2003 09:46:31 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h418kRD00468;
	Thu, 1 May 2003 04:46:27 -0400
Received: from redhat.com (IDENT:g1uT+0K5dE+oNhWqHzBheWaHvt6PAWVt@vpn50-11.rdu.redhat.com [172.16.50.11])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h418kRq23564;
	Thu, 1 May 2003 04:46:27 -0400
Received: (from aph@localhost)
	by redhat.com (8.11.6/8.11.0) id h418kM006000;
	Thu, 1 May 2003 09:46:22 +0100
From: Andrew Haley <aph@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16048.57054.224964.883062@cuddles.redhat.com>
Date: Thu, 1 May 2003 09:46:22 +0100
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>, gcc@gcc.gnu.org
Subject: Re: GCC -O2 failure for mipsel
In-Reply-To: <3EB0DDC6.5080108@ict.ac.cn>
References: <3EB0B329.9030603@ict.ac.cn>
	<16048.55936.346808.522687@cuddles.redhat.com>
	<3EB0DDC6.5080108@ict.ac.cn>
X-Mailer: VM 7.14 under Emacs 21.2.1
Return-Path: <aph@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aph@redhat.com
Precedence: bulk
X-list: linux-mips

Fuxin Zhang writes:
 >  Thanks, -fno-strict-aliasing works.
 > --The actual code can't be changed: because it is part of spec cpu2000:)

Perhaps SPEC need to have ISO C explained to them...

Andrew.
