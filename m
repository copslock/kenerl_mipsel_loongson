Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 15:57:09 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:54969 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24141184AbYLEP47 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2008 15:56:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB5Fuv28002852;
	Fri, 5 Dec 2008 15:56:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB5FusP5002849;
	Fri, 5 Dec 2008 15:56:54 GMT
Date:	Fri, 5 Dec 2008 15:56:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nick Andrew <nick@nick-andrew.net>
Cc:	Jonathan Corbet <corbet@lwn.net>,
	"Kevin D. Kissell" <kevink@paralogos.com>,
	Lucas Woods <woodzy@gmail.com>, linux-mips@linux-mips.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix incorrect use of loose in vpe.c
Message-ID: <20081205155654.GA2765@linux-mips.org>
References: <S24119814AbYLEAhF/20081205003705Z+5882@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S24119814AbYLEAhF/20081205003705Z+5882@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 05, 2008 at 11:36:54AM +1100, Nick Andrew wrote:
> From: Nick Andrew <nick@nick-andrew.net>
> Date: Fri, 05 Dec 2008 11:36:54 +1100
> To: Jonathan Corbet <corbet@lwn.net>, "Kevin D. Kissell" <kevink@mips.com>,
> 	Lucas Woods <woodzy@gmail.com>, Nick Andrew <nick@nick-andrew.net>,
> 	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Fix incorrect use of loose in vpe.c
> 
> Fix incorrect use of loose in vpe.c
> 
> From: Nick Andrew <nick@nick-andrew.net>
> 
> It should be 'lose', not 'loose'.
> 
> Signed-off-by: Nick Andrew <nick@nick-andrew.net>

Thanks, applied.  Note that the address you used for Kevin Kissel to post
your patch is no longer valid.

  Ralf
