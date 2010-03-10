Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 21:44:45 +0100 (CET)
Received: from isilmar.linta.de ([213.133.102.198]:52828 "EHLO linta.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491076Ab0CJUoi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Mar 2010 21:44:38 +0100
Received: (qmail 15308 invoked from network); 10 Mar 2010 20:44:25 -0000
Received: from p54a06b14.dip.t-dialin.net (HELO comet.dominikbrodowski.net) (brodo@84.160.107.20)
  by isilmar.linta.de with (DHE-RSA-AES256-SHA encrypted) SMTP; 10 Mar 2010 20:44:25 -0000
Received: by comet.dominikbrodowski.net (Postfix, from userid 1000)
        id 63CC78009B; Wed, 10 Mar 2010 21:35:34 +0100 (CET)
Date:   Wed, 10 Mar 2010 21:35:34 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     linux-pcmcia@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] pcmcia/vrc4171: use local spinlock for device local
 lock.
Message-ID: <20100310203534.GA5922@comet.dominikbrodowski.net>
Mail-Followup-To: Yoichi Yuasa <yuasa@linux-mips.org>,
        linux-pcmcia@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
References: <20100310155756.496e2bbf.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100310155756.496e2bbf.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <linux@dominikbrodowski.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.net
Precedence: bulk
X-list: linux-mips

Hey,

On Wed, Mar 10, 2010 at 03:57:56PM +0900, Yoichi Yuasa wrote:
> struct pcmcia_socket lock had been used before.

Applied, thanks.

	Dominik
