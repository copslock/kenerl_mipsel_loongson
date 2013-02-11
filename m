Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Feb 2013 20:00:47 +0100 (CET)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33708 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827591Ab3BKTAqyJp0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Feb 2013 20:00:46 +0100
Received: by mail-ie0-f173.google.com with SMTP id 9so8111905iec.4
        for <linux-mips@linux-mips.org>; Mon, 11 Feb 2013 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lGcg6h7LfQp/SWaLLJcAMAL6YyoeAxY48Zc1GXXVlSw=;
        b=UyOTGHgPLGDGjYsOgHx7GHV2tfDNh1mRZ7eb9/bezFIqmF3Vvd8UN1L5YxDgHSdhF8
         NN0/Khc3xKA1VYPW7uiCQwS1z251GZBdPcF0XnIHJquwvjc8Xqt6AclpxFlzKz1j9h/x
         k22xw0QMJ3GbwbGA9OP/ESk5MvDY6XKlnctwoyyjnTnw2uS0L5Krw3lH8vOQEqn3tZQt
         ++OyXZQiJUvnuVsbn8sL03VQX9AdH/Dh5q9CocJFQ76ofqTCmFnx43U92Dl9YorABJfM
         vZILoulyWaPhUcH3LY3pF9kx220cSoeckUjgtSKiKXBGfuHMWLyfv5Zd1J7sqMt4I2FA
         DThA==
X-Received: by 10.43.111.201 with SMTP id ep9mr8206375icc.43.1360609240130;
 Mon, 11 Feb 2013 11:00:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.42.85.83 with HTTP; Mon, 11 Feb 2013 11:00:20 -0800 (PST)
In-Reply-To: <CAMJ=MEdryShKJD9v5Xp3ZouPzss_TK+QjVZ=Nng3cvDGfAiYzA@mail.gmail.com>
References: <CAMJ=MEdryShKJD9v5Xp3ZouPzss_TK+QjVZ=Nng3cvDGfAiYzA@mail.gmail.com>
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Mon, 11 Feb 2013 20:00:20 +0100
Message-ID: <CAMJ=MEdT+mpNmOWFtT4bKEiyib+hhRxbOgS5aS9OmEewoGxAUg@mail.gmail.com>
Subject: Re: Reserving a part of the system ram.
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ronny.meeus@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Feb 9, 2013 at 2:23 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
> Hello
>
> I have a board that has 4Gb of RAM which can completely be used by
> Linux, except for a 64Mb block located just below the 2G boundary.
> This block will be used to implement a kind of persistent storage.
>
> On PPC we do this with a memreserve in the device tree but this does
> not seem to work on MIPS.
> Another option I found is the memmap kernel parameter, which  can also
> be used the reserve a piece of memory that is reserved (something like
> memmap=size$addres would do the trick, but no luck, this is also not
> supported.
>
> This is the Linux version I'm using for my project:
> Linux version 2.6.32.27-Cavium-Octeon
>
> What is the correct way to make this work?
>
> Thanks,
> Ronny


Hello

I had a look to the code over the weekend and I was able to
understand how it works.
Today I changed the code and it looks like it works. The change I have
made can be found in the patch below.

The clue is that the complete memory of the Cavium board is
managed/known by uboot.
It creates a bootmemory structure that is used by Linux to configure
its memory during init.

It basically allocates blocks of 4MB from this bootmem until the size
specified in the mem parameter is reached.
If 0 is passed to the mem command line parameter, it allocates all
available memory.

Uboot knows already about the memreserves done in the device tree so
the only thing
that was missing is to allocate the memory specified in the
memreserves from the bootmemory.
Once this was done, Linux does not touch the memreserved memory anymore.

The patch below is not a Linux patch, but a uboot one.
Is this way of working a standard solution or is it dedicated to Mips or Cavium?

Regards,
Ronny

diff --git a/arch/mips/cpu/octeon/commands/cmd_octeon_linux.c
b/arch/mips/cpu/octeon/commands/cmd_octeon_linux.c
--- a/arch/mips/cpu/octeon/commands/cmd_octeon_linux.c
+++ b/arch/mips/cpu/octeon/commands/cmd_octeon_linux.c
@@ -189,6 +189,8 @@ int do_bootoctlinux(cmd_tbl_t * cmdtp, i
         */
        cvmx_bootmem_phy_named_block_free(OCTEON_LINUX_RESERVED_MEM_NAME, 0);

+       octeon_alloc_memreserves_from_bootmem();
+
        if (((Elf32_Ehdr *)addr)->e_ident[EI_CLASS] == ELFCLASS32) {
                if (alloc_elf32_image(addr)) {
                        entry_addr = load_elf_image(addr);
diff --git a/arch/mips/cpu/octeon/octeon_fdt.c
b/arch/mips/cpu/octeon/octeon_fdt.c
--- a/arch/mips/cpu/octeon/octeon_fdt.c
+++ b/arch/mips/cpu/octeon/octeon_fdt.c
@@ -344,3 +344,30 @@ int __board_fixup_fdt(void)
 }
 int board_fixup_fdt(void)
        __attribute__((weak, alias("__board_fixup_fdt")));
+
+
+void octeon_alloc_memreserves_from_bootmem(void)
+{
+       uint64_t addr, size;
+       int j, err;
+       char name[32];
+       int total = fdt_num_mem_rsv(working_fdt);
+       for (j = 0; j < total; j++) {
+               int64_t mem = 0;
+               err = fdt_get_mem_rsv(working_fdt, j, &addr, &size);
+               if (err < 0) {
+                       printf("libfdt fdt_get_mem_rsv():  %s\n",
+                       fdt_strerror(err));
+                       return err;
+               }
+               sprintf(name,"fdt_memreserve%d",j);
+               printf("alloc_bootmem %16s %08x%08x %08x%08x\n",name,
+                       (u32)(addr >> 32),(u32)(addr & 0xffffffff),
+                       (u32)(size >> 32),(u32)(size & 0xffffffff));
+               mem =
cvmx_bootmem_phy_named_block_alloc(size,addr,addr+size,0,name,0);
+               if (mem < 0) {
+                       printf("Named allocation failed!\n");
+               }
+       }
+}
+
diff --git a/arch/mips/include/asm/arch-octeon/octeon_fdt.h
b/arch/mips/include/asm/arch-octeon/octeon_fdt.h
--- a/arch/mips/include/asm/arch-octeon/octeon_fdt.h
+++ b/arch/mips/include/asm/arch-octeon/octeon_fdt.h
@@ -77,5 +77,6 @@
 int octeon_fdt_patch(void *fdt, const char *fdt_key, const char *trim_name);
 int board_fixup_fdt(void);
 void octeon_fixup_fdt(void);
+void octeon_alloc_memreserves_from_bootmem(void);

-#endif /* __OCTEON_FDT_H__ */
\ No newline at end of file
+#endif /* __OCTEON_FDT_H__ */
