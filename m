Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 01:25:40 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39692 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822191AbaE2XZihC4aK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 01:25:38 +0200
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0902721028
        for <linux-mips@linux-mips.org>; Thu, 29 May 2014 19:25:37 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 29 May 2014 19:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=GPkTRcZrMSPsNTnDdO6jqvT7aN4=; b=UxmMHCLlbFAVJZELK7jsncXcsFVx
        R197KVzR5YCnnOjb+suetcIpAAXMAdDLSxOFOEj5hqYVp9G7lT5CKYNTEHxN99eB
        m8Du5NSVqRK9BB6VhKWytroFjPSMVS/0GuyHKaA28ReXMyf30VBC02M2lQ3P0KOu
        1Sp+H3nbeJ+uhtE=
X-Sasl-enc: kr/cMH8RKitEcxSrmQXiIYOqyOL8OJS4i0EdwkY5Bl5z 1401405936
Received: from localhost (unknown [76.28.255.20])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79DCFC007AA;
        Thu, 29 May 2014 19:25:36 -0400 (EDT)
Date:   Thu, 29 May 2014 16:25:34 -0700
From:   Greg KH <greg@kroah.com>
To:     abdoulaye berthe <berthe.ab@gmail.com>
Cc:     linus.walleij@linaro.org, gnurou@gmail.com, m@bues.ch,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com,
        platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] gpio: removes all usage of gpiochip_remove retval
Message-ID: <20140529232534.GA11741@kroah.com>
References: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40372
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

On Thu, May 29, 2014 at 11:54:52PM +0200, abdoulaye berthe wrote:
> Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>

Why?
