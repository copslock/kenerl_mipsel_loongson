Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 17:31:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38881 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012138AbaJVPbsIkmTq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 17:31:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9MFVg43011579;
        Wed, 22 Oct 2014 17:31:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9MFVakT011578;
        Wed, 22 Oct 2014 17:31:36 +0200
Date:   Wed, 22 Oct 2014 17:31:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net, linux390@de.ibm.com,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux@openrisc.net,
        linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 08/47] kernel: Move pm_power_off to common code
Message-ID: <20141022153136.GA11045@linux-mips.org>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-9-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413864783-3271-9-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Oct 20, 2014 at 09:12:24PM -0700, Guenter Roeck wrote:

> pm_power_off is defined for all architectures. Move it to common code.
> 
> Have all architectures call do_kernel_power_off instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_power_off from machine_power_off instead.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Hirokazu Takata <takata@linux-m32r.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Richard Weinberger <richard@nod.at>
> Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Ralf Baechle <ralf@linux-mips.org>
