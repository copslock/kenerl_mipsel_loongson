Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 17:47:00 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51291 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904046Ab1KQQq4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 17:46:56 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAHGkoeG005667;
        Thu, 17 Nov 2011 16:46:50 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAHGknch005664;
        Thu, 17 Nov 2011 16:46:49 GMT
Date:   Thu, 17 Nov 2011 16:46:49 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Subject: Re: [PATCH V2 2/6] MIPS: lantiq: change ltq_request_gpio() call
 signature
Message-ID: <20111117164649.GE26457@linux-mips.org>
References: <1321453698-2598-1-git-send-email-blogic@openwrt.org>
 <1321453698-2598-2-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321453698-2598-2-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14595

On Wed, Nov 16, 2011 at 03:28:14PM +0100, John Crispin wrote:

> diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
> index be1e1af..c001c5a 100644
> --- a/arch/mips/pci/pci-lantiq.c
> +++ b/arch/mips/pci/pci-lantiq.c
> @@ -70,28 +70,27 @@
>  
>  struct ltq_pci_gpio_map {
>  	int pin;
> -	int alt0;
> -	int alt1;
> +	int mux;
>  	int dir;
>  	char *name;
>  };

You could save some memory here by using a shorter data type
such as char.  This is not the Alpha, no performance penalty for
using types smaller than int :)

>  /* the pci core can make use of the following gpios */
>  static struct ltq_pci_gpio_map ltq_pci_gpio_map[] = {
> -	{ 0, 1, 0, 0, "pci-exin0" },
> -	{ 1, 1, 0, 0, "pci-exin1" },
> -	{ 2, 1, 0, 0, "pci-exin2" },
> -	{ 39, 1, 0, 0, "pci-exin3" },
> -	{ 10, 1, 0, 0, "pci-exin4" },
> -	{ 9, 1, 0, 0, "pci-exin5" },
> -	{ 30, 1, 0, 1, "pci-gnt1" },
> -	{ 23, 1, 0, 1, "pci-gnt2" },
> -	{ 19, 1, 0, 1, "pci-gnt3" },
> -	{ 38, 1, 0, 1, "pci-gnt4" },
> -	{ 29, 1, 0, 0, "pci-req1" },
> -	{ 31, 1, 0, 0, "pci-req2" },
> -	{ 3, 1, 0, 0, "pci-req3" },
> -	{ 37, 1, 0, 0, "pci-req4" },
> +	{ 0, 2, 0, "pci-exin0" },
> +	{ 1, 2, 0, "pci-exin1" },
> +	{ 2, 2, 0, "pci-exin2" },
> +	{ 39, 2, 0, "pci-exin3" },
> +	{ 10, 2, 0, "pci-exin4" },
> +	{ 9, 2, 0, "pci-exin5" },
> +	{ 30, 2, 1, "pci-gnt1" },
> +	{ 23, 2, 1, "pci-gnt2" },
> +	{ 19, 2, 1, "pci-gnt3" },
> +	{ 38, 2, 1, "pci-gnt4" },
> +	{ 29, 2, 0, "pci-req1" },
> +	{ 31, 2, 0, "pci-req2" },
> +	{ 3, 2, 0, "pci-req3" },
> +	{ 37, 2, 0, "pci-req4" },

Can you use named initializers here?

	{ .pin = 0, .mux = 2, .dir = 0, .name = "pci_exin0", },
	...

  Ralf
