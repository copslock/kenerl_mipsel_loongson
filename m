Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 14:34:34 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeAVNe1RUanF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2018 14:34:27 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF9EA1046;
        Mon, 22 Jan 2018 13:34:20 +0000 (UTC)
Date:   Mon, 22 Jan 2018 14:34:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is
 used
Message-ID: <20180122133420.GA5222@kroah.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-4-jonas.gorski@gmail.com>
 <20180122130718.GA22211@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122130718.GA22211@saruman>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62267
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

On Mon, Jan 22, 2018 at 01:07:19PM +0000, James Hogan wrote:
> Hi stable maintainers,
> 
> On Sun, Oct 29, 2017 at 04:27:21PM +0100, Jonas Gorski wrote:
> > Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
> > trigger I/F of FIFO buffers"), the port's default FCR value isn't used
> > in serial8250_do_set_termios anymore, but copied over once in
> > serial8250_config_port and then modified as needed.
> > 
> > Unfortunately, serial8250_config_port will never be called if the port
> > is shared between kernel and userspace, and the port's flag doesn't have
> > UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as well.
> > 
> > This causes garbled output from userspace:
> > 
> > [    5.220000] random: procd urandom read with 49 bits of entropy available
> > ers
> >    [kee
> > 
> > Fix this by forcing it to be configured on boot, resulting in the
> > expected output:
> > 
> > [    5.250000] random: procd urandom read with 50 bits of entropy available
> > Press the [f] key and hit [enter] to enter failsafe mode
> > Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
> > 
> > Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigger I/F of FIFO buffers")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> 
> Please can this patch be applied to stable branches 3.17+. It is now
> merged into mainline as commit 0a5191efe06b ("MIPS: AR7: ensure the port
> type's FCR value is used").
> 
> Commit b084116f8587 ("MIPS: AR7: Ensure that serial ports are properly
> set up") is a prerequisite for it to apply cleanly, but is already
> tagged for stable.

Now snuck into this round of stable -rc review :)

thanks,

greg k-h
