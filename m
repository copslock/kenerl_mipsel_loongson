Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBC02Vj26272
	for linux-mips-outgoing; Tue, 11 Dec 2001 16:02:31 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBC017o26230
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 16:01:08 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBBN10A23115;
	Tue, 11 Dec 2001 21:01:00 -0200
Date: Tue, 11 Dec 2001 21:01:00 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: cpuinfo
Message-ID: <20011211210100.A21552@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ok, the damage of no longer having /proc/cpuinfo was a bit too large
it seems so here is a patch to retrofit it.  Patch against 2.5 but
should work for 2.4 also.

  Ralf

Index: arch/mips/arc/identify.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/arc/identify.c,v
retrieving revision 1.5
diff -u -r1.5 identify.c
--- arch/mips/arc/identify.c 2001/03/18 23:29:04 1.5  
+++ arch/mips/arc/identify.c 2001/12/11 22:46:55   
@@ -17,17 +17,35 @@
 #include <asm/bootinfo.h>
 
 struct smatch {
-	char *name;
+	char *arcname;
+	char *liname;
 	int group;
 	int type;
 	int flags;
 };
 
 static struct smatch mach_table[] = {
-	{"SGI-IP22", MACH_GROUP_SGI, MACH_SGI_INDY, PROM_FLAG_ARCS},
-	{"Microsoft-Jazz", MACH_GROUP_JAZZ, MACH_MIPS_MAGNUM_4000, 0},
-	{"PICA-61", MACH_GROUP_JAZZ, MACH_ACER_PICA_61, 0},
-	{"RM200PCI", MACH_GROUP_SNI_RM, MACH_SNI_RM200_PCI, 0}
+	{	"SGI-IP22",
+		"SGI Indy",
+		MACH_GROUP_SGI,
+		MACH_SGI_INDY,
+		PROM_FLAG_ARCS
+	}, {	"Microsoft-Jazz",
+		"Jazz MIPS_Magnum_4000",
+		MACH_GROUP_JAZZ,
+		MACH_MIPS_MAGNUM_4000,
+		0
+	}, {	"PICA-61",
+		"Jazz Acer_PICA_61",
+		"MACH_GROUP_JAZZ",
+		MACH_ACER_PICA_61,
+		0
+	}, {	"RM200PCI",
+		"SNI RM200_PCI",
+		MACH_GROUP_SNI_RM,
+		MACH_SNI_RM200_PCI,
+		0
+	}
 };
 
 int prom_flags;
@@ -37,7 +55,7 @@
 	int i;
 
 	for (i = 0; i < (sizeof(mach_table) / sizeof (mach_table[0])); i++) {
-		if (!strcmp(s, mach_table[i].name))
+		if (!strcmp(s, mach_table[i].arcname))
 			return &mach_table[i];
 	}
 	prom_printf("\nYeee, could not determine architecture type <%s>\n",
@@ -48,6 +66,13 @@
 	return NULL;
 }
 
+char *system_type;
+
+const char *get_system_type(void)
+{
+	return system_type;
+}
+
 void __init prom_identify_arch(void)
 {
 	pcomponent *p;
@@ -60,6 +85,7 @@
 	p = prom_getchild(PROM_NULL_COMPONENT);
 	printk("ARCH: %s\n", p->iname);
 	mach = string_to_mach(p->iname);
+	system_type = mach->liname;
 
 	mips_machgroup = mach->group;
 	mips_machtype = mach->type;
Index: arch/mips/au1000/pb1000/init.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/au1000/pb1000/init.c,v
retrieving revision 1.4
diff -u -r1.4 init.c
--- arch/mips/au1000/pb1000/init.c 2001/08/28 15:58:03 1.4  
+++ arch/mips/au1000/pb1000/init.c 2001/12/11 22:46:55   
@@ -44,6 +44,11 @@
 extern void  __init prom_init_cmdline(void);
 extern char *prom_getenv(char *envname);
 
+const char *get_system_type(void)
+{
+	return "Alchemy PB1000";
+}
+
 int __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
 	unsigned char *memsize_str;
Index: arch/mips/baget/prom/init.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/baget/prom/init.c,v
retrieving revision 1.7
diff -u -r1.7 init.c
--- arch/mips/baget/prom/init.c 2001/01/28 03:44:51 1.7  
+++ arch/mips/baget/prom/init.c 2001/12/11 22:46:55   
@@ -9,6 +9,12 @@
 
 char arcs_cmdline[COMMAND_LINE_SIZE];
 
+const char *get_system_type(void)
+{
+	/* Should probably return one of "BT23-201", "BT23-202" */
+	return "Baget";
+}
+
 void __init prom_init(unsigned int mem_upper)
 {
 	mem_upper = PHYSADDR(mem_upper);
Index: arch/mips/ddb5074/prom.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/ddb5074/prom.c,v
retrieving revision 1.6
diff -u -r1.6 prom.c
--- arch/mips/ddb5074/prom.c 2000/12/13 19:43:03 1.6  
+++ arch/mips/ddb5074/prom.c 2001/12/11 22:46:55   
@@ -15,6 +15,11 @@
 
 char arcs_cmdline[COMMAND_LINE_SIZE];
 
+const char *get_system_type(void)
+{
+	return "NEC DDB Vrc-5074";
+}
+
 void __init prom_init(const char *s)
 {
 	int i = 0;
Index: arch/mips/ddb5xxx/common/prom.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/ddb5xxx/common/prom.c,v
retrieving revision 1.2
diff -u -r1.2 prom.c
--- arch/mips/ddb5xxx/common/prom.c 2001/09/26 01:37:34 1.2  
+++ arch/mips/ddb5xxx/common/prom.c 2001/12/11 22:46:55   
@@ -25,6 +25,17 @@
 
 char arcs_cmdline[COMMAND_LINE_SIZE];
 
+const char *get_system_type(void)
+{
+#if defined(CONFIG_DDB5074)
+	return "NEC DDB Vrc-5074";
+#elif defined(CONFIG_DDB5476)
+	return "NEC DDB Vrc-5476";
+#elif defined(CONFIG_DDB5477)
+	return "NEC DDB Vrc-5477";
+#endif
+}
+
 /* [jsun@junsun.net] PMON passes arguments in C main() style */
 void __init prom_init(int argc, const char **arg)
 {
Index: arch/mips/dec/prom/identify.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/dec/prom/identify.c,v
retrieving revision 1.4
diff -u -r1.4 identify.c
--- arch/mips/dec/prom/identify.c 2001/09/06 13:12:01 1.4  
+++ arch/mips/dec/prom/identify.c 2001/12/11 22:46:55   
@@ -19,6 +19,26 @@
 extern unsigned long mips_machgroup;
 extern unsigned long mips_machtype;
 
+extern unsigned long mips_machtype;
+const char *get_system_type(void)
+{ 
+	static char system[32];
+	int called = 0;
+	const char *dec_system_strings[] = { "unknown", "DECstation 2100/3100",
+        	"DECstation 5100", "DECstation 5000/200", "DECstation 5000/1xx",
+		"Personal DECstation 5000/xx", "DECstation 5000/2x0",
+		"DECstation 5400", "DECstation 5500", "DECstation 5800"
+	};
+
+	if (called == 0) {
+		called = 1;
+		strcpy(system, "Digital ");
+		strcat(system, dec_system_strings[mips_machtype]);
+	}
+
+	return system;
+}
+
 void __init prom_identify_arch (unsigned int magic)
 {
 	unsigned char dec_cpunum, dec_firmrev, dec_etc;
Index: arch/mips/galileo-boards/ev64120/setup.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/galileo-boards/ev64120/setup.c,v
retrieving revision 1.8
diff -u -r1.8 setup.c
--- arch/mips/galileo-boards/ev64120/setup.c 2001/11/25 09:25:53 1.8  
+++ arch/mips/galileo-boards/ev64120/setup.c 2001/12/11 22:46:55   
@@ -149,22 +149,25 @@
 
 }
 
-/********************************************************************
- *SetUpBootInfo -
+const char *get_system_type(void)
+{
+	return "Galileo EV64120A";
+}
+
+/*
+ * SetUpBootInfo -
  *
- *This function is called at very first stages of kernel startup.
- *It specifies for the kernel the evaluation board that the linux
- *is running on. Then it saves the eprom parameters that holds the
- *command line, memory size etc...
+ * This function is called at very first stages of kernel startup.
+ * It specifies for the kernel the evaluation board that the linux
+ * is running on. Then it saves the eprom parameters that holds the
+ * command line, memory size etc...
  *
- *Inputs :
- *argc - nothing
- *argv - holds a pointer to the eprom parameters
- *envp - nothing
- *
- *Outpus :
- *
- *********************************************************************/
+ * Inputs :
+ * argc - nothing
+ * argv - holds a pointer to the eprom parameters
+ * envp - nothing
+ */
+
 void SetUpBootInfo(int argc, char **argv, char **envp)
 {
 	mips_machgroup = MACH_GROUP_GALILEO;
Index: arch/mips/galileo-boards/ev96100/init.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/galileo-boards/ev96100/init.c,v
retrieving revision 1.3
diff -u -r1.3 init.c
--- arch/mips/galileo-boards/ev96100/init.c 2001/08/29 00:26:15 1.3  
+++ arch/mips/galileo-boards/ev96100/init.c 2001/12/11 22:46:55   
@@ -151,6 +151,10 @@
 	return 0;
 }
 
+const char *get_system_type(void)
+{
+	return "Galileo EV96100";
+}
 
 void __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
Index: arch/mips/gt64120/momenco_ocelot/prom.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/gt64120/momenco_ocelot/prom.c,v
retrieving revision 1.3
diff -u -r1.3 prom.c
--- arch/mips/gt64120/momenco_ocelot/prom.c 2001/06/14 21:47:15 1.3  
+++ arch/mips/gt64120/momenco_ocelot/prom.c 2001/12/11 22:46:55   
@@ -34,6 +34,11 @@
 
 char arcs_cmdline[COMMAND_LINE_SIZE];
 
+const char *get_system_type(void)
+{
+	return "Momentum Ocelot";
+}
+
 /* [jsun@junsun.net] PMON passes arguments in C main() style */
 void __init prom_init(int argc, const char **arg)
 {
Index: arch/mips/hp-lj/setup.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/hp-lj/setup.c,v
retrieving revision 1.2
diff -u -r1.2 setup.c
--- arch/mips/hp-lj/setup.c 2001/11/27 15:29:00 1.2  
+++ arch/mips/hp-lj/setup.c 2001/12/11 22:46:55   
@@ -26,6 +26,10 @@
 int remote_debug = 0;
 #endif
 
+const char *get_system_type(void)
+{
+	return "HP LaserJet";		/* But which exactly?  */
+}
 
 static void (*timer_interrupt_service)(int irq, void *dev_id, struct pt_regs * regs) = NULL;
 
Index: arch/mips/ite-boards/ivr/init.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/ite-boards/ivr/init.c,v
retrieving revision 1.1
diff -u -r1.1 init.c
--- arch/mips/ite-boards/ivr/init.c 2001/03/16 12:34:03 1.1  
+++ arch/mips/ite-boards/ivr/init.c 2001/12/11 22:46:55   
@@ -52,6 +52,10 @@
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
 
+const char *get_system_type(void)
+{
+	return "Globespan IVR";
+}
 
 int __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
Index: arch/mips/ite-boards/qed-4n-s01b/init.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/ite-boards/qed-4n-s01b/init.c,v
retrieving revision 1.2
diff -u -r1.2 init.c
--- arch/mips/ite-boards/qed-4n-s01b/init.c 2001/03/16 12:44:20 1.2  
+++ arch/mips/ite-boards/qed-4n-s01b/init.c 2001/12/11 22:46:55   
@@ -52,6 +52,10 @@
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
 
+const char *get_system_type(void)
+{
+	return "ITE QED-4N-S01B";
+}
 
 int __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
Index: arch/mips/jmr3927/rbhma3100/init.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/jmr3927/rbhma3100/init.c,v
retrieving revision 1.1
diff -u -r1.1 init.c
--- arch/mips/jmr3927/rbhma3100/init.c 2001/11/26 12:01:09 1.1  
+++ arch/mips/jmr3927/rbhma3100/init.c 2001/12/11 22:46:55   
@@ -47,6 +47,15 @@
 extern char *prom_getenv(char *envname);
 unsigned long mips_nofpu = 0;
 
+const char *get_system_type(void)
+{
+	return "Toshiba"
+#ifdef CONFIG_TOSHIBA_JMR3927
+	       "JMR_TX3927"
+#endif
+	;
+}
+
 extern void puts(unsigned char *cp);
 int __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
Index: arch/mips/kernel/proc.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/proc.c,v
retrieving revision 1.29
diff -u -r1.29 proc.c
--- arch/mips/kernel/proc.c 2001/12/07 19:28:43 1.29  
+++ arch/mips/kernel/proc.c 2001/12/11 22:46:55   
@@ -35,6 +35,12 @@
 		return 0;
 #endif
 
+	/*
+	 * For the first processor also print the system type
+	 */
+	if (n == 0)
+		seq_printf(m, "system type\t\t: %s\n", get_system_type());
+
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
 	        (mips_cpu.options & MIPS_CPU_FPU) ? "  FPU V%d.%d" : "");
Index: arch/mips/mips-boards/atlas/atlas_setup.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/mips-boards/atlas/atlas_setup.c,v
retrieving revision 1.7
diff -u -r1.7 atlas_setup.c
--- arch/mips/mips-boards/atlas/atlas_setup.c 2001/03/15 23:48:54 1.7  
+++ arch/mips/mips-boards/atlas/atlas_setup.c 2001/12/11 22:46:55   
@@ -47,6 +47,11 @@
 
 extern void mips_reboot_setup(void);
 
+const char *get_system_type(void)
+{
+	return "MIPS Atlas";
+}
+
 void __init atlas_setup(void)
 {
 #ifdef CONFIG_REMOTE_DEBUG
Index: arch/mips/mips-boards/malta/malta_setup.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/mips-boards/malta/malta_setup.c,v
retrieving revision 1.7
diff -u -r1.7 malta_setup.c
--- arch/mips/mips-boards/malta/malta_setup.c 2001/07/19 11:37:12 1.7  
+++ arch/mips/mips-boards/malta/malta_setup.c 2001/12/11 22:46:55   
@@ -65,6 +65,12 @@
 
 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
 
+const char *get_system_type(void)
+{
+	return "MIPS Malta";
+}
+
+
 void __init malta_setup(void)
 {
 #ifdef CONFIG_REMOTE_DEBUG
Index: arch/mips/philips/nino/prom.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/philips/nino/prom.c,v
retrieving revision 1.6
diff -u -r1.6 prom.c
--- arch/mips/philips/nino/prom.c 2001/11/24 14:03:19 1.6  
+++ arch/mips/philips/nino/prom.c 2001/12/11 22:46:55   
@@ -25,6 +25,11 @@
 extern unsigned long tx3912fb_size;
 #endif
 
+const char *get_system_type(void)
+{
+	return "Philips Nino";
+}
+
 /* Do basic initialization */
 void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
 {
Index: arch/mips/sgi-ip22/ip22-hpc.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/sgi-ip22/ip22-hpc.c,v
retrieving revision 1.1
diff -u -r1.1 ip22-hpc.c
--- arch/mips/sgi-ip22/ip22-hpc.c 2001/11/27 15:57:11 1.1  
+++ arch/mips/sgi-ip22/ip22-hpc.c 2001/12/11 22:46:55   
@@ -26,6 +26,8 @@
 int sgi_guiness = 0;
 int sgi_boardid;
 
+extern char *system_type;
+
 void __init sgihpc_init(void)
 {
 	unsigned long sid, crev, brev;
@@ -51,12 +53,14 @@
 #endif
 		sgi_guiness = 1;
 		mips_machtype = MACH_SGI_INDY;
+		strcat(system_type, "Indy");
 	} else {
 #ifdef DEBUG_SGIHPC
 		prom_printf("FULLHOUSE ");
 #endif
                 mips_machtype = MACH_SGI_INDIGO2;
 		sgi_guiness = 0;
+		strcat(system_type, "Indigo2");
 	}
 	sgi_boardid = brev;
 
Index: arch/mips/sibyte/swarm/setup.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/sibyte/swarm/setup.c,v
retrieving revision 1.4
diff -u -r1.4 setup.c
--- arch/mips/sibyte/swarm/setup.c 2001/12/02 17:44:09 1.4  
+++ arch/mips/sibyte/swarm/setup.c 2001/12/11 22:46:55   
@@ -64,6 +64,10 @@
 
 #endif
 
+const char *get_system_type(void)
+{
+	return "SiByte Swarm";
+}
 
 #ifdef CONFIG_BLK_DEV_IDE_SWARM
 static int swarm_ide_default_irq(ide_ioreg_t base)
Index: arch/mips/vr4181/osprey/prom.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/vr4181/osprey/prom.c,v
retrieving revision 1.1
diff -u -r1.1 prom.c
--- arch/mips/vr4181/osprey/prom.c 2001/10/02 23:27:11 1.1  
+++ arch/mips/vr4181/osprey/prom.c 2001/12/11 22:46:55   
@@ -23,6 +23,11 @@
 
 char arcs_cmdline[COMMAND_LINE_SIZE];
 
+const char *get_system_type(void)
+{
+	return "NEC_Vr41xx Osprey";
+}
+
 /* 
  * [jsun] right now we assume it is the nec debug monitor, which does
  * not pass any arguments.
Index: include/asm-mips/bootinfo.h
===================================================================
RCS file: /home/pub/cvs/linux/include/asm-mips/bootinfo.h,v
retrieving revision 1.44
diff -u -r1.44 bootinfo.h
--- include/asm-mips/bootinfo.h 2001/12/03 07:48:32 1.44  
+++ include/asm-mips/bootinfo.h 2001/12/11 22:46:56   
@@ -34,18 +34,11 @@
 #define MACH_GROUP_NEC_VR41XX  19 /* NEC Vr41xx based boards/gadgets          */
 #define MACH_GROUP_HP_LJ	20 /* Hewlett Packard LaserJet */
 
-#define GROUP_NAMES { "unknown", "Jazz", "Digital", "ARC", "SNI", "ACN",      \
-	"SGI", "Cobalt", "NEC DDB", "Baget", "Cosine", "Galileo", "Momentum", \
-	"ITE", "Philips", "Globepspan", "SiByte", "Toshiba", "Alchemy",       \
-	"NEC Vr41xx", "HP LaserJet" }
-
 /*
  * Valid machtype values for group unknown (low order halfword of mips_machtype)
  */
 #define MACH_UNKNOWN		0	/* whatever...			*/
 
-#define GROUP_UNKNOWN_NAMES { "unknown" }
-
 /*
  * Valid machtype values for group JAZZ
  */
@@ -53,8 +46,6 @@
 #define MACH_MIPS_MAGNUM_4000	1	/* Mips Magnum 4000 "RC4030"	*/
 #define MACH_OLIVETTI_M700      2	/* Olivetti M700-10 (-15 ??)    */
 
-#define GROUP_JAZZ_NAMES { "Acer PICA 61", "Mips Magnum 4000", "Olivetti M700" }
-
 /*
  * Valid machtype for group DEC 
  */
@@ -69,33 +60,22 @@
 #define MACH_DS5500		8	/* DECstation 5500		*/
 #define MACH_DS5800		9	/* DECstation 5800		*/
 
-#define GROUP_DEC_NAMES { "unknown", "DECstation 2100/3100", "DECstation 5100", \
-	"DECstation 5000/200", "DECstation 5000/1xx", "Personal DECstation 5000/xx", \
-	"DECstation 5000/2x0", "DECstation 5400", "DECstation 5500", \
-	"DECstation 5800" }
-
 /*
  * Valid machtype for group ARC
  */
 #define MACH_DESKSTATION_RPC44  0	/* Deskstation rPC44 */
 #define MACH_DESKSTATION_TYNE	1	/* Deskstation Tyne */
 
-#define GROUP_ARC_NAMES { "Deskstation rPC44", "Deskstation Tyne" }
-
 /*
  * Valid machtype for group SNI_RM
  */
 #define MACH_SNI_RM200_PCI	0	/* RM200/RM300/RM400 PCI series */
 
-#define GROUP_SNI_RM_NAMES { "RM200 PCI" }
-
 /*
  * Valid machtype for group ACN
  */
 #define MACH_ACN_MIPS_BOARD	0       /* ACN MIPS single board        */
 
-#define GROUP_ACN_NAMES { "ACN" }
-
 /*
  * Valid machtype for group SGI
  */
@@ -103,15 +83,11 @@
 #define MACH_SGI_CHALLENGE_S	1	/* The Challenge S server */
 #define MACH_SGI_INDIGO2	2	/* The Indigo2 system */
 
-#define GROUP_SGI_NAMES { "Indy", "Challenge S", "Indigo2" }
-
 /*
  * Valid machtype for group COBALT
  */
 #define MACH_COBALT_27 		 0	/* Proto "27" hardware */
 
-#define GROUP_COBALT_NAMES { "Microserver 27" }
-
 /*
  * Valid machtype for group NEC DDB
  */
@@ -119,68 +95,50 @@
 #define MACH_NEC_DDB5476         1      /* NEC DDB Vrc-5476 */
 #define MACH_NEC_DDB5477         2      /* NEC DDB Vrc-5477 */
 
-#define GROUP_NEC_DDB_NAMES { "Vrc-5074", "Vrc-5476", "Vrc-5477"}
-
 /*
  * Valid machtype for group BAGET
  */
 #define MACH_BAGET201		0	/* BT23-201 */
 #define MACH_BAGET202		1	/* BT23-202 */
 
-#define GROUP_BAGET_NAMES { "BT23-201", "BT23-202" }
-
 /*
  * Cosine boards.
  */
 #define MACH_COSINE_ORION	0
 
-#define GROUP_COSINE_NAMES { "Orion" }
-
 /*
  * Valid machtype for group GALILEO
  */
 #define MACH_EV96100		0	/* EV96100 */
 #define MACH_EV64120A		1	/* EV64120A */
 
-#define GROUP_GALILEO_NAMES { "EV96100" , "EV64120A" }
-
 /*
  * Valid machtype for group MOMENCO
  */
 #define MACH_MOMENCO_OCELOT		0
 
-#define GROUP_MOMENCO_NAMES { "Ocelot" }
-
  
 /*
  * Valid machtype for group ITE
  */
 #define MACH_QED_4N_S01B	0	/* ITE8172 based eval board */
  
-#define GROUP_ITE_NAMES { "QED-4N-S01B" } /* the actual board name */
-	
 /*
  * Valid machtype for group Globespan
  */
 #define MACH_IVR       0                  /* IVR eval board */
 
-#define GROUP_GLOBESPAN_NAMES { "IVR" }   /* the actual board name */   
-
 /*
  * Valid machtype for group PHILIPS
  */
 #define MACH_PHILIPS_NINO	0	/* Nino */
 #define MACH_PHILIPS_VELO	1	/* Velo */
 
-#define GROUP_PHILIPS_NAMES { "Nino" , "Velo" }
-
 /*
  * Valid machtype for group SIBYTE
  */
 #define MACH_SWARM              0
 
-#define GROUP_SIBYTE_NAMES {"SWARM" }
-
 /*
  * Valid machtypes for group Toshiba
  */
@@ -189,23 +147,16 @@
 #define MACH_JMR		2
 #define MACH_TOSHIBA_JMR3927    3      /* JMR-TX3927 CPU/IO board */
 
-#define GROUP_TOSHIBA_NAMES { "Pallas", "TopasCE", "JMR", "JMR TX3927" }
-
 /*
  * Valid machtype for group Alchemy
  */
 #define MACH_PB1000	0	         /* Au1000-based eval board */
  
-#define GROUP_ALCHEMY_NAMES { "PB1000" } /* the actual board name */
-
 /*
  * Valid machtype for group NEC_VR41XX
  */
 #define MACH_NEC_OSPREY                0       /* Osprey eval board */
 
-#define GROUP_NEC_VR41XX_NAMES { "Osprey" }
-
-
 /*
  * Valid cputype values
  */
@@ -272,6 +223,8 @@
 #define BOOT_MEM_RESERVED	3
 
 #ifndef __ASSEMBLY__
+
+const char *get_system_type(void);
 
 extern unsigned long mips_machtype;
 extern unsigned long mips_machgroup;
