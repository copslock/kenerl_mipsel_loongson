Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6CC3vR16804
	for linux-mips-outgoing; Thu, 12 Jul 2001 05:03:57 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6CC3mV16797
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 05:03:49 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA12453;
	Thu, 12 Jul 2001 14:05:07 +0200 (MET DST)
Date: Thu, 12 Jul 2001 14:05:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>
cc: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: gpm-support for serial DECstation mouse (VSXXX-AA)
In-Reply-To: <20010711230550.A26702@linuxtag.org>
Message-ID: <Pine.GSO.3.96.1010712130948.11228A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 11 Jul 2001, Karsten Merker wrote:

> I have added support for the DEC VSXXX-AA mouse (serial mouse used on
> the DECstation 5000/xxx systems) to the Debian gpm package. An

 I can't test the patch as I don't have a suitable console device. 
However, I can already see a problem with the protocol identification
masks.  Also it's worth mentioning the VSXXX-GA mouse as well (it might
not be obvious to everyone the mice are compatible) and the mice are not
just DECstation-specific.  I think it's the right place to fully specify
the protocol used -- specs are not widely available and chances are they
might get lost if not cast in stone somewhere.

 Following is a patch against your version -- please consider the changes
I propose. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

gpm-1.19.3-vsxxxaa.patch
diff -up --recursive --new-file gpm-1.19.3.macro/mice.c gpm-1.19.3/mice.c
--- gpm-1.19.3.macro/mice.c	Wed Jul 11 18:12:59 2001
+++ gpm-1.19.3/mice.c	Thu Jul 12 00:33:12 2001
@@ -1281,8 +1281,10 @@ static int M_wp(Gpm_Event *state,  unsig
 }
 
 
-/* DECstation 5000/xxx serial mouse (DEC VSXXX-AA) support    */
-/* written 2001/07/11 by Karsten Merker (merker@linuxtag.org) */
+/* Support for DEC VSXXX-AA and VSXXX-GA serial mice used on */
+/* DECstation 5000/xxx, DEC 3000 AXP and VAXstation 4000     */
+/* workstations, written 2001/07/11 by Karsten Merker        */
+/* (merker@linuxtag.org)                                     */
 static int M_vsxxx_aa(Gpm_Event *state, unsigned char *data)
 {
   state->buttons = data[0]&0x07;
@@ -1292,8 +1294,8 @@ static int M_vsxxx_aa(Gpm_Event *state, 
 
 
 /* Mouse protocol is as follows:
- * 3 data bytes per packet,
  * 4800 bits per second, 8 data bits, 1 stop bit, odd parity
+ * 3 data bytes per data packet:
  *              7     6     5     4     3     2     1     0
  * First Byte:  1     0     0   SignX SignY  LMB   MMB   RMB
  * Second Byte  0     DX    DX    DX    DX    DX    DX    DX
@@ -1304,8 +1306,29 @@ static int M_vsxxx_aa(Gpm_Event *state, 
  * DX and DY: 7-bit-absolute values for delta-X and delta-Y, sign extensions
  *            are in SignX resp. SignY.
  *
- * Initialization is done by sending an "R" to the mouse; before receiving
- * this character, the mouse does not produce a bytestream
+ * There are a few commands the mouse accepts:
+ * "D" selects the prompt mode,
+ * "P" requests the mouse's position (also selects the prompt mode),
+ * "R" selects the incremental stream mode,
+ * "T" performs a self test and identification (power-up-like),
+ * "Z" performs undocumented test functions (a byte follows).
+ * Parity as well as bit #7 of commands are ignored by the mouse.
+ *
+ * 4 data bytes per self test packet (useful for hot-plug):
+ *              7     6     5     4     3     2     1     0
+ * First Byte:  1     0     1     0     R3    R2    R1    R0
+ * Second Byte  0     M2    M1    M0    0     0     1     0
+ * Third Byte   0     E6    E5    E4    E3    E2    E1    E0
+ * Fourth Byte  0     0     0     0     0    LMB   MMB   RMB
+ *
+ * R3-R0:     revision,
+ * M2-M0:     manufacturer location code,
+ * E6-E0:     error code:
+ *            0x00-0x1f: no error (fourth byte is button state),
+ *            0x3d:      button error (fourth byte specifies which),
+ *            else:      other error.
+ * 
+ * The mouse powers up in the prompt mode but we use the stream mode.
  */
 
 }
@@ -1455,7 +1478,7 @@ I_serial(int fd, unsigned short flags,
 
   if (type->fun==M_vsxxx_aa) 
     {
-      setspeed (fd, 4800, 4800, 1, flags);
+      setspeed (fd, 4800, 4800, 0, flags); /* no write */
       write(fd, "R", 1);     /* initialize mouse, without getting an "R" the */
                              /* mouse does not send a bytestream             */
     }
@@ -2057,9 +2080,9 @@ Gpm_Type mice[]={
   {"brw",  "Fellowes Browser - 4 buttons (and a wheel) (dual protocol?)",
            "", M_brw, I_pnp, CS7 | STD_FLG,
                                 {0xc0, 0x40, 0xc0, 0x00}, 4, 1, 0, 0, 0},
-  {"vsxxxaa", "For the DEC VSXXX-AA serial mouse on DECstation 5000/xxx.",
+  {"vsxxxaa", "The DEC VSXXX-AA/GA serial mouse on DEC workstations.",
            "", M_vsxxx_aa, I_serial, CS8 | PARENB | PARODD | STD_FLG,
-                                {0x80, 0x80, 0x00, 0x00}, 3, 1, 0, 0, 0},
+                                {0xe0, 0x80, 0x80, 0x00}, 3, 1, 0, 0, 0},
 
 #ifdef HAVE_LINUX_JOYSTICK_H
   {"js",   "Joystick mouse emulation",
