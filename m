Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2018 16:08:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeCaOIpFZCKG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2018 16:08:45 +0200
Received: from localhost (unknown [62.177.166.178])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1B7EEE3;
        Sat, 31 Mar 2018 14:08:36 +0000 (UTC)
Date:   Sat, 31 Mar 2018 16:08:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wasim Nazir <wasim.nazir@pathpartnertech.com>
Cc:     jhogan@kernel.org, kys@microsoft.com, linuxdrivers@attotech.com,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <david.daney@cavium.com>,
        Mihaela Muraru <mihaela.muraru21@gmail.com>,
        Kishore KP <kishore.p@techveda.org>,
        Sidong Yang <realwakka@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Phil Elwell <phil@raspberrypi.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-mips@linux-mips.org,
        linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] Patch to replace DEFINE_SEMAPHORE with
 DEFINE_BINARY_SEMAPHORE
Message-ID: <20180331140832.GA1074@kroah.com>
References: <CAAYn-eg8L=-2rX4ZcsA6r9J+6ESEvQFrWk1=f+k1ToP2f=6WHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYn-eg8L=-2rX4ZcsA6r9J+6ESEvQFrWk1=f+k1ToP2f=6WHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63372
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

On Sat, Mar 31, 2018 at 07:16:21PM +0530, Wasim Nazir wrote:
> This message contains confidential information and is intended only for the 
> individual(s) named. If you are not the intended recipient, you are 
> notified that disclosing, copying, distributing or taking any action in 
> reliance on the contents of this mail and attached file/s is strictly 
> prohibited. Please notify the sender immediately and delete this e-mail 
> from your system. E-mail transmission cannot be guaranteed to be secured or 
> error-free as information could be intercepted, corrupted, lost, destroyed, 
> arrive late or incomplete, or contain viruses. The sender therefore does 
> not accept liability for any errors or omissions in the contents of this 
> message, which arise as a result of e-mail transmission.


This footer is not compatible with patches submitted to the kernel,
sorry.  email is now deleted.

greg k-h
