Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2011 23:16:41 +0200 (CEST)
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55124 "EHLO
        out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491167Ab1GAVQe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2011 23:16:34 +0200
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
        by gateway1.messagingengine.com (Postfix) with ESMTP id 81DF120ACB;
        Fri,  1 Jul 2011 17:16:32 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 01 Jul 2011 17:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=Wxlwi/0Cd3o36rDgKRGEGs8L8So=; b=rij09KpTU6yJXREeTMQDk+lrSLIyLKehzsRvnDqtn+n2EDnhcTlRQOGyUUot5GGvwZEduoItG3bOhqs7HHI/mt1irxgrU745uSEhPOGy5T6BVer31KuYd55qRCzssHN4VL1Bh+rolvvpxY8Oks+NtdsB8sXeAKwXrkCovoU96Uo=
X-Sasl-enc: qAV+PXdGEXOz1DG3L9lAVP1iqnVf3T5qIB7BtV1P9bK1 1309554992
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
        by mail.messagingengine.com (Postfix) with ESMTPSA id 0EFE34433B9;
        Fri,  1 Jul 2011 17:16:31 -0400 (EDT)
Date:   Fri, 1 Jul 2011 14:11:23 -0700
From:   Greg KH <greg@kroah.com>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 11/13] serial: add driver for the built-in UART of the
 AR933X SoC
Message-ID: <20110701211123.GA19805@kroah.com>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
 <1308597973-6037-12-git-send-email-juhosg@openwrt.org>
 <20110621095951.7dc1c9ee@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110621095951.7dc1c9ee@lxorguk.ukuu.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1077

On Tue, Jun 21, 2011 at 09:59:51AM +0100, Alan Cox wrote:
> Looks good to me
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> and no problem here with it going via the MIPS tree (but make sure GregKH
> is happy)

I'm happy with this.
