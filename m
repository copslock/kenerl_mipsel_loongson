Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2011 06:08:02 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:56291 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491052Ab1DCEHz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2011 06:07:55 +0200
Received: by vxd2 with SMTP id 2so4273063vxd.36
        for <linux-mips@linux-mips.org>; Sat, 02 Apr 2011 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0vxJpsTYKCrKY3P20n5PBRylD7LwDdEbclzfqkuP9MM=;
        b=eJ9bpV6lCu1v/anBWv1zIxh5BPBmy3nb0OyS7FQ9cTN+oig8UEOFwJ2iR0f/x+zmwU
         6hHeJG9lC1eyik0AGcr0DNNV6ZGRXV/KLA2xueTuSfkjpoPVJZPXal2LLPHkNIVcw8YV
         bDPxKtn0aNCSD/8PYvTyqc/RyB6UJSbdl7pSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nWNo99S59/JbZMLJA9HxTTV9rI4F+4Ii2esQp6n52vfwYW6iG2XbqcbaNVvytrL4me
         Fv5PSLd5e+X6TKoBUi1PnzPTiCMLlpiH0GocCmwNLvo1mfawQvObCKeqqZ/tmObHbj0r
         7GpVerYWqAPQdSP40U0yLkZCEotAhXwbrH/P0=
MIME-Version: 1.0
Received: by 10.52.0.9 with SMTP id 9mr6869425vda.278.1301803669930; Sat, 02
 Apr 2011 21:07:49 -0700 (PDT)
Received: by 10.52.161.169 with HTTP; Sat, 2 Apr 2011 21:07:49 -0700 (PDT)
In-Reply-To: <BANLkTikpqk-UcFHHD6MGyZgv6LociaETtg@mail.gmail.com>
References: <BANLkTikpqk-UcFHHD6MGyZgv6LociaETtg@mail.gmail.com>
Date:   Sun, 3 Apr 2011 12:07:49 +0800
Message-ID: <BANLkTinnVL04HM0TNMEgsZdKO01mKk2-Dw@mail.gmail.com>
Subject: Re: System suffers frequent TLB miss
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

We record our 6 tlb missing  count in do_page_fault, because we don't
have page table mapping for these tlb entris,each time tlb miss

accured, tlb refilling handler would cause a page_fault
