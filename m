Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7I3P0J20911
	for linux-mips-outgoing; Fri, 17 Aug 2001 20:25:00 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7I3Orj20846;
	Fri, 17 Aug 2001 20:24:54 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id CFE42590A9; Fri, 17 Aug 2001 23:21:16 -0400 (EDT)
Message-ID: <06eb01c12795$8b4bde20$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
Subject: PATCH: vrc5477 sound driver for-loop to udelay
Date: Fri, 17 Aug 2001 23:26:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

2001-08-17 Bradley D. LaRonde <brad@ltc.com>

* convert for-loop delay to udelay.  udelay is better since it is
MHz independent, but the real reason for this change is that gcc 3.0
didn't compile the for-loop as one might expect.

* eliminate unused variable warning


diff -u -B -b -r1.1 nec_vrc5477.c
--- drivers/sound/nec_vrc5477.c 2001/06/10 16:57:41 1.1
+++ drivers/sound/nec_vrc5477.c 2001/08/18 03:07:34
@@ -260,7 +260,6 @@
   (struct vrc5477_ac97_state *)codec->private_data;
  unsigned long flags;
  u32 result;
- int i;

  spin_lock_irqsave(&s->lock, flags);

@@ -272,7 +271,7 @@
  outl((addr << 16) | VRC5477_CODEC_WR_RWC, s->io + VRC5477_CODEC_WR);

  /* get the return result */
- for (i=10000; i; i--);  /* workaround hardware bug */
+ udelay(100); /* workaround hardware bug */
  while ( (result = inl(s->io + VRC5477_CODEC_RD)) &
                 (VRC5477_CODEC_RD_RRDYA | VRC5477_CODEC_RD_RRDYD) ) {
   /* we get either addr or data, or both */
@@ -1093,7 +1092,9 @@
         int totalCopyCount = 0;
         int totalCopyFragCount = 0;
         unsigned long flags;
+#if defined(VRC5477_AC97_VERBOSE_DEBUG)
  int i;
+#endif

         /* adjust count to signel channel byte count */
         count >>= s->dacChannels - 1;
@@ -1788,7 +1789,6 @@
 u16 myrdcodec(u8 addr)
 {
         u32 result;
-        u32 i;

         /* wait until we can access codec registers */
         // while (inl(VRC5477_CODEC_WR) & 0x80000000);
@@ -1798,7 +1798,7 @@
         myoutl((addr << 16) | VRC5477_CODEC_WR_RWC, VRC5477_CODEC_WR);

         /* get the return result */
-        for (i=10000; i; i--);
+        udelay(100); /* workaround hardware bug */
         // dump_memory(0xbb000000, 48);
         while ( ((result=myinl(VRC5477_CODEC_RD)) & 0xc0000000) !=
0xc0000000);
         MIPS_ASSERT(addr == ((result >> 16) & 0x7f) );
