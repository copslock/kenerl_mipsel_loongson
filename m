Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 16:09:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34106 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491156Ab0JOOJG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 16:09:06 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9FE8Llr003293;
        Fri, 15 Oct 2010 15:08:21 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9FE8KIO003291;
        Fri, 15 Oct 2010 15:08:20 +0100
Date:   Fri, 15 Oct 2010 15:08:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Julia Lawall <julia@diku.dk>
Cc:     Pat Gefre <pfg@sgi.com>, kernel-janitors@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] drivers/serial/ioc3_serial.c: Return -ENOMEM on
 memory allocation failure
Message-ID: <20101015140819.GA3163@linux-mips.org>
References: <1287147610-8041-6-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1287147610-8041-6-git-send-email-julia@diku.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 15, 2010 at 03:00:09PM +0200, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> In this code, 0 is returned on memory allocation failure, even though other
> failures return -ENOMEM or other similar values.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)

Dunno why linux-mips rsp. myself keep receiving patches for the ioc3 serial
driver - it's only being used on SGI IA64 machines.

Either way, I'm willing to funnel this patch upstream - I'm building a
pull rq for tonight anyway.

  Ralf
