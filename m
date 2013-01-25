Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2013 13:39:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.19.201]:39149 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833461Ab3AYMjBFBelp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Jan 2013 13:39:01 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6898220233;
        Fri, 25 Jan 2013 12:38:57 +0000 (UTC)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net [67.168.183.230])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A40201CC;
        Fri, 25 Jan 2013 12:38:52 +0000 (UTC)
Date:   Fri, 25 Jan 2013 04:40:30 -0800
From:   Greg KH <greg@kroah.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     John Crispin <blogic@openwrt.org>, Alan Cox <alan@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] serial: of: allow au1x00 and rt288x to load from OF
Message-ID: <20130125124030.GA14952@kroah.com>
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
 <1359111008-9998-2-git-send-email-blogic@openwrt.org>
 <51027021.8010802@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51027021.8010802@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
X-archive-position: 35557
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jan 25, 2013 at 03:44:33PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-01-2013 14:50, John Crispin wrote:
> 
> >In order to make serial_8250 loadable via OF on Au1x00 and Ralink WiSoC we need
> >to default the iotype to UPIO_AU.
> 
>    Alan Cox no longer works on Linux, Greg KH looks after the serial
> drivers snow.

It's ok, I'm on the mailing list and pick this stuff up, no need to
resend.

greg k-h
