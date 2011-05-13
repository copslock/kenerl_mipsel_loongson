Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:46:31 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56447 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1EMPqZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 17:46:25 +0200
Received: by pzk28 with SMTP id 28so1454294pzk.36
        for <multiple recipients>; Fri, 13 May 2011 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SoOKpt0w6kkAuvV+6JvKMvwIvr54bGp+UEi80cL2euU=;
        b=Uvjsub9UPyWnvde5lODxceCbKwHFYh8yxj/uWJzLyOIY0MKNAwGtrPFBPX3iV9eunU
         uQ+LTQKM6kZaOPoU4QAV5Lb4lzamCg6n04Gc8xoY+aC0Gwxcl1iU24qORGXp+UapYTuN
         I2XwZDx3BK3rc/iKe7UR9zY2ZC4q66NBFVzXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XSLUrMrhhgBRdAW05+OgP/C8dHCmQ6vTnYWGJMUzk5FV1XpqCVvZPzLvKyaXyCWPjc
         opSCjpwShnD4QY6mVGJKOnv9SypiZlPylwLIp0p6XBwcoG9XcU1xN00HqQoxJX5xEivd
         mrgSwLLe+E6e4pIi7Pl2H2r++rD8wXWedPalM=
MIME-Version: 1.0
Received: by 10.68.57.168 with SMTP id j8mr2442170pbq.111.1305301578289; Fri,
 13 May 2011 08:46:18 -0700 (PDT)
Received: by 10.68.51.72 with HTTP; Fri, 13 May 2011 08:46:18 -0700 (PDT)
In-Reply-To: <20110513150707.GA26389@linux-mips.org>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
        <20110513150707.GA26389@linux-mips.org>
Date:   Fri, 13 May 2011 08:46:18 -0700
Message-ID: <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 8:07 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> Reuse more of the same definitions for the non-RIXI and RIXI cases.  This
>> avoids having special cases for kernel_uses_smartmips_rixi cluttering up
>> the pgtable*.h files.
>>
>> On hardware that does not support RI/XI, EntryLo bits 31:30 / 63:62 will
>> remain unset and RI/XI permissions will not be enforced.
>
> Nice idea but it breaks on 64-bit hardware running 32-bit kernels.  On
> those the RI/XI bits written to c0_entrylo0/1 31:30 will be interpreted as
> physical address bits 37:36.

Hmm, are you sure?  (Unfortunately I do not have a 64-bit machine to
test it on.)

I did not touch David's existing build_update_entries(), which makes a
point not to set the RI/XI bits when the RIXI feature is disabled:

        if (kernel_uses_smartmips_rixi) {
                UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
                UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
                UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) -
ilog2(_PAGE_NO_EXEC));
                if (r4k_250MHZhwbug())
                        UASM_i_MTC0(p, 0, C0_ENTRYLO0);
                UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
                UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) -
ilog2(_PAGE_NO_EXEC));
        } else {
                UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /*
convert to entrylo0 */
                if (r4k_250MHZhwbug())
                        UASM_i_MTC0(p, 0, C0_ENTRYLO0);
                UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
                UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /*
convert to entrylo1 */
                if (r45k_bvahwbug())
                        uasm_i_mfc0(p, tmp, C0_INDEX);
        }

If RIXI is enabled, it shifts the SW bits off the end of the register,
then rotates the RI/XI bits into place.

If RIXI is disabled, it shifts the SW bits + RI/XI bits off the end of
the register.  It should not be setting bits 31:30 or 63:62, ever.

(A side issue here is that ROTR is a MIPS R2 instruction, so we could
never remove the old handler and use the RIXI version of the TLB
handler on an R1 machine.)

If setting EntryLo bits 31:30 for RI/XI is illegal on a 64-bit system
running a 32-bit kernel, I suspect we will have a problem with the
existing RIXI TLB update code, regardless of whether my changes are
applied.
