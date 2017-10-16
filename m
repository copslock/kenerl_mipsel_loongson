Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 09:08:25 +0200 (CEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:58219 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990422AbdJPHISq03Qe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 09:08:18 +0200
Received: from penelope.horms.nl (unknown [217.111.208.18])
        by kirsty.vergenet.net (Postfix) with ESMTPA id C9DE125B818;
        Mon, 16 Oct 2017 18:08:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1508137696; bh=sqlEZNVLL60wAYIpWGNaY7N7cfqXEQeEY9deyBVn0hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQp/3hemo0QL92k2RlZor9lbfsL3LGyg73Nb6DQS2JpR8sNU4wE3f8AbxRcUtNVBe
         gZxdHbNvgv8FtPA+W0WsjJoSSFG+7vQ59ZCZu19pbVFV3Pr+lCb3Ji7de6HZvQKiDG
         2dkYqw05Drz0yvCJq3MKh2oq0WmYb7GMUOsiHO2k=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 50E09E21DF4; Mon, 16 Oct 2017 09:02:05 +0200 (CEST)
Date:   Mon, 16 Oct 2017 09:02:05 +0200
From:   Simon Horman <horms@verge.net.au>
To:     David Daney <david.daney@cavium.com>
Cc:     kexec@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] kexec-tools: mips: Try to include bss in kernel
 vmcore file.
Message-ID: <20171016070205.qaghovtwnfhy2u2n@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-5-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012210228.7353-5-david.daney@cavium.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
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

On Thu, Oct 12, 2017 at 02:02:28PM -0700, David Daney wrote:
> The kernel message buffers, as well as a lot of other useful data
> reside in the bss section.  Without this vmcore-dmesg cannot work, and
> debugging with a core dump is much more difficult.
> 
> Try to add the /proc/iomem "Kernel bss" section to vmcore.  If it is
> not found, just do what we used to do and use "Kernel data" instead.

Thanks, applied.
