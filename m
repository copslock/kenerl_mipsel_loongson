Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 11:54:57 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41162 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491082Ab0J0Jyx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Oct 2010 11:54:53 +0200
Received: by wyf22 with SMTP id 22so481889wyf.36
        for <multiple recipients>; Wed, 27 Oct 2010 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dcLDOxX528grIb90eS0h8Z44zOAcWDQAEJW6y+8erno=;
        b=qxNv6HsSnMx1NfXH2zjbK2lDhqFhF9mqEnllHCaQhdFqf2UNUUy50Ad19kKG5zHc2C
         Xz+CmgLyCOfSTdCKCERl/v6HsSkEnh2jsv4fwDQ6MwW0dDJ1TM8g6jWCRHWP1rEWsZL4
         zZy//RbqNV9VtMCl8en31WZSfWFB8b7wgPpnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OiTbvMB2Eb0e3UZBSqd9BC8ASMMoMYgM1NViJTjYUEoq6uFA/5bBEllZaKczF5JJoi
         aZBCgn6C6eNlhP6UxWqQJSUOe46curUt38jrRsmse0rJPr6oErSneIXbCpG8ZwQxgcL/
         nh/jchH4vx3iRbFMWJaIPTZRzBJoyauEM+VC0=
MIME-Version: 1.0
Received: by 10.216.165.77 with SMTP id d55mr3093189wel.23.1288173287614; Wed,
 27 Oct 2010 02:54:47 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Wed, 27 Oct 2010 02:54:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010270948260.15889@eddie.linux-mips.org>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
        <4CC49A99.1080601@bitwagon.com>
        <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
        <4CC5B474.9050503@bitwagon.com>
        <alpine.LFD.2.00.1010261409190.15889@eddie.linux-mips.org>
        <AANLkTikRnLefhL0T7f4++qHx8NmXOo4BbjkscKjAW57P@mail.gmail.com>
        <alpine.LFD.2.00.1010270948260.15889@eddie.linux-mips.org>
Date:   Wed, 27 Oct 2010 17:54:47 +0800
Message-ID: <AANLkTi=aPT1J8eY1UV7TtgicpYPwLt13rP1BdHhYGpyQ@mail.gmail.com>
Subject: Re: patch v2: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     John Reiser <jreiser@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 27, 2010 at 5:31 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Wed, 27 Oct 2010, wu zhangjin wrote:
>
>> will this help?
>>
>> typedef struct {
>>         Elf64_Addr    r_offset;               /* Address */
>>         union {
>>                 struct {
>>                         Elf64_Word r_sym;
>>                         myElf64_byte r_ssym;  /* Special sym:
>> gp-relative, etc. */
>>                         myElf64_byte r_type3;
>>                         myElf64_byte r_type2;
>>                         myElf64_byte r_type;
>>                 } r_info;
>>                 Elf64_Xword gABI_r_info;
>>         };
>>         Elf64_Sxword  r_addend;               /* Addend */
>> } MIPS64_Rela;
>
>  More or less, although you need to give your union a name to access its
> members. ;)  It may be simpler to refer to r_info only, e.g. something
> along these lines:

Yeah, I like it ;) In reality, In my local copy, I have tried to use
MIPS64_Rel instead of MIPS64_Rela, but you did more, so, I will use
your method before sending the patchset out.

Thanks & Regards,
Wu Zhangjin

>
> typedef uint8_t myElf64_Byte;
> union mips_r_info {
>        Elf64_Xword r_info;
>        struct {
>                Elf64_Word r_sym;
>                myElf64_Byte r_ssym;
>                myElf64_Byte r_type3;
>                myElf64_Byte r_type2;
>                myElf64_Byte r_type;
>        } r_mips;
> };
>
> static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
> {
>        return w(((union mips_r_info){ .r_info = rp->r_info }).r_mips.r_sym);
> }
>
> static void MIPS64_r_info(Elf64_Rel *const rp,
>                          unsigned int sym, unsigned int type)
> {
>        rp->r_info = ((union mips_r_info){
>                .r_mips = { .r_sym = w(sym), .r_type = type }
>        }).r_info;
> }
>
> Untested, but GCC 4.1.2 seems to turn it into decent big-endian code:
>
> tmp.o:     file format elf64-tradbigmips
>
> Disassembly of section .text:
>
> 0000000000000000 <MIPS64_r_sym>:
>   0:   03e00008        jr      ra
>   4:   9c820008        lwu     v0,8(a0)
>
> 0000000000000008 <MIPS64_r_info>:
>   8:   30c600ff        andi    a2,a2,0xff
>   c:   0005283c        dsll32  a1,a1,0x0
>  10:   00a62825        or      a1,a1,a2
>  14:   03e00008        jr      ra
>  18:   fc850008        sd      a1,8(a0)
>
> and not so decent little-endian code (too many shifts):
>
> tmpel.o:     file format elf64-tradlittlemips
>
> Disassembly of section .text:
>
> 0000000000000000 <MIPS64_r_sym>:
>   0:   dc820008        ld      v0,8(a0)
>   4:   00021000        sll     v0,v0,0x0
>   8:   0002103c        dsll32  v0,v0,0x0
>   c:   03e00008        jr      ra
>  10:   0002103e        dsrl32  v0,v0,0x0
>
> 0000000000000018 <MIPS64_r_info>:
>  18:   0005283c        dsll32  a1,a1,0x0
>  1c:   0006363c        dsll32  a2,a2,0x18
>  20:   0005283e        dsrl32  a1,a1,0x0
>  24:   00a62825        or      a1,a1,a2
>  28:   03e00008        jr      ra
>  2c:   fc850008        sd      a1,8(a0)
>
> GCC may have been fixed/improved since though (I'd expect so, but didn't
> have the resources to upgrade yet, so check yourself).
>
>  Here's my sign-off mark if you'd like to use the code above.
>
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
>
>  Maciej
>
