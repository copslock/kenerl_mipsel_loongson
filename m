Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2010 20:53:49 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:47985 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490963Ab0JWSxo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Oct 2010 20:53:44 +0200
Received: by wwb39 with SMTP id 39so1385694wwb.24
        for <multiple recipients>; Sat, 23 Oct 2010 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=31izDBaYZx8TMwNz9RtmyWzgaqZk/HCg6iOdog4hukA=;
        b=kqKRD/ggu2P4qntThDrl8J+LeaJ4Vy/JxQ+nGDzoNVvkvnKiusw5mqop2H5GwW1/0G
         3+D55LLUqcYxAvFsitxevqui2APIIw1wuKaGv3b+qUnmDKWGyIsLXqhTrPWhsSvKN31X
         MPlLs9fxRRiv3VOLHJmewM35lh7EimnfMTinc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=T+/dVE65YTVC/aHawTepfuYiA/cSqYIz6FoPR/YWcKdrey8Mcis4wvJOxjedD0emqj
         ZPhEDpQmL3xj3Cr2R50xcmHcVqckhbG2VRSKXt+Qgp6bW9QBs2ePuwlI3zzIVkDt5EFw
         oXZQBP8JF/a4cMc3qNHaDs6pEqyCOomu6oLh0=
MIME-Version: 1.0
Received: by 10.216.29.197 with SMTP id i47mr974596wea.27.1287860018023; Sat,
 23 Oct 2010 11:53:38 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Sat, 23 Oct 2010 11:53:37 -0700 (PDT)
Date:   Sun, 24 Oct 2010 02:53:37 +0800
Message-ID: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
Subject: Re: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, "John F. Reiser" <jreiser@BitWagon.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

(Add John F. Reiser in this loop)

On 10/23/10, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 2010-10-22 at 14:10 -0700, David Daney wrote:
>> On 10/22/2010 01:58 PM, Wu Zhangjin wrote:
>> > From: Wu Zhangjin<wuzhangjin@gmail.com>
>> >
>> > In some situations(with related kernel config and gcc options), the
>> > modules may have the same address space as the core kernel space, so
>> > mcount_regex for modules should also match R_MIPS_26.
>> >
>>
>> I think Steve is rewriting this bit to be a pure C program.  Is this
>> file even used anymore?  If so for how long?
>
> It's already in mainline, but is only supported for x86 for now. Until
> we verify that it works for other archs (which is up to you guys to
> verify) the script will still be used.
>
> Also, I did not write it, John Reiser did. I just cleaned it up a bit
> and got it working with the build system.

Just applied this tmp patch to try the basic function.

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ce8af84..3bf1c0c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
        select HAVE_FUNCTION_TRACE_MCOUNT_TEST
        select HAVE_DYNAMIC_FTRACE
        select HAVE_FTRACE_MCOUNT_RECORD
+       select HAVE_C_RECORDMCOUNT
        select HAVE_FUNCTION_GRAPH_TRACER
        select HAVE_KPROBES
        select HAVE_KRETPROBES
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 26e1271..0fb200f 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -270,6 +270,7 @@ do_file(char const *const fname)
        case EM_IA_64:   reltype = R_IA64_IMM64;   gpfx = '_'; break;
        case EM_PPC:     reltype = R_PPC_ADDR32;   gpfx = '_'; break;
        case EM_PPC64:   reltype = R_PPC64_ADDR64; gpfx = '_'; break;
+       case EM_MIPS:    reltype = R_MIPS_26;      gpfx = '_'; break;
        case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
        case EM_SH:      reltype = R_SH_DIR32;                 break;
        case EM_SPARCV9: reltype = R_SPARC_64;     gpfx = '_'; break;

(Note: The above patch is not enough, for the modules with
-mlong-calls, the reltype should be R_MIPS_HI16, and we may also need
to add our specific code for sift_rel_mcount() to get the right
location of the _mcount calling site)

but failed with the following error:

$ make ARCH=mips CROSS_COMPILE=mips64el-unknown-linux-gnu-
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
scripts/basic/docproc.c: In function ‘docsect’:
scripts/basic/docproc.c:336: warning: ignoring return value of
‘asprintf’, declared with attribute warn_unused_result
  Checking missing-syscalls for N32
  CALL    scripts/checksyscalls.sh
  Checking missing-syscalls for O32
  CALL    scripts/checksyscalls.sh
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/mips/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  HOSTCC  scripts/recordmcount
  CC      init/main.o
/bin/sh: line 1: 21835 Segmentation fault     scripts/recordmcount "init/main.o"
make[1]: *** [init/main.o] Error 139
make: *** [init] Error 2

I traced the problem and found it was triggered by the 201 line of
scripts/recordmcount.h:

198                 if (!mcountsym) {
199                         Elf_Sym const *const symp =
200                                 &sym0[ELF_R_SYM(_w(relp->r_info))];
*201                         char const *symname = &str0[w(symp->st_name)];*
202
203                         if ('.' == symname[0])
204                                 ++symname;  /* ppc64 hack */

Exactly, it was triggered by: symp->st_name, symp is normal address,
i.e. 0xa01831f0, but perhaps the content pointed by this address may
not exist or is not allocated before?

Did I miss something for MIPS specific support?

By the way, because MIPS need to cope with its modules
particularly(differ from the module):

for kernel:

    #     10:   03e0082d        move    at,ra
    #     14:   0c000000        jal     0
    #                    14: R_MIPS_26   _mcount           --> we
record this for MIPS kernel
    #                    14: R_MIPS_NONE *ABS*
    #                    14: R_MIPS_NONE *ABS*
    #    18:   00020021        nop


for module:

    #       c:  3c030000        lui     v1,0x0
    #                   c: R_MIPS_HI16  _mcount         --> we record
this for MIPS module
    #                   c: R_MIPS_NONE  *ABS*
    #                   c: R_MIPS_NONE  *ABS*
    #      10:  64630000        daddiu  v1,v1,0
    #                   10: R_MIPS_LO16 _mcount
    #                   10: R_MIPS_NONE *ABS*
    #                   10: R_MIPS_NONE *ABS*
    #      14:  03e0082d        move    at,ra
    #      18:  0060f809        jalr    v1
    #                     label:

But I found there was only one argument: /path/to/file.o passed to
scripts/recordmount:

scripts/Makefile.build

217 cmd_record_mcount = if [ $(@) != "scripts/mod/empty.o" ]; then
             \
218                         $(objtree)/scripts/recordmcount "$(@)";
             \
219                     fi;
220 else

So, should we pass "$(if $(part-of-module),1,0)" to the C version of
recordmcount?

Regards,
Wu Zhangjin
