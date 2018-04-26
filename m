Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 08:57:23 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990410AbeDZG5QdH0Rh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2018 08:57:16 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A67EF3C1;
        Thu, 26 Apr 2018 06:57:09 +0000 (UTC)
Date:   Thu, 26 Apr 2018 08:57:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     amit.pundir@linaro.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable-commits@vger.kernel.org
Subject: Re: Patch "MIPS: fix mem=X@Y commandline processing" has been added
 to the 4.9-stable tree
Message-ID: <20180426065701.GB14025@kroah.com>
References: <15246720861733@kroah.com>
 <CA+7wUszxmW8Lsq-aEovy5QYmq3GABOQf6O1cz=AqcH2mcBBPoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUszxmW8Lsq-aEovy5QYmq3GABOQf6O1cz=AqcH2mcBBPoA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Wed, Apr 25, 2018 at 08:51:16PM +0200, Mathieu Malaterre wrote:
> Hi Greg,
> 
> Why is this patch coming back ? This was discussed previously at:
> 
> https://www.spinics.net/lists/kernel/msg2617572.html

Sorry, I found an old list of patches taht Amit had dug up and grabbed
it from there.

> The correct fix is rather 67a3ba25aa955.

And as that only goes to 4.11+, I'll leave things alone now.

Patch is now dropped, sorry for the noise.

greg k-h
