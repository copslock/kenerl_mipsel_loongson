Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2009 22:59:18 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.152]:18493 "EHLO
	yw-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024627AbZEKV7L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2009 22:59:11 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1766429ywk.24
        for <multiple recipients>; Mon, 11 May 2009 14:59:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=TFdVvfCQIs443syIbsu3rs9iVeegp89KrPnF7+B7XII=;
        b=GHJsYY+oskiMKyXbwpFt+Vuw3iCi5fBd61xrzr7GTd0PcF/h3K/1NFhfSl0nlpaG7I
         il95djANruj+ecUKCRfjz/EO1KE9eyMEG+askFnCZ7u3XGFPJYstndHLUtE2YG/3LwSl
         KQpoq/DqJ/uKTw+Hs/M09aRv5VG4J4ty8TF1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=rP/CB66EMJP100H2O8gVnwrCuz43BSdI163ECpxEj8WWW9kvMha/DSahwf1MoHpyO7
         sD30x6VDn1juQ5UByXajwwS2w+A3ehRJPFfILX2jCMn9MDicKoBB7FJwcqZI0sgMvCO/
         6cF+eKTqo8+sOGA8vn9SyOuP38jJYpY8LO5JY=
MIME-Version: 1.0
Received: by 10.100.32.6 with SMTP id f6mr18134058anf.143.1242079149235; Mon, 
	11 May 2009 14:59:09 -0700 (PDT)
In-Reply-To: <1242069062-20991-1-git-send-email-ddaney@caviumnetworks.com>
References: <1242069062-20991-1-git-send-email-ddaney@caviumnetworks.com>
Date:	Mon, 11 May 2009 17:59:07 -0400
X-Google-Sender-Auth: 32eb67d8c4e4b2ab
Message-ID: <7d1d9c250905111459p42ce2671n91625e6f62cb2d75@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove execution hazard barriers for Octeon.
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

On Mon, May 11, 2009 at 3:11 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> The Octeon has no execution hazards, so we can remove them and save an
> instruction per TLB handler invocation.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/mm/tlbex.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 3548acf..4b2ea1f 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -257,7 +257,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
>        case tlb_indexed: tlbw = uasm_i_tlbwi; break;
>        }
>
> -       if (cpu_has_mips_r2) {
> +       if (cpu_has_mips_r2 && current_cpu_type() != CPU_CAVIUM_OCTEON) {

Assuming that it is feasible that some other future cores might also be
free of execution hazards, wouldn't it be better to do:

  if (cpu_has_mips_r2 && cpu_has_exec_hazard) {

and then hide the CPU type listing (currently just one) in some header file?

Paul.

>                uasm_i_ehb(p);
>                tlbw(p);
>                return;
> --
> 1.6.0.6
>
>
>
