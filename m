Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 19:42:01 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10502 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226020AbVEFSlp>; Fri, 6 May 2005 19:41:45 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C34E6F5A3F
	for <linux-mips@linux-mips.org>; Fri,  6 May 2005 20:41:37 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15876-07 for <linux-mips@linux-mips.org>;
 Fri,  6 May 2005 20:41:37 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 27A70F5A1D
	for <linux-mips@linux-mips.org>; Fri,  6 May 2005 20:41:37 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j46IfguV024349
	for <linux-mips@linux-mips.org>; Fri, 6 May 2005 20:41:42 +0200
Date:	Fri, 6 May 2005 19:41:53 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <Pine.LNX.4.61L.0505061540540.25293@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.61L.0505061940470.25293@blysk.ds.pg.gda.pl>
References: <20050506143118Z8225421-1340+6642@linux-mips.org>
 <Pine.LNX.4.61L.0505061540540.25293@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/871/Thu May  5 15:50:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 May 2005, Maciej W. Rozycki wrote:

>  Instead of polluting all the cpu_probe_*() functions, it should actually 
> be moved to decode_config0().  I can apply a suitable fix.

 How about this?

  Maciej

patch-mips-2.6.12-rc3-20050506-4ktlb-0
Index: arch/mips/kernel/cpu-probe.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/cpu-probe.c,v
retrieving revision 1.46
diff -u -p -r1.46 cpu-probe.c
--- arch/mips/kernel/cpu-probe.c	6 May 2005 14:31:13 -0000	1.46
+++ arch/mips/kernel/cpu-probe.c	6 May 2005 18:10:01 -0000
@@ -429,7 +429,7 @@ static inline unsigned int decode_config
 	config0 = read_c0_config();
 
 	if (((config0 & MIPS_CONF_MT) >> 7) == 1)
-		c->options |= MIPS_CPU_TLB;
+		c->options |= MIPS_CPU_TLB | MIPS_CPU_4KTLB;
 	isa = (config0 & MIPS_CONF_AT) >> 13;
 	switch (isa) {
 	case 0:
@@ -515,7 +515,6 @@ static inline void decode_configs(struct
 static inline void cpu_probe_mips(struct cpuinfo_mips *c)
 {
 	decode_configs(c);
-	c->options |= MIPS_CPU_4KTLB;
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
@@ -549,7 +548,6 @@ static inline void cpu_probe_mips(struct
 static inline void cpu_probe_alchemy(struct cpuinfo_mips *c)
 {
 	decode_configs(c);
-	c->options |= MIPS_CPU_4KTLB;
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_AU1_REV1:
 	case PRID_IMP_AU1_REV2:
@@ -580,7 +578,6 @@ static inline void cpu_probe_alchemy(str
 static inline void cpu_probe_sibyte(struct cpuinfo_mips *c)
 {
 	decode_configs(c);
-	c->options |= MIPS_CPU_4KTLB;
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_SB1:
 		c->cputype = CPU_SB1;
@@ -595,7 +592,6 @@ static inline void cpu_probe_sibyte(stru
 static inline void cpu_probe_sandcraft(struct cpuinfo_mips *c)
 {
 	decode_configs(c);
-	c->options |= MIPS_CPU_4KTLB;
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_SR71000:
 		c->cputype = CPU_SR71000;
