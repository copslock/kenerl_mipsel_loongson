Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 14:08:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11752 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039453AbWJWNIU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 14:08:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9ND8haQ020984;
	Mon, 23 Oct 2006 14:08:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9ND8eYv020983;
	Mon, 23 Oct 2006 14:08:40 +0100
Date:	Mon, 23 Oct 2006 14:08:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	tglx@linutronix.de, johnstul@us.ibm.com
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
Message-ID: <20061023130839.GA19789@linux-mips.org>
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp> <453BC5B4.50005@ru.mvista.com> <20061023.120407.122620341.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023.120407.122620341.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 23, 2006 at 12:04:07PM +0900, Atsushi Nemoto wrote:

> As I wrote in reply to Manish, I do not see good reason to use
> module_init here.

module_init code is being called fairly late in the game.  But as long as
there are no initizalization order issues arising I prefer to initialize
things a) after console code for easier debugging b) explicitly.

  Ralf
