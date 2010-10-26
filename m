Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 21:57:21 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:47650 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491057Ab0JZT5R convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Oct 2010 21:57:17 +0200
Received: by ewy19 with SMTP id 19so2530093ewy.36
        for <multiple recipients>; Tue, 26 Oct 2010 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=65E8FGSZUQvu6TBmmNJQGsd6PesN8caAjLL/Cn5qUhs=;
        b=I4B2lPlMi0yFi0/lcPj7bKwjB3E/A1O8m7Pd7JT8JdrWRKt6ycK3tNDQ00XA3dzT40
         hRHtwiH9XY3SgGBPvAzoz21T2V3Zp+7XDEOR/SG9NZ8eQz5BRIYZ5iC+KKa4tznfD630
         0LzdC40RFi5MxL5GVYBX/5pda5zn7T5gRDxjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ODf43sn37fyxetLPbZ0rcTdHtR9p2OHufavcY7lmdooba3LECXW21TN9a1UO/m3m93
         DhxQhkPwR9zT1OyS5ehxnIARVHop7EAPYK6Klr8uVncL0tGQ9ojIHjURkTqz1H+u7eXZ
         3Ndmw3rmVwFVzfgyx8lc0ddkqcb92NxIJNlkM=
MIME-Version: 1.0
Received: by 10.216.59.131 with SMTP id s3mr8091095wec.71.1288123032746; Tue,
 26 Oct 2010 12:57:12 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Tue, 26 Oct 2010 12:57:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010261409190.15889@eddie.linux-mips.org>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
        <4CC49A99.1080601@bitwagon.com>
        <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
        <4CC5B474.9050503@bitwagon.com>
        <alpine.LFD.2.00.1010261409190.15889@eddie.linux-mips.org>
Date:   Wed, 27 Oct 2010 03:57:12 +0800
Message-ID: <AANLkTikRnLefhL0T7f4++qHx8NmXOo4BbjkscKjAW57P@mail.gmail.com>
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
X-archive-position: 28247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2010 at 9:36 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Mon, 25 Oct 2010, John Reiser wrote:
>
>> Here's a second try [discard the first] for handling MIPS64 in recordmcount.[ch].
>
>  Thanks for your contribution -- I appreciate it as undoubtedly do the
> others -- no need to feel frustrated. :)
>
>  Please note that the unusual relocation format comes from the fact the
> MIPS n64 ABI supplement was developed before the ELF64 gABI was finalised
> -- no surprise here given MIPS processors were the first 64-bit around.
> Then the gABI took a more generic approach to handle compound relocations.
> Even `readelf' you cited only got it right as recently as in 2005 (BFD was
> OK from the beginning though AFAIR, so code generated as well as e.g.
> `objdump' reports were right).
>
>  Your change looks good to me overall (I haven't tried building or running
> it -- I take your word you've got it right).  I have a small nit though --
> see below.
>
>> +typedef unsigned char myElf64_byte;
>> +typedef struct {
>> +     Elf64_Addr    r_offset;               /* Address */
>> +     struct {
>> +             Elf64_Word r_sym;
>> +             myElf64_byte r_ssym;  /* Special sym: gp-relative, etc. */
>> +             myElf64_byte r_type3;
>> +             myElf64_byte r_type2;
>> +             myElf64_byte r_type;
>> +     } r_info;
>> +     Elf64_Sxword  r_addend;               /* Addend */
>> +} MIPS64_Rela;
>> +
>> +static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
>> +{
>> +     return w(((MIPS64_Rela const *)rp)->r_info.r_sym);
>> +}
>> +
>> +static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
>> +{
>> +     MIPS64_Rela *const m64rp = (MIPS64_Rela *)rp;
>> +     m64rp->r_info.r_sym = w(sym);
>> +     m64rp->r_info.r_ssym = 0;
>> +     m64rp->r_info.r_type3 = 0;
>> +     m64rp->r_info.r_type2 = 0;
>> +     m64rp->r_info.r_type = type;
>> +}
>
>  Please try and avoid type punning, i.e. use a union to switch between the
> gABI format of r_info and the n64 MIPS psABI variation.  You'll avoid the
> risk of GCC doing weird stuff wrt aliasing.

Hi, Maciej

will this help?

typedef struct {
        Elf64_Addr    r_offset;               /* Address */
        union {
                struct {
                        Elf64_Word r_sym;
                        myElf64_byte r_ssym;  /* Special sym:
gp-relative, etc. */
                        myElf64_byte r_type3;
                        myElf64_byte r_type2;
                        myElf64_byte r_type;
                } r_info;
                Elf64_Xword gABI_r_info;
        };
        Elf64_Sxword  r_addend;               /* Addend */
} MIPS64_Rela;

Regards,
Wu Zhangjin
