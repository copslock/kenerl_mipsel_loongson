Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 09:17:19 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34278 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492190AbZK0IRQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2009 09:17:16 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAR8Gxih014596;
        Fri, 27 Nov 2009 08:17:00 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAR8Gusc014594;
        Fri, 27 Nov 2009 08:16:56 GMT
Date:   Fri, 27 Nov 2009 08:16:56 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Ming Lei <tom.leiming@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        David Brownell <dbrownell@users.sourceforge.net>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 06/38] move iodev_remove to .devexit.text
Message-ID: <20091127081656.GA6948@linux-mips.org>
References: <1259096853-18909-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <1259096853-18909-6-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1259096853-18909-6-git-send-email-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 10:07:01PM +0100, Uwe Kleine-König wrote:

> The function iodev_remove is used only wrapped by __devexit_p so define
> it using __devexit.

Thanks, queued for 2.6.33.

  Ralf
