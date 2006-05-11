Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 04:48:42 +0200 (CEST)
Received: from sccrmhc12.comcast.net ([204.127.200.82]:39076 "EHLO
	sccrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133354AbWEKCse (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 04:48:34 +0200
Received: from [127.0.0.1] (unknown[69.140.185.48])
          by comcast.net (sccrmhc12) with ESMTP
          id <200605110248280120068b1me>; Thu, 11 May 2006 02:48:28 +0000
Message-ID: <4462A603.7080409@gentoo.org>
Date:	Wed, 10 May 2006 22:48:35 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] create consistency in "system type" selection
References: <20060509213453.GA32050@deprecation.cyrius.com> <Pine.LNX.4.62.0605101026450.17487@pademelon.sonytel.be> <20060510102852.GA3193@linux-mips.org>
In-Reply-To: <20060510102852.GA3193@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> You still can but they need to be lumped together into a single group
> in the "System type" menu.  In reality it's not terribly interesting
> and rarely tested.
> 
>   Ralf

Isn't the real blocker for a multi-system kernel the Load Address?  I know w/ 
the different SGI system most of the kernels load at a different address.  Is it 
possible to encode all of these in a way that each system could detect them, or 
would we need some kind of stub loader ala arcload that'd have to be pre-pended 
onto the image to handle that for us?


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
