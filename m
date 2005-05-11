Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2005 17:13:59 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:3343 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8226018AbVEKQNl>;
	Wed, 11 May 2005 17:13:41 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1DVu93-0006LG-00; Wed, 11 May 2005 17:33:13 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=shoreditch.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1DVtpW-0004Uk-00; Wed, 11 May 2005 17:13:02 +0100
Received: from 127.0.0.1 (ident=unknown) by shoreditch.mips.com with
 esmtp (masqmail 0.2.20) id 1DVtpW-5nX-00; Wed, 11 May 2005 17:13:02
 +0100
Message-ID: <42822F0D.4030602@mips.com>
Date:	Wed, 11 May 2005 17:13:01 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	mile.davidovic@micronasnit.com
CC:	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: Mips 4KEC
References: <200505111424.j4BEOu1p017560@krt.neobee.net>
In-Reply-To: <200505111424.j4BEOu1p017560@krt.neobee.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.824,
	required 4, AWL, BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

Mile Davidovic wrote:

>
>
>2. I tried to use sde-lite 5.03 toolchain but this toolchain (sde-gcc)
>failed to build kernel. 
>    Please any comments regarding this issue? 
>

SDE-lite is a "bare-iron" compiler which isn't very suitable for 
building the Linux kernel. Instead you could try the version of the SDE 
toolchain which has been configured as a Linux compiler, as described 
here http://www.linux-mips.org/wiki/index.php/Toolchains#MIPS_SDE

Nigel
