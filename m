Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 15:10:30 +0200 (CEST)
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47274 "EHLO
        out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491023Ab1F3NK0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 15:10:26 +0200
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
        by gateway1.messagingengine.com (Postfix) with ESMTP id D8AA320CF0;
        Thu, 30 Jun 2011 09:10:24 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 30 Jun 2011 09:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Cn1EpHEy9V8Pg9vDofG2ppFvUI4=; b=HbRAjeTHyzl/zHQNJRtHhRFTrlcEmnu48bEUc7aLiYBMrh/q5v8st339/vM5TKKRYG+p8Xncy648z4LbHUkKgqSFQ1e2T0Nh+yZBnmeay23lDU8NQBf8CAhxSPKuA6+S08tPlj8lwQija6C3SEXit8W/jy1NYod4PUQzmBXgg8U=
X-Sasl-enc: qUPNLK3p2n5V3kViiJq/JuDKuL2x+hrLp5JnWI+pC3H1 1309439424
Received: from [10.1.2.56] (unknown [94.101.37.4])
        by mail.messagingengine.com (Postfix) with ESMTPSA id 7891A404AB1;
        Thu, 30 Jun 2011 09:10:22 -0400 (EDT)
Message-ID: <4E0C75BD.1050103@ladisch.de>
Date:   Thu, 30 Jun 2011 15:10:21 +0200
From:   Clemens Ladisch <clemens@ladisch.de>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Takashi Iwai <tiwai@suse.de>, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        florian@linux-mips.org, "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Matt Turner <mattst88@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: [alsa-devel] SB16 build error.
References: <20110630091754.GA12119@linux-mips.org>     <s5h8vsjy68z.wl%tiwai@suse.de> <20110630105254.GA25732@linux-mips.org>
In-Reply-To: <20110630105254.GA25732@linux-mips.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 30570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clemens@ladisch.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24920

Ralf Baechle wrote:
> I have no idea how big the soundblaster microcode being loaded actually is,
> that is if the reduced size of 0x1f00 will be sufficient.

The biggest file is WFM0001A.CSP with 0x2df0 bytes.

> I don't see how the old ioctl can possibly have been
> used before so there isn't a compatibility problem.

The code uses SNDRV_SB_CSP_MAX_MICROCODE_FILE_SIZE but doesn't care what
the size field of the ioctl code is, so we could use any random value on
those architectures.

> Or you could entirely sidestep the problem and use request_firmware()
> but I guess that's more effort than you want to invest.

The driver already implements this for a bunch of predefined CSP code
blobs.  I'm not sure whether anybody has ever loaded additional .csp
files.


Regards,
Clemens
