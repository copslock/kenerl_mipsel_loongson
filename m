Return-Path: <SRS0=VxEc=R4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B04C10F03
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 22:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EF02082F
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 22:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GiML85P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCYWgl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:36:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39031 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbfCYWgl (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 25 Mar 2019 18:36:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so9653397otb.6
        for <linux-mips@vger.kernel.org>; Mon, 25 Mar 2019 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTcPY30C0OSYzeNRaa/EPMGmie/8U7JXyLn50zJf1Pw=;
        b=GiML85P6LCslgtDlslKCCUhWvbv1y+nvEc56Q0X8Qjel5DMzDzfar6+H7s6fmu2h3d
         dLEyyqXH0XMmCTgsIn3yhKqlcM+JBYc0UTK5/fEknfFXNcWh7vZB4qk8YZDtnv5IAp1l
         JJmvxmcMseSRffwnab8HmvfayPrxqWL01+eSLrgeJSA/9velnAvwDxgjJF0ugNsd/ZFW
         LpEP4qbgPu6yg3gM3ufLilvbIHnGxS7z2m60QKWTsLURCVB/tyWdotVRQdzsF7WEone8
         YAzkam1P/6bRoe78GssUpwMMiqKYpvFyZCQg0hkxWxLA+GhGDSF3+u1c5KgRvgkutwHN
         +uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTcPY30C0OSYzeNRaa/EPMGmie/8U7JXyLn50zJf1Pw=;
        b=nfakao1jEmer0MqePI5JFtkJd6BEm1rV65U2tDzO5SLny2yBa4cy1QFLDKannd8N9Z
         FRhAeU8P/6KXbejxRi07JY7Rnl3gPAIUyVoEPppZkn1w5/l/fMUx43+qc1JxuAA8L5uY
         PO+P5r3kBfWaOdZcwxewOkH3AxBJJs4EDlOfe89GyG6y4OJHVsp8G6RaQ0GwodqXvWDP
         NJD+2ytin4C7Hy4cLrIGOT4MPiKGKa53r3WOBuXaCsAQR54ccsUSHzAohD5gteDHcO1K
         lhjE/v9NME0g3huSDB0RGpj9aiV14ykm8tG4JEYyRc7tyZBX3Mv8mkpJe2ZH1BhXfe2P
         yltQ==
X-Gm-Message-State: APjAAAWICE7ZSmlqk9bSZdP3oHjcLIyKGhkfUGG9iDDHtu/FYJLD7Fo9
        uXYf2oIFD6IUMymQOu5DKcaPLBeb8mFwwfPa3sKbLg==
X-Google-Smtp-Source: APXvYqxFqrAkIeS5L2WYBPBcjU2Ckw+9rPMAalcwIDZdE3acnVShZDDWo5M3SQr2UUBKcI362os2eQY4GbHhvkhCzss=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr20655282ota.214.1553553400410;
 Mon, 25 Mar 2019 15:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com> <20190325164713.GC9949@ziepe.ca>
 <20190325092314.GF16366@iweiny-DESK2.sc.intel.com> <20190325175150.GA21008@ziepe.ca>
 <20190325142125.GH16366@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190325142125.GH16366@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 15:36:28 -0700
Message-ID: <CAPcyv4hG8WDhsWinXHYkReHKS6gdQ3gAHMcfVWvuP4c4SYBzXQ@mail.gmail.com>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Mar 25, 2019 at 3:22 PM Ira Weiny <ira.weiny@intel.com> wrote:
[..]
> FWIW this thread is making me think my original patch which simply implemented
> get_user_pages_fast_longterm() would be more clear.  There is some evidence
> that the GUP API was trending that way (see get_user_pages_remote).  That seems
> wrong but I don't know how to ensure users don't specify the wrong flag.

What about just making the existing get_user_pages_longterm() have a
fast path option?
