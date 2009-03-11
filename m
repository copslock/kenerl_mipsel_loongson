Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2009 19:59:11 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:54723 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366501AbZCKT7I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2009 19:59:08 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2BJx6Kv007546;
	Wed, 11 Mar 2009 20:59:06 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2BJx41B007543;
	Wed, 11 Mar 2009 20:59:04 +0100
Date:	Wed, 11 Mar 2009 20:59:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] TXx9: update defconfigs
Message-ID: <20090311195904.GD3112@linux-mips.org>
References: <1236177944-24243-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1236177944-24243-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 04, 2009 at 11:45:44PM +0900, Atsushi Nemoto wrote:
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Date: Wed,  4 Mar 2009 23:45:44 +0900
> To: linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org
> Subject: [PATCH] TXx9: update defconfigs
> 
> Enable following features:
> * MTD (PHYSMAP)
> * LED (LEDS_GPIO)
> * RBTX4939
> * 7SEGLED
> * IDE (IDE_TX4938, IDE_TX4939)
> * SMC91X
> * RTC_DRV_TX4939

Guess this one still belongs into 2.6.29 to cut some of the rough edges
for the users.  Applied, thanks Atsushi-San!

  Ralf
