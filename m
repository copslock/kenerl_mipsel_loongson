Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 17:36:07 +0100 (CET)
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38552 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007249AbaLOQgGPGcK9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 17:36:06 +0100
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 931B720865
        for <linux-mips@linux-mips.org>; Mon, 15 Dec 2014 11:36:05 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 15 Dec 2014 11:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:date:from:to:cc:subject
        :message-id:references:mime-version:content-type:in-reply-to; s=
        smtpout; bh=T95Qb2ALkVu6ljHniNv3PvF4i5c=; b=cwCC2lwok47BLcm9oLSY
        tyXy12eFUkFhPYXOFF5IUDdBh/IxK/dZaTldXE4LLd6x9OcsFUkDqIH0twWpGewo
        x43It8QAT39j2z3yGcJOQNr0vxmwArj2CJrMcmetO4OnAhQulSCidYn3kRhC5824
        QMqxhTh84PZ8Pbdv5YnRlKM=
X-Sasl-enc: jWffeac3IyS25q4A12uH3vH2aCMXw1jFvUV+ziQK0Qcs 1418661365
Received: from localhost (unknown [24.22.230.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2CCCF6800EA;
        Mon, 15 Dec 2014 11:36:05 -0500 (EST)
Date:   Mon, 15 Dec 2014 08:36:04 -0800
From:   Greg KH <greg@kroah.com>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 0/2 resend] USB: host: Misc patches to remove hard-coded
 octeon platform information
Message-ID: <20141215163604.GA1470@kroah.com>
References: <20141215132628.GA20109@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215132628.GA20109@alberich>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44681
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

On Mon, Dec 15, 2014 at 02:26:29PM +0100, Andreas Herrmann wrote:
> This is a re-submission of patches 2 and 3 from
> http://marc.info/?i=1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com
> (Only patch 1/3 made it into usb-next and meanwhile is in mainline.)
> 
> Please apply.

I'll get to patches after 3.19-rc1 is out, can't do anything with my
trees until then, sorry.

greg k-h
