Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 20:09:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50922 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27032793AbcEUSJoMXrNX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 May 2016 20:09:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4LI9fU2023495;
        Sat, 21 May 2016 20:09:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4LI9e6E023492;
        Sat, 21 May 2016 20:09:40 +0200
Date:   Sat, 21 May 2016 20:09:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrea Gelmini <andrea.gelmini@gelma.net>
Cc:     trivial@kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 0201/1529] Fix typo
Message-ID: <20160521180940.GA2151@linux-mips.org>
References: <20160521120219.10406-1-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160521120219.10406-1-andrea.gelmini@gelma.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, May 21, 2016 at 02:02:19PM +0200, Andrea Gelmini wrote:

> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/mips/sgi-ip27/ip27-init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
> index 570098b..75f7da7 100644
> --- a/arch/mips/sgi-ip27/ip27-init.c
> +++ b/arch/mips/sgi-ip27/ip27-init.c
> @@ -76,7 +76,7 @@ static void per_hub_init(cnodeid_t cnode)
>  #ifdef CONFIG_REPLICATE_EXHANDLERS
>  	/*
>  	 * If this is not a headless node initialization,
> -	 * copy over the caliased exception handlers.
> +	 * copy over the aliased exception handlers.
>  	 */
>  	if (get_compact_nodeid() == cnode) {
>  		extern char except_vec2_generic, except_vec3_generic;
> -- 
> 2.8.2.534.g1f66975

Nack.  Not a typo.

  Ralf
