Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 21:30:22 +0100 (CET)
Received: from isilmar.linta.de ([213.133.102.198]:53480 "EHLO linta.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491862Ab0CAUaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Mar 2010 21:30:18 +0100
Received: (qmail 22477 invoked from network); 1 Mar 2010 20:29:36 -0000
Received: from unknown (HELO comet.dominikbrodowski.net) (brodo@82.113.106.134)
  by isilmar.linta.de with (DHE-RSA-AES256-SHA encrypted) SMTP; 1 Mar 2010 20:29:36 -0000
Received: by comet.dominikbrodowski.net (Postfix, from userid 1000)
        id 7A1C480093; Mon,  1 Mar 2010 20:39:17 +0100 (CET)
Date:   Mon, 1 Mar 2010 20:39:17 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-PCMCIA <linux-pcmcia@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] pcmcia: alchemy: fixup wrong comments
Message-ID: <20100301193917.GA28486@comet.dominikbrodowski.net>
Mail-Followup-To: Manuel Lauss <manuel.lauss@googlemail.com>,
        Linux-PCMCIA <linux-pcmcia@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
References: <1267462718-17383-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1267462718-17383-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <linux@dominikbrodowski.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.net
Precedence: bulk
X-list: linux-mips

Hey Manuel,

On Mon, Mar 01, 2010 at 05:58:38PM +0100, Manuel Lauss wrote:
> Commit 11b897cf84c37e6522db914793677e933ef311fb  changed expected
> pcmcia area addresses from the 32bit pseudo to the real 36bit
> addresses, but did not update the comments.

thanks for the patch. Could you add your Signed-off-by (as per
Documentation/SubmittingPatches), please?

Thanks
	Dominik
