Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2011 17:16:20 +0200 (CEST)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46186 "EHLO
        out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491135Ab1F2PQN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jun 2011 17:16:13 +0200
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
        by gateway1.messagingengine.com (Postfix) with ESMTP id B9EED20ECD;
        Wed, 29 Jun 2011 11:16:11 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 29 Jun 2011 11:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=5K3lCSUv8VUNs0+MWi0wjTGSQEU=; b=l0K6tgfztfeVGXVK93cgYN65ZJF6FF4rgNF/GXkEn6c6mjmQx8mdax6y+HPJWJEPBUw+AWsOnVw+o+xsj/6bFWLZVPkLOrLI0ifCs9irjzX7eh3GDbJ8HCUDuc7ATB0+1ogh24z8l3JkMMPGnCXGoF7ZfzH/dDa7aA0IeIJyxKA=
X-Sasl-enc: C3n4suUnpkPll4jXuQApfWmpEhj7Kj49wvoYlhH88sOP 1309360571
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
        by mail.messagingengine.com (Postfix) with ESMTPSA id 2E6DD443945;
        Wed, 29 Jun 2011 11:16:11 -0400 (EDT)
Date:   Wed, 29 Jun 2011 08:14:24 -0700
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>, akpm@linux-foundation.org,
        alan@linux.intel.com, bcasavan@sgi.com, airlied@linux.ie,
        grundler@parisc-linux.org, perex@perex.cz, rpurdie@rpsys.net,
        klassert@mathematik.tu-chemnitz.de, tj@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various section mismatches and build errors.
Message-ID: <20110629151424.GD18023@kroah.com>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
 <20110627.221257.1290251511587162468.davem@davemloft.net>
 <20110629130711.GA15649@linux-mips.org>
 <1309355899.2551.4.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309355899.2551.4.camel@mulgrave>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23984

On Wed, Jun 29, 2011 at 08:58:19AM -0500, James Bottomley wrote:
> I think we should simply concentrate on __init and __exit; that's where
> most of the discard value lies and stop expending huge efforts on the
> __devX stuff which adds huge complexity for no real gain.

I have long felt that those __devX markings should just go away as they
cause nothing but problems and have no real gain as you point out.

greg k-h
