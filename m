Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 16:27:58 +0100 (BST)
Received: from mx1.rmicorp.com ([63.111.213.197]:2767 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20023921AbZC2P1v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2009 16:27:51 +0100
Received: from 71.145.149.108 ([71.145.149.108]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Sun, 29 Mar 2009 15:27:42 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 29 Mar 2009 10:27:46 -0500
Subject: Re: [PATCH 0/3] Alchemy: platform updates
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <49CF71BE.2070109@ru.mvista.com>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
	 <49CF5CE6.1070003@ru.mvista.com>
	 <20090329143802.0a09baca@scarran.roarinelk.net>
	 <49CF71BE.2070109@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sun, 29 Mar 2009 10:27:46 -0500
Message-Id: <1238340466.28598.4.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-03-29 at 17:03 +0400, Sergei Shtylyov wrote:
>   Single kernel binary? If it's at all possible, I am all for it.

On some level, I agree but not at the expense of a larger kernel or
longer boot times.  Maybe I'm just not following how your implementation
works but it seems to me that runtime checks will add to boot time.
More importantly it adds to the kernel memory footprint as the tables of
constants for multiple CPUs will have to be compiled in.  If I'm
designing a board with an Au1250 in it, I don't care about the interrupt
numbers for Au1100 or Au1500.  This problem compounds when we introduce
Au1300 - several of its subsystems (like the interrupt controller) are
new requiring not only a new table of constants but a new object as
well.  In the desktop space I can understand this approach, but in the
embedded space it seems like an unnecessary resource burden.  

Please enlighten me :)

=Kevin
-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
