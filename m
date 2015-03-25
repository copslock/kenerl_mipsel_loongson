Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 23:03:51 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008964AbbCYWDstw2uG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 23:03:48 +0100
Received: from localhost (gob75-2-82-67-192-59.fbx.proxad.net [82.67.192.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 176AFAF5;
        Wed, 25 Mar 2015 22:03:41 +0000 (UTC)
Date:   Wed, 25 Mar 2015 23:03:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] MIPS: Add CDMM bus support
Message-ID: <20150325220339.GC10513@kroah.com>
References: <20150325123756.GA2200@kroah.com>
 <1427297990-14023-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427297990-14023-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46530
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

On Wed, Mar 25, 2015 at 03:39:50PM +0000, James Hogan wrote:
> Add MIPS Common Device Memory Map (CDMM) support in the form of a bus in
> the standard Linux device model. Each device attached via CDMM is
> discoverable via an 8-bit type identifier and may contain a number of
> blocks of memory mapped registers in the CDMM region. IRQs are expected
> to be handled separately.
> 
> Due to the per-cpu (per-VPE for MT cores) nature of the CDMM devices,
> all the driver callbacks take place from workqueues which are run on the
> right CPU for the device in question, so that the driver doesn't need to
> be as concerned about which CPU it is running on. Callbacks also exist
> for when CPUs are taken offline, so that any per-CPU resources used by
> the driver can be disabled so they don't get forcefully migrated. CDMM
> devices are created as children of the CPU device they are attached to.
> 
> Any existing CDMM configuration by the bootloader will be inherited,
> however platforms wishing to enable CDMM should implement the weak
> mips_cdmm_phys_base() function (see asm/cdmm.h) so that the bus driver
> knows where it should put the CDMM region in the physical address space
> if the bootloader hasn't already enabled it.
> 
> A mips_cdmm_early_probe() function is also provided to allow early boot
> or particularly low level code to set up the CDMM region and probe for a
> specific device type, for example early console or KGDB IO drivers for
> the EJTAG Fast Debug Channel (FDC) CDMM device.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-mips@linux-mips.org
> ---
> Changes in v3:
> - Convert to use dev_groups rather than dev_attrs (GregKH).
> - Rename mips_cdmm_attr_func() macro to CDMM_ATTR for consistency with
>   other similar macro names I've seen around the kernel.
> - Add modalias attribute.
> 
> Changes in v2:
> - Fix some checkpatch errors.
> - Correct CDMM name in various places. It is "Common Device Memory Map",
>   rather than "Common Device Mapped Memory" (which for some reason had
>   got stuck in my head).
> ---
>  arch/mips/include/asm/cdmm.h      |  87 +++++
>  drivers/bus/Kconfig               |  13 +
>  drivers/bus/Makefile              |   1 +
>  drivers/bus/mips_cdmm.c           | 716 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mod_devicetable.h   |   8 +
>  scripts/mod/devicetable-offsets.c |   3 +
>  scripts/mod/file2alias.c          |  16 +
>  7 files changed, 844 insertions(+)
>  create mode 100644 arch/mips/include/asm/cdmm.h
>  create mode 100644 drivers/bus/mips_cdmm.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
