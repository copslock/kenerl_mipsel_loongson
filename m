Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 18:33:32 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41479 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011636AbcAZRd2vQHZs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 18:33:28 +0100
Received: from localhost (unknown [104.135.8.89])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78EC5E96;
        Tue, 26 Jan 2016 17:33:22 +0000 (UTC)
Date:   Tue, 26 Jan 2016 09:33:22 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        linux-serial@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 10/14] serial: pic32_uart: Add PIC32 UART driver
Message-ID: <20160126173322.GA1664@kroah.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
 <1452734299-460-11-git-send-email-joshua.henderson@microchip.com>
 <56A7A729.10008@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A7A729.10008@microchip.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51421
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

On Tue, Jan 26, 2016 at 10:04:41AM -0700, Joshua Henderson wrote:
> Hi Greg and Jiri,
> 
> Ping!  Need an ack for this or pull it upstream.

The merge window _just_ ended, please give us a chance to catch up on
patches to be reviewed.  There's no reason you need a response for this
right away, it can't be merged until 4.6-rc1, right?

thanks,

greg k-h
