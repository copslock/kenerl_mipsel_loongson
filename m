Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1JNfjg29006
	for linux-mips-outgoing; Tue, 19 Feb 2002 15:41:45 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1JNfS929000;
	Tue, 19 Feb 2002 15:41:29 -0800
Received: from dev1 (unknown [10.1.1.85])
	by ns1.ltc.com (Postfix) with ESMTP
	id BD69A590A9; Tue, 19 Feb 2002 17:30:58 -0500 (EST)
Received: from brad by dev1 with local (Exim 3.33 #1 (Debian))
	id 16dIos-0000W8-00; Tue, 19 Feb 2002 17:33:06 -0500
Date: Tue, 19 Feb 2002 17:33:02 -0500
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: [PATCH] remove die/die_if_kernel __FUNCTION__ cat for gcc 3.x's sake
Message-ID: <20020219173302.A1989@dev1.ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: "Bradley D. LaRonde <brad@ltc.com>" <brad@ltc.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

diff -urNbB --exclude-from=diff-linux-exclude linux-oss-2.4-2002-01-20/include/asm-mips/system.h linux-encore-2.4.17-2/include/asm-mips/system.h
--- linux-oss-2.4-2002-01-20/include/asm-mips/system.h	Sun Dec 16 04:34:16 2001
+++ linux-encore-2.4.17-2/include/asm-mips/system.h	Tue Feb 19 17:05:36 2002
@@ -276,14 +276,14 @@
 
 extern void *set_except_vector(int n, void *addr);
 
-extern void __die(const char *, struct pt_regs *, const char *where,
-	unsigned long line) __attribute__((noreturn));
-extern void __die_if_kernel(const char *, struct pt_regs *, const char *where,
-	unsigned long line);
+extern void __die(const char *, struct pt_regs *, const char *file,
+	const char *function, unsigned long line) __attribute__((noreturn));
+extern void __die_if_kernel(const char *, struct pt_regs *, const char *file,
+	const char *function, unsigned long line);
 
 #define die(msg, regs)							\
-	__die(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
+	__die(msg, regs, __FILE__, __FUNCTION__, __LINE__)
 #define die_if_kernel(msg, regs)					\
-	__die_if_kernel(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
+	__die_if_kernel(msg, regs, __FILE__, __FUNCTION__, __LINE__)
 
 #endif /* _ASM_SYSTEM_H */
diff -urNbB --exclude-from=diff-linux-exclude linux-oss-2.4-2002-01-20/arch/mips/kernel/traps.c linux-encore-2.4.17-2/arch/mips/kernel/traps.c
--- linux-oss-2.4-2002-01-20/arch/mips/kernel/traps.c	Sun Jan 20 17:06:08 2002
+++ linux-encore-2.4.17-2/arch/mips/kernel/traps.c	Tue Feb 19 17:20:25 2002
@@ -327,25 +327,25 @@
 
 static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
-void __die(const char * str, struct pt_regs * regs, const char *where,
-           unsigned long line)
+void __die(const char * str, struct pt_regs * regs, const char *file,
+           const char *function, unsigned long line)
 {
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	printk("%s", str);
-	if (where)
-		printk(" in %s, line %ld", where, line);
+	if (file && function)
+		printk(" in %s:%s, line %ld", file, function, line);
 	printk(":\n");
 	show_registers(regs);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }
 
-void __die_if_kernel(const char * str, struct pt_regs * regs, const char *where,
-	unsigned long line)
+void __die_if_kernel(const char * str, struct pt_regs * regs, const char *file,
+	const char* function, unsigned long line)
 {
 	if (!user_mode(regs))
-		__die(str, regs, where, line);
+		__die(str, regs, file, function, line);
 }
 
 extern const struct exception_table_entry __start___dbe_table[];
