Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2011 16:40:05 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56803 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491043Ab1GZOkC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jul 2011 16:40:02 +0200
Received: from rakim.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 8F117750055;
        Tue, 26 Jul 2011 15:39:56 +0100 (BST)
Received: by rakim.wolfsonmicro.main (Postfix, from userid 1000)
        id 00E99878B924; Tue, 26 Jul 2011 15:39:55 +0100 (BST)
Date:   Tue, 26 Jul 2011 15:39:55 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 2/3] ASoC: Add a DB1x00 AC97 machine driver
Message-ID: <20110726143955.GH7285@opensource.wolfsonmicro.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
 <1311594287-31576-3-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311594287-31576-3-git-send-email-manuel.lauss@googlemail.com>
X-Cookie: Save energy: be apathetic.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18652

On Mon, Jul 25, 2011 at 01:44:46PM +0200, Manuel Lauss wrote:
> Add a machine driver suitable for the AC97 part on the DB1000/DB1500/DB1100
> boards.
> 
> Run-tested on DB1500.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Since you've got both arch/ and sound/ changes in here I need an ack
from the MIPS maintainers for this one before I can apply it.
