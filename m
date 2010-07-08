Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 18:47:10 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49571 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491797Ab0GHQrH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 18:47:07 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o68Gku90005691
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 8 Jul 2010 09:46:57 -0700
Received: from localhost (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id o68GksDN014560;
        Thu, 8 Jul 2010 09:46:55 -0700
Date:   Thu, 8 Jul 2010 09:46:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
Message-Id: <20100708094654.6fbeefe8.akpm@linux-foundation.org>
In-Reply-To: <4C35D264.7080809@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
        <1276924111-11158-17-git-send-email-lars@metafoo.de>
        <4C310ACD.6040604@metafoo.de>
        <20100707164148.d2a1f8c4.akpm@linux-foundation.org>
        <4C35D264.7080809@metafoo.de>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.9; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 08 Jul 2010 15:28:04 +0200 Lars-Peter Clausen <lars@metafoo.de> wrote:

> > Although I might whine about inappropriate use of
> > ENOENT, which means "No such file or directory".
> > 
> 
> That is due to to many bad examples, I guess. Would using ENXIO instead keep
> you from whining?

Sounds a bit better.  It's hardly a huge issue though.
