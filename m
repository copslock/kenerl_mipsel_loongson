Received:  by oss.sgi.com id <S42185AbQHGPwa>;
	Mon, 7 Aug 2000 08:52:30 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:28344 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42183AbQHGPwT>;
	Mon, 7 Aug 2000 08:52:19 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA04707;
	Mon, 7 Aug 2000 17:47:37 +0200 (MET DST)
Date:   Mon, 7 Aug 2000 17:47:36 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: A workaround to DEC's RTC year weirdness
Message-ID: <Pine.GSO.3.96.1000807172634.3044D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 Following is a patch that is an ultimate attempt to make the RTC's year
work for DECstations.  It uses an extra BBU RAM's location to store the
real year and the original year is used only as a reference, to make
incrementing work.  Changes address the handling of leap years, too.  The
two only drawbacks of the patch are as follows:

- there has to be at least a single RTC update during a year, as that's
the only situation the real year gets written into the BBU RAM,

- if a machine is powered down long enough the firmware decides to reset
contents the RTC, there is no other way to recover than to set time again. 

 I've tested various dates on my machine and the changes proved to work. 
The current implementation is expected to work until 2255 -- at about 220,
we'll have to change our epoch.

 The changes involved are not transparent, though.  I've used the last BBU
RAM's location that appears to be unused on my 3max+ (it's apparently true
for the preceding one, too).  The firmware wouldn't change either of bytes
no matter what I invoked (the "d" command excluded, of course) and what I
wrote into them.  I couldn't test Ultrix and OSF/1 interoperability
though.  Neither could I test other machines. 

 There appears to be some uncertainity on years permitted by the firmware,
too.  The original code quoted 70, 71 and 72 are permitted.  My system
permits 72 and 73 and also the original setting of the epoch suggests it
is true.  Therefore I strongly encourage everyone interested to test the
code as much as possible.

 Apart from interoperability issues, changes are rather straightforward.

 Comments are welcomed, as usual.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/time.c linux-mips-2.4.0-test5-20000731/arch/mips/dec/time.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/time.c	Wed Jul 12 04:25:56 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/time.c	Sun Aug  6 14:24:55 2000
@@ -424,7 +424,7 @@
 
 void __init time_init(void)
 {
-	unsigned int year, mon, day, hour, min, sec;
+	unsigned int year, mon, day, hour, min, sec, real_year;
 	int i;
 
 	/* The Linux interpretation of the CMOS clock register contents:
@@ -457,10 +457,12 @@
 	}
 	/*
 	 * The DECstation RTC is used as a TOY (Time Of Year).
-	 * The PROM will reset the year to either '70, '71 or '72.
-	 * This hack will only work until Dec 31 2001.
+	 * The PROM will reset the year to either '72 or '73.
+	 * Therefore we store the real year separately, in one
+	 * of unused BBU RAM locations.
 	 */
-	year += 1928;
+	real_year = CMOS_READ(RTC_DEC_YEAR);
+	year += real_year - 72 + 2000;
 
 	write_lock_irq(&xtime_lock);
 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/drivers/char/rtc.c linux-mips-2.4.0-test5-20000731/drivers/char/rtc.c
--- linux-mips-2.4.0-test5-20000731.macro/drivers/char/rtc.c	Mon Jul 24 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/drivers/char/rtc.c	Sun Aug  6 14:22:34 2000
@@ -39,9 +39,10 @@
  *	1.10a	Andrea Arcangeli: Alpha updates
  *	1.10b	Andrew Morton: SMP lock fix
  *	1.10c	Cesar Barros: SMP locking fixes and cleanup
+ *	1.10d	Maciej W. Rozycki: Handle DECstation's year weirdness.
  */
 
-#define RTC_VERSION		"1.10c"
+#define RTC_VERSION		"1.10d"
 
 #define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
 
@@ -366,6 +367,9 @@
 		unsigned char mon, day, hrs, min, sec, leap_yr;
 		unsigned char save_control, save_freq_select;
 		unsigned int yrs;
+#ifdef CONFIG_DECSTATION
+		unsigned int real_yrs;
+#endif
 
 		if (!capable(CAP_SYS_TIME))
 			return -EACCES;
@@ -399,6 +403,20 @@
 			return -EINVAL;
 
 		spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_DECSTATION
+		real_yrs = yrs;
+		yrs = 72;
+
+		/*
+		 * We want to keep the year set to 73 until March
+		 * for non-leap years, so that Feb, 29th is handled
+		 * correctly.
+		 */
+		if (!leap_yr && mon < 3) {
+			real_yrs--;
+			yrs = 73;
+		}
+#endif
 		if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)
 		    || RTC_ALWAYS_BCD) {
 			if (yrs > 169) {
@@ -421,6 +439,9 @@
 		save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
 		CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
 
+#ifdef CONFIG_DECSTATION
+		CMOS_WRITE(real_yrs, RTC_DEC_YEAR);
+#endif
 		CMOS_WRITE(yrs, RTC_YEAR);
 		CMOS_WRITE(mon, RTC_MONTH);
 		CMOS_WRITE(day, RTC_DAY_OF_MONTH);
@@ -474,7 +495,7 @@
 		spin_unlock_irq(&rtc_lock);
 		return 0;
 	}
-#elif !defined(CONFIG_DECSTATION)
+#endif
 	case RTC_EPOCH_READ:	/* Read the epoch.	*/
 	{
 		return put_user (epoch, (unsigned long *)arg);
@@ -493,7 +514,6 @@
 		epoch = arg;
 		return 0;
 	}
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -696,11 +716,11 @@
 	if (year > 20 && year < 48) {
 		epoch = 1980;
 		guess = "ARC console";
-	} else if (year >= 48 && year < 70) {
+	} else if (year >= 48 && year < 72) {
 		epoch = 1952;
 		guess = "Digital UNIX";
-	} else if (year >= 70 && year < 100) {
-		epoch = 1928;
+	} else if (year >= 72 && year < 74) {
+		epoch = 2000;
 		guess = "Digital DECstation";
 	}
 	if (guess)
@@ -904,6 +924,9 @@
 {
 	unsigned long uip_watchdog = jiffies;
 	unsigned char ctrl;
+#ifdef CONFIG_DECSTATION
+	unsigned int real_year;
+#endif
 
 	/*
 	 * read RTC once any update in progress is done. The update
@@ -932,6 +955,9 @@
 	rtc_tm->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
 	rtc_tm->tm_mon = CMOS_READ(RTC_MONTH);
 	rtc_tm->tm_year = CMOS_READ(RTC_YEAR);
+#ifdef CONFIG_DECSTATION
+	real_year = CMOS_READ(RTC_DEC_YEAR);
+#endif
 	ctrl = CMOS_READ(RTC_CONTROL);
 	spin_unlock_irq(&rtc_lock);
 
@@ -944,6 +970,10 @@
 		BCD_TO_BIN(rtc_tm->tm_mon);
 		BCD_TO_BIN(rtc_tm->tm_year);
 	}
+
+#ifdef CONFIG_DECSTATION
+	rtc_tm->tm_year += real_year - 72;
+#endif
 
 	/*
 	 * Account for differences between how the RTC uses the values
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/mc146818rtc.h linux-mips-2.4.0-test5-20000731/include/asm-mips/mc146818rtc.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/mc146818rtc.h	Wed Aug  2 06:29:06 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/mc146818rtc.h	Sat Aug  5 08:19:07 2000
@@ -48,4 +48,8 @@
 #define RTC_IRQ	8
 #endif
 
+#ifdef CONFIG_DECSTATION
+#define RTC_DEC_YEAR	0x3f	/* Where we store the real year on DECs.  */
+#endif
+
 #endif /* _ASM_MC146818RTC_H */
