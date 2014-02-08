Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Feb 2014 04:39:35 +0100 (CET)
Received: from mail.active-venture.com ([67.228.131.205]:53081 "EHLO
        mail.active-venture.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823014AbaBHDjdR-SF2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Feb 2014 04:39:33 +0100
Received: (qmail 48688 invoked by uid 399); 8 Feb 2014 03:39:26 -0000
Received: from unknown (HELO server.roeck-us.net) (linux@roeck-us.net@108.223.40.66)
  by mail.active-venture.com with ESMTPAM; 8 Feb 2014 03:39:26 -0000
X-Originating-IP: 108.223.40.66
X-Sender: linux@roeck-us.net
Message-ID: <52F5A6EE.7020000@roeck-us.net>
Date:   Fri, 07 Feb 2014 19:39:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Commit 597ce1723 (MIPS: Support for 64-bit FP with O32 binaries)
 causing qemu hang with mips64 kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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


Hi all,

in 3.14-rc1, my mips64 qemu test fails. The image boots and then hangs.
Bisect points to commit 597ce1723 (MIPS: Support for 64-bit FP with O32 binaries).
Reverting this commit fixes the problem. Disabling MIPS_O32_FP64_SUPPORT
in my test image does _not_ solve the problem. The qemu version does not seem
to make a difference; I tested with qemu 1.6.0 and 1.7.0.

Console log output is available in
http://server.roeck-us.net:8010/builders/qemu-mips64-master/builds/34/steps/buildcommand/logs/stdio

When the problem is seen, the emulation hangs as can be seen in the log,
and the qemu process consumes 100% CPU until it is killed.

qemu command line is

qemu-system-mips64 -kernel vmlinux -M malta -hda core-image-minimal-qemumips64.ext3 \
-vga cirrus -usb -usbdevice wacom-tablet -no-reboot -m 128 --append "root=/dev/hda \
rw mem=128M console=ttyS0 console=tty" -nographic

The same configuration works fine with earlier kernels. I'll be happy to provide
the detailed configuration as well as the root file system for testing if needed.

Obviously I have no idea if this is a problem with the patch or with qemu.
If there is anything I can do to help tracking down the problem further,
please let me know.

Thanks,
Guenter
