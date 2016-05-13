Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 18:50:36 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47959 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014106AbcEMQucXMUIx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 18:50:32 +0200
Received: from localhost (unknown [46.255.181.195])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A913409;
        Fri, 13 May 2016 16:50:25 +0000 (UTC)
Date:   Fri, 13 May 2016 18:50:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-usb@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] USB: ohci-jz4740: Remove obsolete driver
Message-ID: <20160513165023.GA31809@kroah.com>
References: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
 <1461005933-24876-3-git-send-email-maarten@treewalker.org>
 <20160513164017.GL4215@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160513164017.GL4215@linux-mips.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53440
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

On Fri, May 13, 2016 at 06:40:17PM +0200, Ralf Baechle wrote:
> Maarten,
> 
> if you submit a USB change to the USB mailing list and maintainer the
> probability for the maintainer to ack this patch will actuall rise
> significantly ;-)
> 
> Greg, I assume this patch is ok to merge or do you want to funnel it
> hrough your tree?  I think it would be good to take this through the
> MIPS tree together with the remainder of the series.

Deleting code?  Yes, I'm all for that :)

	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

And yes, actually letting the maintainers know is a good thing, unless
you don't want your patches applied...

thanks,

greg k-h
