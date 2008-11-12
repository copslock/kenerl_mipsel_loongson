Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 15:45:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:65433 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23636906AbYKLPpk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Nov 2008 15:45:40 +0000
Date:	Wed, 12 Nov 2008 15:45:40 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kevin Hickey <khickey@rmicorp.com>
cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
In-Reply-To: <1226497082.9026.23.camel@kh-d820-ubuntu.razamicroelectronics.com>
Message-ID: <alpine.LFD.1.10.0811121540430.7161@ftp.linux-mips.org>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>  <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>  <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net> 
 <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>  <491AB16A.3050203@ru.mvista.com> <1226497082.9026.23.camel@kh-d820-ubuntu.razamicroelectronics.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 12 Nov 2008, Kevin Hickey wrote:

> > > And in keeping with my other email, I think that the evalboards
> > > directory is a good idea (though I would recommend the name
> > > "develboards" as that is what DB stands for), but it should contain
> > >   
> >    I'd prefer devel-boards, or dev-boards.
> dev-boards works for me.

 FWIW, I'd call it "boards" -- it's shorter, sounds and looks right, no 
question about hyphens and clear.  That is I do hope it is and everybody 
involved will know it's not about wood or directors.

  Maciej
