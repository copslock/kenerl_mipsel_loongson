Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2011 13:36:22 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:45877 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491026Ab1JQLgS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2011 13:36:18 +0200
Received: by ywe9 with SMTP id 9so715862ywe.36
        for <linux-mips@linux-mips.org>; Mon, 17 Oct 2011 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=8EllmUJZFEhOAi8ogaDX0Glc68u8lyvhglXzNYaR8CQ=;
        b=xvKb0x/aBHXFvFcDgRzTDMMNLlVQlWBQSTqldgq3JvBIKIOi+pN1tEZ+EFbwimriYw
         t5FVK6f4hZ+o3/8adCra7SBroK2yihU3j8o6y9j3W075lUmjI9f8eDIXKv933f2P4YvM
         eVQ8883XEezmGucHByGxMB0T/aVeFXsdhfdXA=
MIME-Version: 1.0
Received: by 10.42.154.7 with SMTP id o7mr37821821icw.48.1318851371675; Mon,
 17 Oct 2011 04:36:11 -0700 (PDT)
Received: by 10.42.170.1 with HTTP; Mon, 17 Oct 2011 04:36:11 -0700 (PDT)
Date:   Mon, 17 Oct 2011 19:36:11 +0800
Message-ID: <CANudz+sswjeOP-JZfJnp5c+J0HAmY2OgCVJkdq9WK51ackb8vw@mail.gmail.com>
Subject: some questions about translation lookaside buffer
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11767

Dear all:
I have some questions about local_flush_tlb_one.
1. what will happen if I use local_flush_tlb_one to flush a page that
doesn't exist in translation lookaside buffer entries.

The index return by read_c0_index(), should be negative.
but this function seems not handle the case that idx < 0.

2. as I know, translation lookaside buffer is a place to keep record
the memory mapping, it doesn't like cache have place to store the
data.
    a. If the entry is cacheable, what we only to do is flush the cache?
    b. if the entry is uncached, there is nothing to do?
if above b is correct, what will happen if we have an entry that is
uncached and dirty?


-- 
Regards,
