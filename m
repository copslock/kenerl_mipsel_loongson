Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 15:41:58 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:38495 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492352Ab0FANly (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 15:41:54 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id 720B183871; Tue,  1 Jun 2010 14:41:53 +0100 (BST)
Date:   Tue, 1 Jun 2010 14:41:53 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2] MIPS: Clean up the calculation of
        VMLINUZ_LOAD_ADDRESS
Message-ID: <20100601134153.GK2519@chipmunk>
References: <1275397916-6401-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275397916-6401-1-git-send-email-wuzhangjin@gmail.com>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 26964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 372

Hi,

* Wu Zhangjin <wuzhangjin@gmail.com> [2010-06-01 21:11:56+0800]:
>
> Changes:
> 
> v1 -> v2:
>   o make it more portable (feedback from Alexander Clouter)
>     use EXIT_SUCCESS and EXIT_FAILURE as the return value, and use uint64_t
>     instead of "unsigned long long".
>   o add a missing return value (feedback from Alexander Clouter)
>     return EXIT_FAILURE if (n != 1).
> 
> We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is awful. This patch
> rewrites it in C.
> 
s/awful/indecipherable/

:)

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/boot/.gitignore                          |    1 +
>  arch/mips/boot/compressed/Makefile                 |   22 ++++----
>  arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   55 ++++++++++++++++++++
>  3 files changed, 66 insertions(+), 12 deletions(-)
>  create mode 100644 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> 
> diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> new file mode 100644
> index 0000000..81176b1
> --- /dev/null
> +++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> @@ -0,0 +1,55 @@
>
> [snipped]
>
> +
> +	/* Convert hex characters to dec number */
> +	errno = 0;
> +	n = sscanf(argv[2], "%llx", &vmlinux_load_addr);
> +	if (n != 1) {
>
you can drop the 'n' with:

if (sscanf(argv[2], "%llx", &vmlinux_load_addr) != 1) {

> +		if (errno != 0)
> +			perror("sscanf");
> +		else
> +			fprintf(stderr, "No matching characters\n");
> +
> +		return EXIT_FAILURE;
> +	}
> +
> +	vmlinux_size = (unsigned long long)sb.st_size;
>
I'm guessing this should probably be uint64_t also?

Other than that, makes me happy :)

Cheers

-- 
Alexander Clouter
.sigmonster says: And furthermore, my bowling average is unimpeachable!!!
