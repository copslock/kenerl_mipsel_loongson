Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Feb 2003 22:09:03 +0000 (GMT)
Received: from 12-234-29-241.client.attbi.com ([IPv6:::ffff:12.234.29.241]:34455
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8224939AbTBBWJC>; Sun, 2 Feb 2003 22:09:02 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h12LHnPs012289;
	Sun, 2 Feb 2003 13:17:50 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h12LHbx4012287;
	Sun, 2 Feb 2003 13:17:37 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Sun, 2 Feb 2003 13:17:37 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Cc: Karsten Merker <karsten@excalibur.cologne.de>, tom@maisl.net
Subject: Re: [PATCH] Cobalt interrupthandler fix
Message-ID: <20030202211737.GA12262@greglaptop.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org,
	Karsten Merker <karsten@excalibur.cologne.de>, tom@maisl.net
References: <20030124141524.GA685@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124141524.GA685@excalibur.cologne.de>
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Fri, Jan 24, 2003 at 03:15:24PM +0100, Karsten Merker wrote:

> the Cobalt NASRaQ (as well as other RaQ models) has the problem of freezing
> when there is activity on the serial port and on the ethernet at the same
> time. Peter de Schrijver has tracked this down to a bug in the interrupt
> handler. The handler currently does not check whether an interrupt is masked
> and calls the handling routine for _every_ interrupt, not only for those
> that are not masked out currently.

While we're at it:

[lindahl@fileserver mips]$ find . -name "*int-hand*" | xargs grep -L CP0_STATUS
./jmr3927/rbhma3100/int-handler.S
./philips/nino/int-handler.S

The philips case seems to have the same bug.

The jmr3927 thingie is hard to understand, so I can't tell if it has
the same bug or not.

-- greg
