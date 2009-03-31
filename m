Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 14:12:55 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56250 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022003AbZCaNMx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 14:12:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2VDCqRV025217;
	Tue, 31 Mar 2009 15:12:52 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2VDCpYc025215;
	Tue, 31 Mar 2009 15:12:51 +0200
Date:	Tue, 31 Mar 2009 15:12:51 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: PATCH for SMTC: Fix Name Collision in _clockevent_init
	functions
Message-ID: <20090331131251.GC3804@linux-mips.org>
References: <49D1FA28.4030308@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D1FA28.4030308@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 31, 2009 at 01:10:32PM +0200, Kevin D. Kissell wrote:
> From: "Kevin D. Kissell" <kevink@paralogos.com>
> Date: Tue, 31 Mar 2009 13:10:32 +0200
> To: Linux MIPS org <linux-mips@linux-mips.org>
> Subject: PATCH for SMTC: Fix Name Collision in _clockevent_init functions
> Content-Type: multipart/mixed;
> 	boundary="------------070601030706030107070108"
> 
> Commit 779e7d41ad004946603da139da99ba775f74cb1c created a name collision
> in SMTC builds.  The attached patch corrects this in a a
> not-too-terribly-ugly manner.  Note that the SMTC case has to come
> first, because CEVT_R4K will also be true.

Looks ok but I won't apply it immediately to give Manuel a chance to
comment.

  Ralf
