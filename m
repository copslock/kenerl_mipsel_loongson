Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 17:51:42 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:36151 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab0JQPvi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 17:51:38 +0200
Received: by qyk35 with SMTP id 35so3394176qyk.15
        for <linux-mips@linux-mips.org>; Sun, 17 Oct 2010 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=aKJ7ObxQodqQMqHPBcXwLrSlLuuekRC0+FJokiqMprY=;
        b=j7/Kvzu808pcGC25+5amXHOw2dkrs2hROPDoZfO3lhu1lN5rEdlBNx4ygSoPnwL5ut
         WMKdRU1CQw8acqs2J5qRqAqO2riUIttwCR+A0wdvZfPvnp7qtuMFQioEry7JSltwvvmm
         66sW8YG3h4fvZkBuy4KKl0y+r1jRyzRzxO7lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=DeVo/lkKKC2bUU1CPeKOm2CU7JN1IZMn7MBmpfEYcYAB/BAAu08+nRrjR7AFoLzAxn
         hTTNGH+6Tl5ph80BF8mdoxHZDjFdf6StyF36nHESQOGC/1eccb40Hl1BSw/ONUcB/0Hx
         JYOJfpVmeiazITBDgG4SIXO12Vm0hkCHRh5rs=
MIME-Version: 1.0
Received: by 10.229.236.133 with SMTP id kk5mr2882129qcb.191.1287330692637;
 Sun, 17 Oct 2010 08:51:32 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Sun, 17 Oct 2010 08:51:32 -0700 (PDT)
Date:   Sun, 17 Oct 2010 23:51:32 +0800
Message-ID: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com>
Subject: Question about Context register in TLB refilling
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     chelly wilbur <wilbur512@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

I have some questions  concerning  TLB refilling mechanism on mips:



1) In linux ,esspecially in TLB refilling,  is Context[PTEBase] used
to store cpuid? (refer to build_get_pgde32 in tlbex.c)


2) In function of build_get_ptep, when generating a   pte offset , is
Context[BadVPN]  replaceable  by BadVAddr register?


Thanks in advance
