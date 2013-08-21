Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 17:08:57 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:43659 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839461Ab3HUPIxFKNBw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 17:08:53 +0200
Received: by mail-pd0-f178.google.com with SMTP id w10so542030pde.9
        for <multiple recipients>; Wed, 21 Aug 2013 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6nYRBxWm7/IyhO6GRAZe5aDZWF8WXVVoq3QRIgDcnhk=;
        b=Xs5PVM0GpgSc2ONdqTuizEi4saIpAte5w1i5YB282pgeoVnf6caEpAZEyTEpIU3Jb9
         m2YKBk6qVhB3zdfkmdPuTos3AH0f4BkZshh7KrYAhPufEMdQqaxJaIIe9kO8lN5B4HAA
         qLcKlnt54Kub5I3d4dTA/i+C8smXSPCPxHIgm0pCL5QC58jdUs3pDz9HE7dtJvOPbWxR
         rJk2EWgxNVGZsOlXxhXhUQeW1zXb3wVPsKEdfp5wgYDH2orpHxLXQ9kGot3RTsJSKYHs
         Z1pQq17DpEcWv22SpTBY7TZVhrXw6+ivpaWvkFmF1/GBdedmBYKXAH0nL0qOm57ku3uv
         5GIw==
X-Received: by 10.68.219.104 with SMTP id pn8mr209061pbc.81.1377097726368;
 Wed, 21 Aug 2013 08:08:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.41.193 with HTTP; Wed, 21 Aug 2013 08:08:06 -0700 (PDT)
In-Reply-To: <1377096947-3959-1-git-send-email-james.hogan@imgtec.com>
References: <1377096947-3959-1-git-send-email-james.hogan@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed, 21 Aug 2013 16:08:06 +0100
Message-ID: <CAGVrzcZ8FVv9p00R6yDaqRMQARi64P+zVzNRsyeGpiL4UZL3Vg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add uImage build target
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/8/21 James Hogan <james.hogan@imgtec.com>:
> Add a uImage build target for MIPS, which builds uImage.gz (a U-Boot
> image of vmlinux.bin.gz), and then symlinks it to uImage. This allows
> for the use of other compression algorithms in future, and is how a few
> other architectures do it.
>
> The load address and entry address are calculated from the address of
> the _text and kernel_entry symbols, by running nm on the main vmlinux
> (based on arch/mips/lasat/image/Makefile).
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/Makefile        |  3 ++-
>  arch/mips/boot/.gitignore |  1 +
>  arch/mips/boot/Makefile   | 15 +++++++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index b2be6b8..c4f339e 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -284,7 +284,7 @@ vmlinux.64: vmlinux
>  all:   $(all-y)
>
>  # boot
> -vmlinux.bin vmlinux.ecoff vmlinux.srec: $(vmlinux-32) FORCE
> +vmlinux.bin vmlinux.ecoff vmlinux.srec uImage: $(vmlinux-32) FORCE
>         $(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
>
>  # boot/compressed
> @@ -327,6 +327,7 @@ define archhelp
>         echo '  vmlinuz.ecoff        - ECOFF zboot image'
>         echo '  vmlinuz.bin          - Raw binary zboot image'
>         echo '  vmlinuz.srec         - SREC zboot image'
> +       echo '  uImage               - U-Boot image (gzip)'

This is not quite accurate, since you introduce two new uImage
targets, this should be:

+       echo '  uImage               - U-Boot image'
+       echo '  uImage.gz               - U-Boot image (gzip)'

>         echo
>         echo '  These will be default as appropriate for a configured platform.'
>  endef
> diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
> index f210b09..a73d6e2 100644
> --- a/arch/mips/boot/.gitignore
> +++ b/arch/mips/boot/.gitignore
> @@ -4,3 +4,4 @@ vmlinux.*
>  zImage
>  zImage.tmp
>  calc_vmlinuz_load_addr
> +uImage
> diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
> index 851261e..8169d42 100644
> --- a/arch/mips/boot/Makefile
> +++ b/arch/mips/boot/Makefile
> @@ -40,3 +40,18 @@ quiet_cmd_srec = OBJCOPY $@
>        cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $@
>  $(obj)/vmlinux.srec: $(VMLINUX) FORCE
>         $(call if_changed,srec)
> +
> +UIMAGE_LOADADDR  = $(shell $(NM) $(VMLINUX) | grep "\b_text\b"        | cut -f1 -d\ )

Is not VMLINUX_LOAD_ADDRESS suitable here?

> +UIMAGE_ENTRYADDR = $(shell $(NM) $(VMLINUX) | grep '\bkernel_entry\b' | cut -f1 -d\ )

This logic already exists in arch/mips/boot/compressed/Makefile, so we
might want to move this to arch/mips/Makefile? This could be a
preliminary or subsequent patch, your call.

> +
> +$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> +       $(call if_changed,gzip)
> +
> +targets += uImage.gz
> +$(obj)/uImage.gz: $(obj)/vmlinux.bin.gz FORCE
> +       $(call if_changed,uimage,gzip)
> +
> +targets += uImage
> +$(obj)/uImage: $(obj)/uImage.gz FORCE
> +       @ln -sf $(notdir $<) $@
> +       @echo '  Image $@ is ready'
> --
> 1.8.1.2
>
>
>



-- 
Florian
