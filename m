Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jun 2013 18:35:59 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57308 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831597Ab3FCQfyWJ0Bx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jun 2013 18:35:54 +0200
Received: by mail-ie0-f180.google.com with SMTP id b11so10967929iee.39
        for <linux-mips@linux-mips.org>; Mon, 03 Jun 2013 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NvuQLPNIJ8nK6aO1gCpxTntoXFjHjIFHKxZu/wuU13I=;
        b=NE70n+lQYAke99ezuSpcMa3oEAziW9gEXmBBsCRWX5bfR6uUyDBKPqWAeXz1/dARyB
         mye/hNRc0/B/2hzpSCp3Y7xOCmY3EDHiXaEeX3kJIWpHDQFoC/ViQutpcDZoX3eFmYOQ
         6fjbRM3dD1APsO5e/BAPp/GPaOX3UueVuqW1T2faYeIXF2Xxw8Cu2qRN8P498KviCVLM
         XofkjDUuqj0tKITTD/nq9ePA7z46efuZxBSR/XGxa8zOtxByuD6pxgLYZi/jamiHlABu
         B8cs7vAvMdgaRCjDzlyQ4TqbyxBOcYHWAVZVEo2hjJdbmUN9Vp0QWdqYOssAwgCPFMnv
         /flw==
X-Received: by 10.50.62.13 with SMTP id u13mr8488094igr.19.1370277347694;
        Mon, 03 Jun 2013 09:35:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vc15sm20213372igb.7.2013.06.03.09.35.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Jun 2013 09:35:46 -0700 (PDT)
Message-ID: <51ACC5E1.5040906@gmail.com>
Date:   Mon, 03 Jun 2013 09:35:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chad Reese <kreese@caviumnetworks.com>
CC:     devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] staging: MIPS: add Octeon USB HCD support
References: <1370112178-16430-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1370112178-16430-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/01/2013 11:42 AM, Aaro Koskinen wrote:
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
> ---
>   drivers/staging/Kconfig                      |    2 +
>   drivers/staging/Makefile                     |    1 +
>   drivers/staging/octeon-usb/Kconfig           |   10 +
>   drivers/staging/octeon-usb/Makefile          |    3 +
>   drivers/staging/octeon-usb/TODO              |   11 +
>   drivers/staging/octeon-usb/cvmx-usb.c        | 3344 ++++++++++++++++++++++++++
>   drivers/staging/octeon-usb/cvmx-usb.h        | 1085 +++++++++
>   drivers/staging/octeon-usb/cvmx-usbcx-defs.h | 3086 ++++++++++++++++++++++++
>   drivers/staging/octeon-usb/cvmx-usbnx-defs.h | 1596 ++++++++++++
>   drivers/staging/octeon-usb/octeon-hcd.c      |  854 +++++++
>   10 files changed, 9992 insertions(+)
>   create mode 100644 drivers/staging/octeon-usb/Kconfig
>   create mode 100644 drivers/staging/octeon-usb/Makefile
>   create mode 100644 drivers/staging/octeon-usb/TODO
>   create mode 100644 drivers/staging/octeon-usb/cvmx-usb.c
>   create mode 100644 drivers/staging/octeon-usb/cvmx-usb.h
>   create mode 100644 drivers/staging/octeon-usb/cvmx-usbcx-defs.h
>   create mode 100644 drivers/staging/octeon-usb/cvmx-usbnx-defs.h
>   create mode 100644 drivers/staging/octeon-usb/octeon-hcd.c
>


FYI: This is an alternate, host only, driver for the DesignWare USB2 
controller as found on some OCTEON SoCs.  drivers/staging/dwc2 contains 
the code supplied by Synopsys for the same controller.

One might ask why an alternate driver was ever written.  The answer to 
this question is:  The octeon-hcd driver is much better than the dwc2 
driver when running the hardware in host mode.


David Daney
