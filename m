Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 23:03:00 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42150 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855205AbaHRVCyCS9P8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2014 23:02:54 +0200
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by gateway1.nyi.internal (Postfix) with ESMTP id 9124123C31
        for <linux-mips@linux-mips.org>; Mon, 18 Aug 2014 17:02:52 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 18 Aug 2014 17:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=KkgXM4zaLiLhT+EmJ1vYXSV28MM=; b=UtMlinX0J8UtW0w5NfZ/H8M5BHqj
        xicUXGEaTJmIPLMpnEFXkwrEYK/6hzt1/nfnzdgb4rfMq/4j7IjDN+S34r2NwFcE
        SV9KdhmFW+TfJ24C+KdPTV4bWjU1QkgM+YlhyS4qvXfDtRMbERf18TGYFstU78KF
        fpocDW4aZaYZQic=
X-Sasl-enc: XF3LsjldBY8hCUMq8dib3HasPu9vvPPENPrtthOJJdd+ 1408395772
Received: from localhost (unknown [166.147.96.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 401FD6800FD;
        Mon, 18 Aug 2014 17:02:52 -0400 (EDT)
Date:   Mon, 18 Aug 2014 11:46:39 -0500
From:   Greg KH <greg@kroah.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     stable@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [request for stable inclusion] MIPS: math-emu: Fix instruction
 decoding
Message-ID: <20140818164639.GA14942@kroah.com>
References: <20140818135933.GA1214@mchandras-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140818135933.GA1214@mchandras-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42137
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

On Mon, Aug 18, 2014 at 02:59:33PM +0100, Markos Chandras wrote:
> Hi Greg,
> 
> Could you please apply the following patch to the 3.16.X stable kernels?
> 
> c3b9b945e02e011c63522761e91133ea43eb6939
> "MIPS: math-emu: Fix instruction decoding"

Now applied.
