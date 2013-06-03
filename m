Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jun 2013 21:45:13 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41281 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827503Ab3FCTpHWyGcl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jun 2013 21:45:07 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B01B86EF;
        Mon,  3 Jun 2013 19:44:59 +0000 (UTC)
Date:   Mon, 3 Jun 2013 12:44:59 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] staging: MIPS: add Octeon USB HCD support
Message-ID: <20130603194459.GA11914@kroah.com>
References: <1370112178-16430-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370112178-16430-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36668
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

On Sat, Jun 01, 2013 at 09:42:58PM +0300, Aaro Koskinen wrote:
> Add support for Octeon USB HCD. Tested on EdgeRouter Lite with USB
> mass storage.
> 
> The driver has been extracted from GPL sources of EdgeRouter Lite firmware
> (based on Linux 2.6.32.13). Some minor fixes and cleanups have been done
> to make it work with 3.10-rc3.
> 
> $ uname -a
> Linux (none) 3.10.0-rc3-edge-00005-g86cb5bc #41 SMP PREEMPT Sat Jun 1 20:41:46 EEST 2013 mips64 GNU/Linux
> $ modprobe octeon-usb
> [   37.971683] octeon_usb: module is from the staging directory, the quality is unknown, you have been warned.
> [   37.983649] OcteonUSB: Detected 1 ports
> [   37.999360] OcteonUSB OcteonUSB.0: Octeon Host Controller
> [   38.004847] OcteonUSB OcteonUSB.0: new USB bus registered, assigned bus number 1
> [   38.012332] OcteonUSB OcteonUSB.0: irq 122, io mem 0x00000000
> [   38.019970] hub 1-0:1.0: USB hub found
> [   38.023851] hub 1-0:1.0: 1 port detected
> [   38.028101] OcteonUSB: Registered HCD for port 0 on irq 122
> [   38.391443] usb 1-1: new high-speed USB device number 2 using OcteonUSB
> [   38.586922] usb-storage 1-1:1.0: USB Mass Storage device detected
> [   38.597375] scsi0 : usb-storage 1-1:1.0
> [   39.604111] scsi 0:0:0:0: Direct-Access              USB DISK 2.0     PMAP PQ: 0 ANSI: 4
> [   39.619113] sd 0:0:0:0: [sda] 7579008 512-byte logical blocks: (3.88 GB/3.61 GiB)
> [   39.630696] sd 0:0:0:0: [sda] Write Protect is off
> [   39.635945] sd 0:0:0:0: [sda] No Caching mode page present
> [   39.641464] sd 0:0:0:0: [sda] Assuming drive cache: write through
> [   39.651341] sd 0:0:0:0: [sda] No Caching mode page present
> [   39.656917] sd 0:0:0:0: [sda] Assuming drive cache: write through
> [   39.664296]  sda: sda1 sda2
> [   39.675574] sd 0:0:0:0: [sda] No Caching mode page present
> [   39.681093] sd 0:0:0:0: [sda] Assuming drive cache: write through
> [   39.687223] sd 0:0:0:0: [sda] Attached SCSI removable disk
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

checkpatch.pl output:
	total: 4870 errors, 4611 warnings, 10004 lines checked

You have almost one error/warning per line of code you added.  That
means you will end up replacing all of the driver by the time you are
done.

Are you really going to do that?  It's fine with me, but I better start
get cleanup patches from you and others real soon, or I will drop this
driver from the tree.

thanks,

greg k-h
