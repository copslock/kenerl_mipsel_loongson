Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 16:16:07 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15814 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23637777AbYKLQQF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Nov 2008 16:16:05 +0000
Date:	Wed, 12 Nov 2008 16:16:04 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Kevin Hickey <khickey@rmicorp.com>,
	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
In-Reply-To: <491AFBAC.3010500@ru.mvista.com>
Message-ID: <alpine.LFD.1.10.0811121612480.7161@ftp.linux-mips.org>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>  <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>  <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net> 
 <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>  <491AB16A.3050203@ru.mvista.com> <1226497082.9026.23.camel@kh-d820-ubuntu.razamicroelectronics.com> <alpine.LFD.1.10.0811121540430.7161@ftp.linux-mips.org>
 <491AFBAC.3010500@ru.mvista.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 12 Nov 2008, Sergei Shtylyov wrote:

> >  FWIW, I'd call it "boards" -- it's shorter, sounds and looks right, no
> > question about hyphens and clear.  That is I do hope it is and everybody
> > involved will know it's not about wood or directors.
> 
>    This directory has only been meant for the AMD/RMI own development boards
> so far, so this won't do.

 Then please tell me why arch/mips/alchemy/boards/ won't do while 
arch/mips/alchemy/dev-boards/ (or whichever variant is agreed upon) would.

  Maciej
