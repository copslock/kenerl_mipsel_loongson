Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 01:42:30 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43689 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492033Ab0GGXm0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 01:42:26 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o67Nfp9P008810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 7 Jul 2010 16:41:52 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id o67NfmZl001200;
        Wed, 7 Jul 2010 16:41:49 -0700
Date:   Wed, 7 Jul 2010 16:41:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
Message-Id: <20100707164148.d2a1f8c4.akpm@linux-foundation.org>
In-Reply-To: <4C310ACD.6040604@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
        <1276924111-11158-17-git-send-email-lars@metafoo.de>
        <4C310ACD.6040604@metafoo.de>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Mon, 05 Jul 2010 00:27:25 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Hi Andrew
> 
> v2 of this patch has been around for two weeks without any comments. I've fixed all
> the issues you had with v1. If you this version is ok, an Acked-By would be nice :)

I don't do acks - I already have enough to be blamed for.  I'd merge it
if asked to though.  Although I might whine about inappropriate use of
ENOENT, which means "No such file or directory".
