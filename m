Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 17:08:50 +0100 (BST)
Received: from fnoeppeil43.netpark.at ([217.175.205.171]:48296 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20021987AbYHEQIn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 17:08:43 +0100
Received: (qmail 28927 invoked from network); 5 Aug 2008 18:08:39 +0200
Received: from flagship.roarinelk.net (HELO ?192.168.0.197?) (192.168.0.197)
  by fnoeppeil43.netpark.at with SMTP; 5 Aug 2008 18:08:39 +0200
Message-ID: <48987B07.80502@roarinelk.homelinux.net>
Date:	Tue, 05 Aug 2008 18:08:39 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
Organization: Private
User-Agent: Thunderbird 2.0.0.16 (X11/20080726)
MIME-Version: 1.0
To:	Kevin Hickey <khickey@rmicorp.com>
CC:	linux-fbdev-devel@lists.sf.net, L-M-O <linux-mips@linux-mips.org>
Subject: Re: [PATCH] au1200fb: fixup PM support.
References: <20080805124221.GA27469@roarinelk.homelinux.net> <1217952137.23188.2.camel@kh-ubuntu.razamicroelectronics.com>
In-Reply-To: <1217952137.23188.2.camel@kh-ubuntu.razamicroelectronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Kevin Hickey wrote:
> On Tue, 2008-08-05 at 14:42 +0200, Manuel Lauss wrote:
>> Remove last traces of the custom Alchemy linux-2.4 PM code, implement
>> suspend/resume callbacks.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>> ---
>>  drivers/video/au1200fb.c |  164 ++++++++++++----------------------------------
>>  1 files changed, 41 insertions(+), 123 deletions(-)
>>
> This looks good.  It applied to my tree and appears functional on my
> board.  One question: what about dynamic brightness?  It was part of the
> old PM interface and you seem to have removed it.  Any ideas about
> re-integrating that into the current PM model?

Hm, good point.  Let me see if I can hook the 2 PWMs into the backlight
framework somehow...   I'll repost once this works.


> Acked-by: Kevin Hickey <khickey@rmicorp.com>

MfG,
	Manuel Lauss
