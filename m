Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 11:33:02 +0100 (BST)
Received: from p508B6FF8.dip.t-dialin.net ([IPv6:::ffff:80.139.111.248]:43173
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbTGAKdA>; Tue, 1 Jul 2003 11:33:00 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h61AWvDB011409;
	Tue, 1 Jul 2003 12:32:57 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h61AWuA7011408;
	Tue, 1 Jul 2003 12:32:56 +0200
Date: Tue, 1 Jul 2003 12:32:56 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: ilya@theIlya.com
Cc: linux-mips@linux-mips.org
Subject: Re: CRIME memory error reporting rewrite
Message-ID: <20030701103256.GA11366@linux-mips.org>
References: <20030630233458.GT13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630233458.GT13617@gateway.total-knowledge.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 30, 2003 at 04:34:58PM -0700, ilya@theIlya.com wrote:

> This is Keith's rewrite of CRIME memory error interrupt.
> Works perfectly here, and makes life lot easier sometimes.
> Plus it converts yet another irq handler to return irqreturn_t.

Applied,

  Ralf
