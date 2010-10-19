Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 18:16:21 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54330 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491876Ab0JSQQS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Oct 2010 18:16:18 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9JGGGOY019305;
        Tue, 19 Oct 2010 17:16:16 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9JGGFbc019303;
        Tue, 19 Oct 2010 17:16:15 +0100
Date:   Tue, 19 Oct 2010 17:16:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 8/9] MIPS: Honor L2 bypass bit
Message-ID: <20101019161614.GA18934@linux-mips.org>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
 <a87064966b36ed9982d8cf05169c5524@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87064966b36ed9982d8cf05169c5524@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 16, 2010 at 02:22:37PM -0700, Kevin Cernekee wrote:

> If CP0 CONFIG2 bit 12 (L2B) is set, the L2 cache is disabled and
> therefore Linux should not attempt to use it.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  arch/mips/mm/sc-mips.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index 5ab5fa8..d072b25 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -79,6 +79,11 @@ static inline int __init mips_sc_probe(void)
>  		return 0;
>  
>  	config2 = read_c0_config2();
> +
> +	/* bypass bit */
> +	if (config2 & (1 << 12))
> +		return 0;

The spec I'm looking at says this bit is implementation defined so a
test for a particular CPU type would need to be added here.

  Ralf
