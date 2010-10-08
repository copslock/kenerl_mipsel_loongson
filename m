Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 03:45:39 +0200 (CEST)
Received: from [203.94.56.252] ([203.94.56.252]:36475 "EHLO
        atomos.dmz.longlandclan.yi.org" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491201Ab0JHBpg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 03:45:36 +0200
Received: (qmail 24421 invoked by uid 103); 8 Oct 2010 01:45:30 -0000
Received: from beast.dyn.redhatters.yi.org (HELO beast.redhatters.yi.org) (10.0.0.222)
    by atomos.dmz.longlandclan.yi.org (qpsmtpd/0.83) with ESMTP; Fri, 08 Oct 2010 11:45:30 +1000
From:   Stuart Longland <redhatter@gentoo.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [RFC MIPS] Update buildtar for MIPS
Date:   Fri,  8 Oct 2010 11:45:37 +1000
Message-Id: <1286502337-23882-1-git-send-email-redhatter@gentoo.org>
X-Mailer: git-send-email 1.7.1
To:     linux-mips@linux-mips.org
X-Virus-Checked: Checked by ClamAV on atomos.dmz.longlandclan.yi.org
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

A lot of 64-bit systems supported by Linux/MIPS have boot firmware or
bootloaders that only understand 32-bit ELF files, and as such, the vmlinux.32
target exists to support these systems.  Therefore, it'd be nice if the tar-pkg
target recognised this, and included the right version when packaging up a
binary of the kernel.

This updates buildtar to support MIPS targets.  MIPS may use 'vmlinux'
or 'vmlinux.32' depending on the target system.  This uses 'vmlinux.32'
in preference to 'vmlinux' where present (although I should check which
is newer), including either file as /boot/vmlinux-${version}.
---
 scripts/package/buildtar |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 51b2aa0..988c3bd 100644
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -83,6 +83,13 @@ case "${ARCH}" in
 		[ -f "${objtree}/vmlinux.SYS" ] && cp -v -- "${objtree}/vmlinux.SYS" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.SYS"
 		[ -f "${objtree}/vmlinux.dsk" ] && cp -v -- "${objtree}/vmlinux.dsk" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.dsk"
 		;;
+	mips)
+		if [ -f "${objtree}/vmlinux.32" ] ; then
+			cp -v -- "${objtree}/vmlinux.32" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		elif [ -f "${objtree}/vmlinux" ] ; then
+			cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		fi
+		;;
 	*)
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
 		echo "" >&2
-- 
1.7.1
