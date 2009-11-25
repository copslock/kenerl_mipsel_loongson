Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 17:00:38 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55569 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493065AbZKYQAe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 17:00:34 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAPG0luv010612;
        Wed, 25 Nov 2009 16:00:48 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAPG0lF6010610;
        Wed, 25 Nov 2009 16:00:47 GMT
Date:   Wed, 25 Nov 2009 16:00:47 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Figo.zhang" <figo1802@gmail.com>
Cc:     Kevin Hickey <khickey@netlogicmicro.com>, linux-mips@linux-mips.org
Subject: Re: how to support more than 512MB RAM for MIPS32 ?
Message-ID: <20091125160047.GA10490@linux-mips.org>
References: <c6ed1ac50911242234p12817b55r1a062d59949308bf@mail.gmail.com> <1259159857.4675.11.camel@kh-d280-64> <1259163074.2049.6.camel@myhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259163074.2049.6.camel@myhost>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 11:31:14PM +0800, Figo.zhang wrote:

> how to do map extra RAM to any ouside I/O space?
> it is just motify:
> 
> 1. arch/mips/kernel/setup.c: bootm_init()function, motity the define
> "HIGHMEM_START", for me: 
> #define HIGHMEM_START 0x2000,0000   //512MB

Leave HIGHMEM_START unchanged; it should always be 512MB no matter what
the actual memory addresses of a particular platform are.  The kernel
needs to treat anything above 512MB differently because it's not
permanently mapped and HIGHMEM_START stands for this limit.

  Ralf
