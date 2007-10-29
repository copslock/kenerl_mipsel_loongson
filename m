Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 19:18:38 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8874 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023016AbXJ2TSg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 19:18:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TJITHh018413;
	Mon, 29 Oct 2007 19:18:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TJI78s018412;
	Mon, 29 Oct 2007 19:18:07 GMT
Date:	Mon, 29 Oct 2007 19:18:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Roel Kluin <12o3l@tiscali.nl>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix post-fence error
Message-ID: <20071029191807.GA14710@linux-mips.org>
References: <47228018.8020202@tiscali.nl> <472328C2.4000002@ru.mvista.com> <47232C2D.8010002@tiscali.nl> <20071029150233.GA4165@linux-mips.org> <4725FDE5.70407@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4725FDE5.70407@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 29, 2007 at 06:36:05PM +0300, Sergei Shtylyov wrote:

>    I'm afraid this new patch is wrong...

Indeed.  Thanks for proofreading, even if after the fact ...

  Ralf
