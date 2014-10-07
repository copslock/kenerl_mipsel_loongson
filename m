Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 18:23:17 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43971 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010726AbaJGQXOfjr3D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 18:23:14 +0200
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A3EC8DE;
        Tue,  7 Oct 2014 16:23:07 +0000 (UTC)
Date:   Tue, 7 Oct 2014 09:23:06 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Julian Andres Klode <jak@jak-linux.org>,
        Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH 29/44] staging: nvec: Register with kernel poweroff
 handler
Message-ID: <20141007162306.GA2913@kroah.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-30-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412659726-29957-30-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43067
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

On Mon, Oct 06, 2014 at 10:28:31PM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with default priority value of 128 since we don't know
> any better.
> 
> Cc: Julian Andres Klode <jak@jak-linux.org>
> Cc: Marc Dietrich <marvin24@gmx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/staging/nvec/nvec.c | 24 +++++++++++++++---------
>  drivers/staging/nvec/nvec.h |  2 ++
>  2 files changed, 17 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
