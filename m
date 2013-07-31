Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jul 2013 18:25:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35653 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827293Ab3GaQZ1bEOnb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Jul 2013 18:25:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r6VGPPfi010898;
        Wed, 31 Jul 2013 18:25:25 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r6VGPMLU010897;
        Wed, 31 Jul 2013 18:25:22 +0200
Date:   Wed, 31 Jul 2013 18:25:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Stuart Longland <redhatter@gentoo.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
        linux-kbuild@vger.kernel.org
Subject: Re: [RFC MIPS] Update buildtar for MIPS
Message-ID: <20130731162521.GA10570@linux-mips.org>
References: <1286502337-23882-1-git-send-email-redhatter@gentoo.org>
 <alpine.LFD.2.00.1010160716270.15889@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010160716270.15889@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37407
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

On Sat, Oct 16, 2010 at 07:17:45AM +0100, Maciej W. Rozycki wrote:

> > This updates buildtar to support MIPS targets.  MIPS may use 'vmlinux'
> > or 'vmlinux.32' depending on the target system.
> 
>  Or vmlinux.64 -- why don't you handle that too?

Patchwork is patient, nothing gets lost :-)  I've updated Stuart's original
patch http://patchwork.linux-mips.org/patch/1673/ to also handle compressed
kernel images, how about below patch.

Michal, when testing this by building "make targz-pkg" for a particular MIPS
platform I get

  tar: lib/*: Cannot stat: No such file or directory

and I assume that's because CONFIG_MODULES is not enabled for my test
configuration.

  Ralf

kbuild: Add MIPS specific files to generated package.

A lot of 64-bit systems supported by Linux/MIPS have boot firmware or
bootloaders that only understand 32-bit ELF files, and as such, the vmlinux.32
target exists to support these systems.  Therefore, it'd be nice if the tar-pkg
target recognised this, and included the right version when packaging up a
binary of the kernel.

This updates buildtar to support MIPS targets.  MIPS may use 'vmlinux'
or 'vmlinux.32' depending on the target system.  This uses 'vmlinux.32'
in preference to 'vmlinux' where present (although I should check which
is newer), including either file as /boot/vmlinux-${version}.

Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 scripts/package/buildtar | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index cdd9bb9..aa22f94 100644
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -87,6 +87,27 @@ case "${ARCH}" in
 		[ -f "${objtree}/vmlinux.SYS" ] && cp -v -- "${objtree}/vmlinux.SYS" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.SYS"
 		[ -f "${objtree}/vmlinux.dsk" ] && cp -v -- "${objtree}/vmlinux.dsk" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.dsk"
 		;;
+	mips)
+		if [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.bin" ]; then
+			cp -v -- "${objtree}/arch/mips/boot/compressed/vmlinux.bin" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		elif [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.ecoff" ]; then
+			cp -v -- "${objtree}/arch/mips/boot/compressed/vmlinux.ecoff" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		elif [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.srec" ]; then
+			cp -v -- "${objtree}/arch/mips/boot/compressed/vmlinux.srec" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		elif [ -f "${objtree}/vmlinux.32" ]; then
+			cp -v -- "${objtree}/vmlinux.32" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		elif [ -f "${objtree}/vmlinux.64" ]; then
+			cp -v -- "${objtree}/vmlinux.64" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		elif [ -f "${objtree}/arch/mips/boot/vmlinux.bin" ]; then
+			cp -v -- "${objtree}/arch/mips/boot/vmlinux.bin" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		elif [ -f "${objtree}/arch/mips/boot/vmlinux.ecoff" ]; then
+			cp -v -- "${objtree}/arch/mips/boot/vmlinux.ecoff" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		elif [ -f "${objtree}/arch/mips/boot/vmlinux.srec" ]; then
+			cp -v -- "${objtree}/arch/mips/boot/vmlinux.srec" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		elif [ -f "${objtree}/vmlinux" ]; then
+			cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		fi
+		;;
 	*)
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
 		echo "" >&2
