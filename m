Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 02:50:56 +0200 (CEST)
Received: from gateway03.websitewelcome.com ([69.93.60.24]:43709 "HELO
	gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1493708AbZJVAuq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 02:50:46 +0200
Received: (qmail 19388 invoked from network); 22 Oct 2009 01:01:46 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway03.websitewelcome.com with SMTP; 22 Oct 2009 01:01:46 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:55727 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1N0lsz-0001V4-2O; Wed, 21 Oct 2009 19:50:37 -0500
Message-ID: <4ADFAC5E.5020506@paralogos.com>
Date:	Wed, 21 Oct 2009 17:50:38 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:	"wilbur.chan" <wilbur512@gmail.com>
CC:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	ddaney@caviumnetworks.com, linux-mips@linux-mips.org
Subject: Re: Got trap No.23 when booting mips32 ?
References: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>	 <4ADF32D1.6030801@ru.mvista.com> <e997b7420910211704w67517b3bud6f4757a35945ba@mail.gmail.com>
In-Reply-To: <e997b7420910211704w67517b3bud6f4757a35945ba@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

wilbur.chan wrote:
> Kernal didn't resgister IRQ 23 when booting. Hmm....the only '23'
> number I can find in kernel is in traps.c.
>
> Why a 23 IRQ was triggered?
>
>   
The usual reason would be a failure to correctly initialize an interrupt 
controller, or the Status.IM mask field.  The kernel complains precisely 
*because* IRQ 23 wasn't registered, but an interrupt was nevertheless 
delivered that was decoded as being that IRQ.

          Regards,

          Kevin K.
