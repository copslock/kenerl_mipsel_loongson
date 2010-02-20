Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2010 13:20:55 +0100 (CET)
Received: from mail-gx0-f224.google.com ([209.85.217.224]:49004 "EHLO
        mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492127Ab0BTMUv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Feb 2010 13:20:51 +0100
Received: by gxk24 with SMTP id 24so1144078gxk.7
        for <multiple recipients>; Sat, 20 Feb 2010 04:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=JL8vcaqt/N+2VgPwVXoapC3pRIQYUz+kwbEQqsQcRm8=;
        b=EGJ+8oJPqahZd5xzukxODwHd10ge7GjDB29xpFMZ7bP5bJYChQzbDDG5H9xSLA7nbE
         1bSGUJvvqMq3ac9QFsvTVRpuQYgf6KIBxltmXIjpokW6Nq6B4b7Yj6qYz+OQ+TgjCE3O
         fVkKL1QN324QSLZIxFhaB4DGYqsq/BPvB4g7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=DRDdcl7R6eVMdD+rR1mvpH7Y0u2Bq4WJgtZi1slt+rQWvpMRYDoGB7fc2JBB6KP93+
         DESZTsKuGmZ8e3hGGZKARwKy4XIqknIglET9gp7uqOFBq1xqCUgUREFMNUIs9J14+pX6
         dSzLUigQmpLXf8r13FIkQfg4WGzyD3N6gjEgc=
Received: by 10.101.155.38 with SMTP id h38mr3749549ano.131.1266668445351;
        Sat, 20 Feb 2010 04:20:45 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm969475gxk.10.2010.02.20.04.20.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 04:20:44 -0800 (PST)
Date:   Sat, 20 Feb 2010 21:20:34 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: MIPS: cleanup sgialib.h
Message-Id: <20100220212034.fff9dd2d.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

The unused definitions are removed.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/sgialib.h |   45 ---------------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/arch/mips/include/asm/sgialib.h b/arch/mips/include/asm/sgialib.h
index 63741ca..2a2f1bd 100644
--- a/arch/mips/include/asm/sgialib.h
+++ b/arch/mips/include/asm/sgialib.h
@@ -33,14 +33,6 @@ extern int prom_flags;
 extern void prom_putchar(char c);
 extern char prom_getchar(void);
 
-/* Memory descriptor management. */
-#define PROM_MAX_PMEMBLOCKS    32
-struct prom_pmemblock {
-	LONG	base;		/* Within KSEG0 or XKPHYS. */
-	ULONG	size;		/* In bytes. */
-	ULONG	type;		/* free or prom memory */
-};
-
 /* Get next memory descriptor after CURR, returns first descriptor
  * in chain is CURR is NULL.
  */
@@ -51,7 +43,6 @@ extern struct linux_mdesc *prom_getmdesc(struct linux_mdesc *curr);
  * array.
  */
 extern void prom_meminit(void);
-extern void prom_fixup_mem_map(unsigned long start_mem, unsigned long end_mem);
 
 /* PROM device tree library routines. */
 #define PROM_NULL_COMPONENT ((pcomponent *) 0)
@@ -62,20 +53,6 @@ extern pcomponent *ArcGetPeer(pcomponent *this);
 /* Get child component of THIS. */
 extern pcomponent *ArcGetChild(pcomponent *this);
 
-/* Get parent component of CHILD. */
-extern pcomponent *prom_getparent(pcomponent *child);
-
-/* Copy component opaque data of component THIS into BUFFER
- * if component THIS has opaque data.  Returns success or
- * failure status.
- */
-extern long prom_getcdata(void *buffer, pcomponent *this);
-
-/* Other misc. component routines. */
-extern pcomponent *prom_childadd(pcomponent *this, pcomponent *tmp, void *data);
-extern long prom_delcomponent(pcomponent *this);
-extern pcomponent *prom_componentbypath(char *path);
-
 /* This is called at prom_init time to identify the
  * ARC architecture we are running on
  */
@@ -88,35 +65,13 @@ extern LONG ArcSetEnvironmentVariable(PCHAR name, PCHAR value);
 /* ARCS command line parsing. */
 extern void prom_init_cmdline(void);
 
-/* Acquiring info about the current time, etc. */
-extern struct linux_tinfo *prom_gettinfo(void);
-extern unsigned long prom_getrtime(void);
-
 /* File operations. */
-extern long prom_getvdirent(unsigned long fd, struct linux_vdirent *ent, unsigned long num, unsigned long *cnt);
-extern long prom_open(char *name, enum linux_omode md, unsigned long *fd);
-extern long prom_close(unsigned long fd);
 extern LONG ArcRead(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
-extern long prom_getrstatus(unsigned long fd);
 extern LONG ArcWrite(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
-extern long prom_seek(unsigned long fd, struct linux_bigint *off, enum linux_seekmode sm);
-extern long prom_mount(char *name, enum linux_mountops op);
-extern long prom_getfinfo(unsigned long fd, struct linux_finfo *buf);
-extern long prom_setfinfo(unsigned long fd, unsigned long flags, unsigned long msk);
-
-/* Running stand-along programs. */
-extern long prom_load(char *name, unsigned long end, unsigned long *pc, unsigned long *eaddr);
-extern long prom_invoke(unsigned long pc, unsigned long sp, long argc, char **argv, char **envp);
-extern long prom_exec(char *name, long argc, char **argv, char **envp);
 
 /* Misc. routines. */
-extern VOID prom_halt(VOID) __attribute__((noreturn));
-extern VOID prom_powerdown(VOID) __attribute__((noreturn));
-extern VOID prom_restart(VOID) __attribute__((noreturn));
 extern VOID ArcReboot(VOID) __attribute__((noreturn));
 extern VOID ArcEnterInteractiveMode(VOID) __attribute__((noreturn));
-extern long prom_cfgsave(VOID);
-extern struct linux_sysid *prom_getsysid(VOID);
 extern VOID ArcFlushAllCaches(VOID);
 extern DISPLAY_STATUS *ArcGetDisplayStatus(ULONG FileID);
 
-- 
1.7.0
