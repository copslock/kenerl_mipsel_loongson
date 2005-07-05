Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 15:57:57 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:205.217.158.170]:9170
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8226258AbVGEO5g>; Tue, 5 Jul 2005 15:57:36 +0100
Received: (qmail 27659 invoked from network); 5 Jul 2005 07:57:49 -0700
Received: from c-24-6-216-150.hsd1.ca.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 5 Jul 2005 07:57:49 -0700
Message-ID: <42CA9FF3.8060504@total-knowledge.com>
Date:	Tue, 05 Jul 2005 07:57:55 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050620)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Arianna Arona <arianna@dsi.unimi.it>
CC:	linux-mips@linux-mips.org
Subject: Re: 2.6.12 does not read MAC address
References: <200507051643.09070.arianna@dsi.unimi.it>
In-Reply-To: <200507051643.09070.arianna@dsi.unimi.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Yes, kerenl doesn't read mac address correctly on O2K. Some timeing
issue in the driver
as far as I can tell. None of my kernels ever could read it on O2K, even
though it works
just fine on O200.

No you are wrong. Forcing MAC address works just fine. At least it does
so here.
You just have to force it to correct value (i.e. the one origin was
using when it
was sending bootp/tftp packets.

Look at the logs at your boot server.

--
Ilya A. Volynets-Evenbakh
Total Knowledge, CTO
http://www.total-knowledge.com/

Arianna Arona wrote:

>Hi everybody,
>
>my network problem are now due to MAC address.
>Kernel does not read it and forcing the value via ifconfig does not solve the 
>problem.
>
>I need to merge the old driver, which detects MAC addr but eth0 link is down,
>with the new one that does the contraty..... opsss.... I could have a not 
>working at all driver.... :((
>
>A.
>
>  
>
