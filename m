Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2003 14:12:57 +0000 (GMT)
Received: from p508B53C9.dip.t-dialin.net ([IPv6:::ffff:80.139.83.201]:63619
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225223AbTCBOM4>; Sun, 2 Mar 2003 14:12:56 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h22ECoq01423;
	Sun, 2 Mar 2003 15:12:50 +0100
Date: Sun, 2 Mar 2003 15:12:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Static variables and "gp"
Message-ID: <20030302151250.A1224@linux-mips.org>
References: <1046605567.d43b0840yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046605567.d43b0840yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Sun, Mar 02, 2003 at 11:46:07AM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 02, 2003 at 11:46:07AM +0000, Gilad Benjamini wrote:

> Who said user-code ?
> Strictly kernel

Well ...  Register $28 is already used for the current pointer.  You'd
have to get rid of the $28 optimization first before GP optimization could
work.

  Ralf
