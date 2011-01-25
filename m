Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 10:04:05 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:53756 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491152Ab1AYJEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 10:04:02 +0100
Received: by bwz5 with SMTP id 5so139581bwz.36
        for <linux-mips@linux-mips.org>; Tue, 25 Jan 2011 01:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=yvaP5Mcd+/8TpjGBISFH71ty97HGSiyjA0wAu/SzkB8=;
        b=NMQYfR69V1LO+/kIEuDZdxk+G/VLCatI5BXFh59l497+JZT9DWN10VOlBKJGNfnDOy
         b889GlHtarUVqiSMw/shMl3qE4DByOld6ZMof7nQF4Kqhlty1zmDgUDIE7g+ceVIlSFn
         R7njlB76f9ZmVHDnyuZv6g4LJKEpKpEiSSDsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=S1ctcz+Wti47kO22h56RVDtdyFVJ31vnS9lmivlcDQjLf24uwkT+haYrk4bcxiZqej
         3RwD/RrX1HrAR6FxRSCh6RmQ42qH12r5qJW3SOtm/Tid8WXGYUO6D1ugr1d1rOHZ3k+e
         BdsEb4d/xOsbdVKfQxF9S4AHpLniOP1NJ0Sxo=
MIME-Version: 1.0
Received: by 10.204.71.65 with SMTP id g1mr4766570bkj.178.1295946241706; Tue,
 25 Jan 2011 01:04:01 -0800 (PST)
Received: by 10.204.73.213 with HTTP; Tue, 25 Jan 2011 01:04:01 -0800 (PST)
Date:   Tue, 25 Jan 2011 17:04:01 +0800
Message-ID: <AANLkTikSRmSpU+8FXOnqQ8Xm=ms=SZdrj=7WN3SLPVuJ@mail.gmail.com>
Subject: merge two insts into one in a time sensitive routing
From:   Ray Will <hustos@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-mm@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <hustos@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hustos@gmail.com
Precedence: bulk
X-list: linux-mips

The following two lines should be merged into one inst. It is the tlb
refill handler, quite time sensitive.
569         uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
570         uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);

Merged to
 uasm_i_lui(p, tmp, ((PM_HUGE_MASK & 0xffff) | (PM_HUGE_MASK >> 16));


/***********************   arch/mips/mm/tlbex.c    ****************************/
560
561 static __cpuinit void build_huge_tlb_write_entry(u32 **p,
562                                                  struct uasm_label **l,
563                                                  struct uasm_reloc **r,
564                                                  unsigned int tmp,
565                                                  enum tlb_write_entry wmode,
566                                                  int restore_scratch)
567 {
568         /* Set huge page tlb entry size */
569         uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
570         uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
571         uasm_i_mtc0(p, tmp, C0_PAGEMASK);
572
573         build_tlb_write_entry(p, l, r, wmode);
574
575         build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
576 }
577

complete kernel code:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlbex.c;h=083d3412d0bccc7744ec151cd493de614d0375b8;hb=c723fdab8aa728dc2bf0da6a0de8bb9c3f588d84#l1294
