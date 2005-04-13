Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 22:38:42 +0100 (BST)
Received: from web40908.mail.yahoo.com ([IPv6:::ffff:66.218.78.205]:41612 "HELO
	web40908.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225962AbVDMVi0>; Wed, 13 Apr 2005 22:38:26 +0100
Received: (qmail 50943 invoked by uid 60001); 13 Apr 2005 21:38:18 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=McYhXD6euIY7kSK0qBQBP4aeIv1M6EsK8i3GbObCPokaWAndD6helTWuzj2D1XBojQlynVLxVBRjV/bgggI2p01tBdptNwsOK2mpgS8UGudnx86G6A1NF9Q4TBCOjMuYJxaom2/xKfyNqvO+i/VQyxoupPWOB+xhFA3o6MDu9xg=  ;
Message-ID: <20050413213818.50941.qmail@web40908.mail.yahoo.com>
Received: from [65.205.244.66] by web40908.mail.yahoo.com via HTTP; Wed, 13 Apr 2005 14:38:18 PDT
Date:	Wed, 13 Apr 2005 14:38:18 -0700 (PDT)
From:	Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: gdb backtrace with core files [PATCH]
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org, 'Daniel Jacobowitz' <dan@debian.org>,
	'Ralf Baechle' <ralf@linux-mips.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-563089567-1113428298=:50713"
Return-Path: <bkuschak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkuschak@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-563089567-1113428298=:50713
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Ok, based on some off-list discussion, here is a patch
which fixes the non-ABI-compilant linux-mips coredump
for 2.4.25.  This needs to be merged into the 2.4
tree, but is already present in 2.6.

Tested with standard gdb-6.3.  Backtracing and
register contents are correct now.

Regards,
Brian

--- Greg Weeks <greg.weeks@timesys.com> wrote:
> Brian Kuschak wrote:
> 
> >Greg,
> >
> >Is your GDB hosted on MIPS or another machine?  Are
> >those patches freely available?  If so, can you
> >  
> >
> OK, I checked.
> 
> Most of what's in our patches should be in gdb HEAD.
> We're currently at 
> 6.2.1 and don't want to take the time to move to
> head. If you're 
> interested and no one objects I can post them to the
> mips list. There 
> are 37 patches totaling 285K. Not all are mips
> related and gdb isn't 
> totally working for me yet.
> 
> Greg Weeks
> 


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
--0-563089567-1113428298=:50713
Content-Type: text/x-patch; name="linux_gdb_corefile.patch"
Content-Description: linux_gdb_corefile.patch
Content-Disposition: inline; filename="linux_gdb_corefile.patch"

diff -urN --exclude=.svn linux.svn/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux.svn/arch/mips/kernel/process.c	2005-04-13 13:34:37.991809507 -0700
+++ linux/arch/mips/kernel/process.c	2005-04-13 12:09:06.850076067 -0700
@@ -128,6 +128,29 @@
 	return 1;
 }
 
+/* bk - backported from 2.6.  coredump was not abi compliant. */
+void dump_regs(elf_greg_t *gp, struct pt_regs *regs)
+{
+	int i;
+
+	for (i = 0; i < EF_REG0; i++)
+		gp[i] = 0;
+	gp[EF_REG0] = 0;
+	for (i = 1; i <= 31; i++)
+		gp[EF_REG0 + i] = regs->regs[i];
+	gp[EF_REG26] = 0;
+	gp[EF_REG27] = 0;
+	gp[EF_LO] = regs->lo;
+	gp[EF_HI] = regs->hi;
+	gp[EF_CP0_EPC] = regs->cp0_epc;
+	gp[EF_CP0_BADVADDR] = regs->cp0_badvaddr;
+	gp[EF_CP0_STATUS] = regs->cp0_status;
+	gp[EF_CP0_CAUSE] = regs->cp0_cause;
+#ifdef EF_UNUSED0
+	gp[EF_UNUSED0] = 0;
+#endif
+}
+
 /*
  * Create a kernel thread
  */
diff -urN --exclude=.svn linux.svn/include/asm-mips/elf.h linux/include/asm-mips/elf.h
--- linux.svn/include/asm-mips/elf.h	2005-04-13 13:32:23.240250530 -0700
+++ linux/include/asm-mips/elf.h	2005-04-13 11:31:22.954466902 -0700
@@ -66,9 +66,17 @@
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
 
-#define ELF_CORE_COPY_REGS(_dest,_regs)				\
-	memcpy((char *) &_dest, (char *) _regs,			\
-	       sizeof(struct pt_regs));
+/* bk - backport changes from 2.6 to make coredump ABI-compilant */
+extern void dump_regs(elf_greg_t *, struct pt_regs *regs);
+extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
+extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
+
+#define ELF_CORE_COPY_REGS(elf_regs, regs)			\
+	dump_regs((elf_greg_t *)&(elf_regs), regs);
+#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) \
+	dump_task_regs(tsk, elf_regs)
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs)			\
+	dump_task_fpu(tsk, elf_fpregs)
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,
diff -urN --exclude=.svn linux.svn/include/asm-mips/reg.h linux/include/asm-mips/reg.h
--- linux.svn/include/asm-mips/reg.h	2005-04-13 13:32:23.263247724 -0700
+++ linux/include/asm-mips/reg.h	2005-04-13 12:01:47.717743650 -0700
@@ -45,6 +45,9 @@
 /*
  * k0/k1 unsaved
  */
+#define EF_REG26		32
+#define EF_REG27		33
+
 #define EF_REG28		34
 #define EF_REG29		35
 #define EF_REG30		36

--0-563089567-1113428298=:50713--
