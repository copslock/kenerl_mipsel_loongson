Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 20:03:49 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:36508 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491104Ab0JTSDo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Oct 2010 20:03:44 +0200
Received: by pwi2 with SMTP id 2so283134pwi.36
        for <multiple recipients>; Wed, 20 Oct 2010 11:03:35 -0700 (PDT)
Received: by 10.142.174.15 with SMTP id w15mr6190530wfe.255.1287597815460;
        Wed, 20 Oct 2010 11:03:35 -0700 (PDT)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id e36sm736655wfj.2.2010.10.20.11.03.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 11:03:34 -0700 (PDT)
Received: by angua (Postfix, from userid 1000)
        id 705363C00E5; Wed, 20 Oct 2010 12:03:32 -0600 (MDT)
Date:   Wed, 20 Oct 2010 12:03:32 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dezhong Diao <dediao@cisco.com>
Subject: Re: [PATCH] of/mips: Cleanup some include directives/files.
Message-ID: <20101020180332.GO7285@angua.secretlab.ca>
References: <1287528631-31797-1-git-send-email-ddaney@caviumnetworks.com>
 <20101020065830.GA12565@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101020065830.GA12565@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2010 at 07:58:30AM +0100, Ralf Baechle wrote:
> On Tue, Oct 19, 2010 at 03:50:31PM -0700, David Daney wrote:
> 
> > The __init directives should go on the definitions of things, not the
> > declaration, also __init is meaningless for inline functions, so
> > remove it from prom.h.  This allows us to get rid of a useless
> > #include, but most of the rest of them are useless too, so kill them
> > as well.
> > 
> > If of_i2c.c needs irq definitions, it should include linux/irq.h
> > directly, not assume indirect inclusion via asm/prom.h.
> 
> Grant, I assume you're going to merge this one.
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Yes, I'll pick it up.  I'm compile testing now.

g.

> 
>   Ralf
