Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 16:20:56 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:52721 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23637819AbYKLQUt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2008 16:20:49 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9983A3ECE; Wed, 12 Nov 2008 08:20:45 -0800 (PST)
Message-ID: <491B025E.1090800@ru.mvista.com>
Date:	Wed, 12 Nov 2008 19:20:46 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Kevin Hickey <khickey@rmicorp.com>,
	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>  <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>  <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net>  <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>  <491AB16A.3050203@ru.mvista.com> <1226497082.9026.23.camel@kh-d820-ubuntu.razamicroelectronics.com> <alpine.LFD.1.10.0811121540430.7161@ftp.linux-mips.org> <491AFBAC.3010500@ru.mvista.com> <alpine.LFD.1.10.0811121612480.7161@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0811121612480.7161@ftp.linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maciej W. Rozycki wrote:

>>> FWIW, I'd call it "boards" -- it's shorter, sounds and looks right, no
>>>question about hyphens and clear.  That is I do hope it is and everybody
>>>involved will know it's not about wood or directors.

>>   This directory has only been meant for the AMD/RMI own development boards
>>so far, so this won't do.

>  Then please tell me why arch/mips/alchemy/boards/ won't do while 
> arch/mips/alchemy/dev-boards/ (or whichever variant is agreed upon) would.

    Let me remind you that arch/alchemy/ contains the code for the *real* 
Au1xx0 based boards produced by other vendors as well. The patch leaves their 
code where it was.

>   Maciej

WBR, Sergei
