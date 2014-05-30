Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 20:40:40 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52405 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822998AbaE3SkiuVMcB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 20:40:38 +0200
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 41E7120F23
        for <linux-mips@linux-mips.org>; Fri, 30 May 2014 14:40:36 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 30 May 2014 14:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=message-id:date:from:mime-version:to:cc
        :subject:references:in-reply-to:content-type
        :content-transfer-encoding; s=smtpout; bh=F8g0//D0QC5lKKyEWzTtuU
        oLsoY=; b=HhVOttIveNeL9frGO067g4/ggQDjVfOqJTGWztjUMW/nlyBVnByYsQ
        zPXZLPepETAHFck/BgOzHBgviIpqv0eSTBdt8fN66u4KdjMYyQ6LPNBUvWGCf5I3
        DkVvLqjrj2GMTnt3ZC+ifzFePJNjmi0VD5l4IFMGL0peJ268B+qqY=
X-Sasl-enc: JISKrhsX4B8p22Qsizby0Nqtdor1pGqw/nrketk/pkcL 1401475235
Received: from localhost.localdomain (unknown [83.249.107.137])
        by mail.messagingengine.com (Postfix) with ESMTPA id C306DC007AA;
        Fri, 30 May 2014 14:40:34 -0400 (EDT)
Message-ID: <5388D0A1.9030005@iki.fi>
Date:   Fri, 30 May 2014 21:40:33 +0300
From:   Pekka Enberg <penberg@iki.fi>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 00/12] kvm tools: Misc patches (mips support)
References: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <penberg@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: penberg@iki.fi
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

On 05/28/2014 11:08 PM, Andreas Herrmann wrote:
> Hi,
>
> This is v3 of my patch set to run lkvm on MIPS.
>
> It's rebased on v3.13-rc1-1436-g1fc83c5 of
> git://github.com/penberg/linux-kvm.git
>

Applied, thanks!
