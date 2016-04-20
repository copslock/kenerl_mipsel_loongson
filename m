Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 08:49:50 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36511 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026343AbcDTGtskff2x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 08:49:48 +0200
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D7A821156
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 02:49:47 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 20 Apr 2016 02:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=5Q9CaQvVwgjtjpz2yoZfoQhmR8I=; b=nwNOf
        TiK0xuB0fD4qKfe2XmtJAj73PNDf7+riTX3Fjy4ZLaaarmv1cJa7x2UJdorrMb/+
        45qBYf3srrBVU50kwT95MvDKF0Jf30o7PF6w+rmUA1oIeGUBiXJ+SGbw5smqitas
        yPw1gYuwRT9XQecBo8q6AigaKSzO2k5dRYVNDI=
X-Sasl-enc: WgF2MplAnXn40TlSp6ynTLv06MpwVA9ktcO3ySM9TwaY 1461134982
Received: from localhost (kd036012127042.au-net.ne.jp [36.12.127.42])
        by mail.messagingengine.com (Postfix) with ESMTPA id C61F6C00014;
        Wed, 20 Apr 2016 02:49:39 -0400 (EDT)
Date:   Wed, 20 Apr 2016 15:49:23 +0900
From:   Greg KH <greg@kroah.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: Loongson-3 doesn't fully support wc memory
Message-ID: <20160420064923.GA698@kroah.com>
References: <1461064751-17873-1-git-send-email-chenhc@lemote.com>
 <CADnq5_OyS_pCu-4wW5uFpnr5kvqkHK5uPdmBKgHHmfZ-dOdXvw@mail.gmail.com>
 <CAAhV-H6EsxUhuXAAYBhun-S4+tM-xhWxKbXD4Jg0btK4sLfjGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6EsxUhuXAAYBhun-S4+tM-xhWxKbXD4Jg0btK4sLfjGg@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Wed, Apr 20, 2016 at 02:18:20PM +0800, Huacai Chen wrote:
> Cc: stable@vger.kernel.org

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
