Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2005 15:51:08 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:57097 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225263AbVIUOus>;
	Wed, 21 Sep 2005 15:50:48 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1EI5u3-0003pK-00; Wed, 21 Sep 2005 15:48:55 +0100
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EI5vc-0006nI-00; Wed, 21 Sep 2005 15:50:32 +0100
Message-ID: <43317338.7080803@mips.com>
Date:	Wed, 21 Sep 2005 15:50:32 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	phess.linux@streber24.de
CC:	linux-mips@linux-mips.org
Subject: Re: newbie question
References: <21597.1127313799@www52.gmx.net>
In-Reply-To: <21597.1127313799@www52.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.9,
	required 4, AWL, BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



phess.linux@streber24.de wrote:

>Hi there!
>
>First I have to say that I'm a newbie without any experience with "linux
>kernel". So don't blame me ;-)
>
>I downloaded toolchains from MIPS Technologies.
>I downloaded the newest version Linux 2.6.14-rc1 via CVS.
>
>I installed the toolchain and tested some examples like "hello world" and
>"minicom". They worked fine. I copied the linux kernel into a new folder of
>the toolchain example directory. Then I tried to make (with command sde-make
>menuconfig and then sde-make SBD=GSIM32L) the linux kernel. But all I get
>are the following five lines:
>  
>

Don't try to use the bare-iron/embedded MIPS SDE toolchain to build a 
Linux kernel. Instead use the version which is configured as a Linux 
native or cross compiler. See 
http://www.linux-mips.org/wiki/Toolchains#MIPS_SDE

Nigel
