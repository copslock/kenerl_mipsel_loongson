Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2018 15:43:12 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:42878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992615AbeFBNnDp6md3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Jun 2018 15:43:03 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2167AACD5;
        Sat,  2 Jun 2018 13:42:57 +0000 (UTC)
Date:   Sat, 2 Jun 2018 15:42:53 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make elf2ecoff work on 64bit host machines
Message-Id: <20180602154253.5a65264ec4d11a8c8a16ef1a@suse.de>
In-Reply-To: <20180601000311.lgwempsux7hnz7pn@pburton-laptop>
References: <20180528112625.25509-1-tbogendoerfer@suse.de>
        <20180601000311.lgwempsux7hnz7pn@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, 31 May 2018 17:03:11 -0700
Paul Burton <paul.burton@mips.com> wrote:


> Perhaps we should #include <stdint.h> before making use of the types it
> provides?

good point, will send a new version.

> > @@ -518,7 +518,7 @@ int main(int argc, char *argv[])
> >  
> >  		for (i = 0; i < nosecs; i++) {
> >  			printf
> > -			    ("Section %d: %s phys %lx  size %lx	 file offset %lx\n",
> > +			    ("Section %d: %s phys %x  size %x	 file offset %x\n",
> 
> Maybe #include <inttypes.h>, then use PRIx32 & co here & below?

I'll have look.

Thomas.
