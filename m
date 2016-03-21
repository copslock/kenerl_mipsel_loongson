Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 00:08:30 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35829 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013535AbcCUXI3rp-2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 00:08:29 +0100
Received: from localhost (c-50-138-182-192.hsd1.ma.comcast.net [50.138.182.192])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 087A271;
        Mon, 21 Mar 2016 23:08:22 +0000 (UTC)
Date:   Mon, 21 Mar 2016 19:08:21 -0400
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Schiffer <mschiffer@universe-factory.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, jslaby@suse.com,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Message-ID: <20160321230821.GA17910@kroah.com>
References: <56F07DA1.8080404@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56F07DA1.8080404@universe-factory.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52668
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

On Tue, Mar 22, 2016 at 12:02:57AM +0100, Matthias Schiffer wrote:
> Hi,
> we're experiencing weird nondeterministic hangs during bootconsole/console
> handover on some ath79 systems on OpenWrt. I've seen this issue myself on
> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to other
> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs like
> QCA953x likewise.

Can you try 4.4 or ideally, 4.5?  There's been a lot of console/tty
fixes/changes since the obsolete 3.18 kernel you are using...

thanks,

greg k-h
