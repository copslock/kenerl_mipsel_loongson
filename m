Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 17:01:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27582 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027008AbYBSRBv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 17:01:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JH1ngL017195;
	Tue, 19 Feb 2008 17:01:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JH1l7I017194;
	Tue, 19 Feb 2008 17:01:47 GMT
Date:	Tue, 19 Feb 2008 17:01:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>,
	Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [MIPS] BCM47XX: use new SSB SPROM data structure
Message-ID: <20080219170147.GA15678@linux-mips.org>
References: <20080217200947.GH1403@cs181133002.pp.htv.fi> <20080218074944.GA9317@hall.aurel32.net> <20080218100126.GA22519@hall.aurel32.net> <20080218100431.GC22519@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080218100431.GC22519@hall.aurel32.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 18, 2008 at 11:04:31AM +0100, Aurelien Jarno wrote:

> Switch the BCM47XX code to the new SPROM data structure now that
> the old one has been removed.

Thanks, applied too.

  Ralf
