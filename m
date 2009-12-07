Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 16:41:51 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:59866 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493939AbZLGPls (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Dec 2009 16:41:48 +0100
Received: from list by lo.gmane.org with local (Exim 4.50)
        id 1NHfiY-0002Su-LC
        for linux-mips@linux-mips.org; Mon, 07 Dec 2009 16:41:42 +0100
Received: from rob92-6-82-231-243-221.fbx.proxad.net ([82.231.243.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 07 Dec 2009 16:41:42 +0100
Received: from pascal by rob92-6-82-231-243-221.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 07 Dec 2009 16:41:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   "pascal@pabr.org" <pascal@pabr.org>
Subject:  Re: Warning about add_wired_entry
Date:   Mon, 07 Dec 2009 16:41:04 +0100
Message-ID: <hfj7mr$lde$1@ger.gmane.org>
References:  <20091207150236.GD19269@linux-mips.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-1
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rob92-6-82-231-243-221.fbx.proxad.net
In-Reply-To: <20091207150236.GD19269@linux-mips.org>
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pascal@pabr.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> The kernel does not reserve any address space for use by add_wired_entry().
> In other words there is the possibility that vmalloc, ioremap or other
> kernel APIs will use the same address space resulting in a crash or worse.

Thanks, I was not aware of that.

But what is the alternative ?  I have an Alchemy 1550 board with
an ethernet chip at 0xD-1000-0000, and last time I tried, enabling
  CONFIG_64BIT_PHYS_ADDR,
  CONFIG_ARCH_PHYS_ADDR_T_64BIT and
  CONFIG_PHYS_ADDR_T_64BIT
did not seem to allow access to the 36-bit I/O address space
through the platform_get_resource/request_mem_region machinery.
Is this supposed to work now ?

Pascal
