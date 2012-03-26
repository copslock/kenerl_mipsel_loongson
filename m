Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 01:52:40 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:59305 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2CZXwX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 01:52:23 +0200
Received: by yhjj52 with SMTP id j52so4885682yhj.36
        for <multiple recipients>; Mon, 26 Mar 2012 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aoE7Ku4BYJo7b5NUHyd4umSMbVYtA7Hc1ksqYHZzCuo=;
        b=WN43FIpMSixlOA5c4GiGEB2QYNt7xEK/hRyrN6Xx/lu/UNimagpdP0gGkS5fglTzEv
         g2LKxVMR2O2IXaZ5OIOfF6MJNFy1wz4kBEXc/5uFpzwD0khdgD1ceQaWEWoeeDp5jxJc
         pXtXD9bckcaZmL1YJSNKSkoeBuiRoW5ntSNsI+7Ua64IPQwdALNAE+/7PQ8PPrMhZWF0
         ekBI2aAe/ARWUhV9otxA0wZ3ewY1wwUV/Qy2g+Wn/7OyO6xcIu17xVIgoL9W3KFSLNg/
         LkISkUO66eHOhzzDTJ+oTVy7g/SMnnLYZCgipgT/IC4sSWUgLhV+QgJm8oOvmecNwfPf
         UZ7g==
MIME-Version: 1.0
Received: by 10.236.184.129 with SMTP id s1mr24088939yhm.21.1332805937622;
 Mon, 26 Mar 2012 16:52:17 -0700 (PDT)
Received: by 10.146.167.12 with HTTP; Mon, 26 Mar 2012 16:52:17 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1203261346360.3443@eggly.anvils>
References: <1332777965-2534-1-git-send-email-consul.kautuk@gmail.com>
        <alpine.LSU.2.00.1203261346360.3443@eggly.anvils>
Date:   Mon, 26 Mar 2012 19:52:17 -0400
Message-ID: <CAFPAmTQdud0rxbXt92zpRa+AmyNX8CKf=99X71VXvX9vteEC9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmap.c: find_vma: replace if(mm) check with BUG_ON(!mm)
From:   Kautuk Consul <consul.kautuk@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: consul.kautuk@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Hugh,

Thanks for the review.

I have sent another patch for this with changed subject and your changes.
