Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 13:07:46 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:32903 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225196AbSLJMHp>;
	Tue, 10 Dec 2002 13:07:45 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gBAC7WNf023785;
	Tue, 10 Dec 2002 04:07:33 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA03121;
	Tue, 10 Dec 2002 04:07:33 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gBAC7Vb25181;
	Tue, 10 Dec 2002 13:07:32 +0100 (MET)
Message-ID: <3DF5D902.22E5AA55@mips.com>
Date: Tue, 10 Dec 2002 13:07:31 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: GDB patch
Content-Type: multipart/mixed;
 boundary="------------99A547E7E03B6EF4458E567E"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------99A547E7E03B6EF4458E567E
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I've attached a patch for gdb-stub.c to make it work better with the
sde-gdb.
These changes should be backwards compatible with a standard gdb, so it
shouldn't break anything.
Ralf, could you please apply it.

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------99A547E7E03B6EF4458E567E
Content-Type: text/plain; charset=iso-8859-15;
 name="gdb-stub.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdb-stub.patch"

Index: arch/mips/kernel/gdb-stub.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/gdb-stub.c,v
retrieving revision 1.15.2.3
diff -u -r1.15.2.3 gdb-stub.c
--- arch/mips/kernel/gdb-stub.c	7 Nov 2002 01:47:45 -0000	1.15.2.3
+++ arch/mips/kernel/gdb-stub.c	10 Dec 2002 11:50:35 -0000
@@ -166,7 +166,7 @@
  * BUFMAX defines the maximum number of characters in inbound/outbound buffers
  * at least NUMREGBYTES*2 are needed for register packets
  */
-#define BUFMAX 2048
+#define BUFMAX 8192
 
 static char input_buffer[BUFMAX];
 static char output_buffer[BUFMAX];
@@ -218,7 +218,7 @@
 		 * now, read until a # or end of buffer is found
 		 */
 		while (count < BUFMAX) {
-			ch = getDebugChar() & 0x7f;
+			ch = getDebugChar();
 			if (ch == '#')
 				break;
 			checksum = checksum + ch;
@@ -324,19 +324,33 @@
  * may_fault is non-zero if we are reading from arbitrary memory, but is currently
  * not used.
  */
-static char *hex2mem(char *buf, char *mem, int count, int may_fault)
+static char *hex2mem(char *buf, char *mem, int count, int binary, int may_fault)
 {
 	int i;
 	unsigned char ch;
+	char *startadr = mem;
 
 	for (i=0; i<count; i++)
 	{
-		ch = hex(*buf++) << 4;
-		ch |= hex(*buf++);
+		if (binary) {
+			ch = *buf++;
+			if (ch == 0x7d)
+				ch = 0x20 ^ *buf++;
+		}
+		else {
+			ch = hex(*buf++) << 4;
+			ch |= hex(*buf++);
+		}
 		if (kgdb_write_byte(ch, mem++) != 0)
 			return 0;
 	}
 
+	/* 
+	 * Since we may have written to instruction space via 
+	 * the data path, the icache needs to be flushed here.
+	 */
+	flush_icache_range(startadr, count);
+
 	return mem;
 }
 
@@ -594,6 +608,7 @@
 	int length;
 	char *ptr;
 	unsigned long *stack;
+	int bflag;
 
 #if 0
 	printk("in handle_exception()\n");
@@ -695,6 +710,7 @@
 	 * Wait for input from remote GDB
 	 */
 	while (1) {
+		bflag = 0;
 		output_buffer[0] = 0;
 		getpacket(input_buffer);
 
@@ -767,6 +783,13 @@
 			break;
 
 		/*
+		 * XAA..AA,LLLL: Write LLLL escaped binary bytes at address AA.AA
+		 */
+		case 'X':
+			bflag = 1;
+			/* fall through */
+
+		/*
 		 * MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK
 		 */
 		case 'M':
@@ -776,7 +799,7 @@
 				&& *ptr++ == ','
 				&& hexToInt(&ptr, &length)
 				&& *ptr++ == ':') {
-				if (hex2mem(ptr, (char *)addr, length, 1))
+				if (hex2mem(ptr, (char *)addr, length, bflag, 1))
 					strcpy(output_buffer, "OK");
 				else
 					strcpy(output_buffer, "E03");
@@ -816,13 +839,64 @@
 		case 'k' :
 			break;		/* do nothing */
 
+		case 'R':
+			/* RNN[:SS],	Set the value of CPU register NN (size SS) */
+			/* FALL THROUGH */
+
+		case 'P':
+			/* PNN[:SS]=	Set the value of CPU register NN (size SS) */
+		{
+			int regno, regsize = 4, regval;
+			ptr = &input_buffer[1];
+
+			if (!hexToInt (&ptr, &regno))
+				goto error;
+
+			ptr++;
+			if (!hexToInt (&ptr, &regsize))
+				goto error;
+
+			if (regsize != 4)
+				goto error;
+			if (*ptr != ((input_buffer[0] == 'P') ? '=' : ','))
+				goto error;
+			ptr++;
+			if (!hex2mem (ptr, (char *)&regval, 4, 0, 0))
+				goto error;
+
+			memcpy ((char *)&regs->reg0+regno*4, &regval, 4);
+			strcpy (output_buffer, "OK");
+		}
+		break;
 
-		/*
-		 * Reset the whole machine (FIXME: system dependent)
-		 */
 		case 'r':
-			break;
+			/* rNN[:SS]	Return the value of CPU register NN (size SS) */
+		{
+			int regno, regsize = 4;
+			ptr = &input_buffer[1];
+			if (hexToInt (&ptr, &regno)) {
+				if (*ptr == ':') {
+					ptr++;
+					if (!hexToInt (&ptr, &regsize))
+						goto error;
+				}
+
+				if (regsize != 4)
+					goto error;
+				(void) mem2hex((char *)&regs->reg0+regno*4, 
+					       output_buffer, 4, 0);
+			}
+			else {
+			error:
+				strcpy(output_buffer,"E22 invalid arguments");
+			}
+		}
+		break;
 
+		case 'D':
+			putpacket("OK");
+			return;
+			/* NOTREACHED */
 
 		/*
 		 * Step to next instruction

--------------99A547E7E03B6EF4458E567E--
