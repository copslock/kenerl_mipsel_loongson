Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 23:13:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8916 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133723AbWDZWM4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Apr 2006 23:12:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3QMCtRh022312;
	Wed, 26 Apr 2006 23:12:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3QMCsJo022311;
	Wed, 26 Apr 2006 23:12:54 +0100
Date:	Wed, 26 Apr 2006 23:12:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shyamal Sadanshio <shyamal.sadanshio@gmail.com>
Cc:	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>
Subject: Re: Crosstools for MALTA MIPS in little endian
Message-ID: <20060426221254.GA21670@linux-mips.org>
References: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com> <4448F638.9060502@mips.com> <3857255c0604260145i65356e12w89c6667756cddd3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3857255c0604260145i65356e12w89c6667756cddd3c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 26, 2006 at 02:15:29PM +0530, Shyamal Sadanshio wrote:

> I am facing boot problem with the Malta specific 2.6.12-rc6 kernel.
> The kernel is not booting up on our Malta 4kc development board.
> I do not see any error messages on the minicom window.

In case you're using the default configuration file, it's set to
MIPS32R1 but the 4Kc is an R1 processor.  Are you sure you really have a
4Kc and not a 4Kec?  The latter is an R2 processor.

  Ralf
