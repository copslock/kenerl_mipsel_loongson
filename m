Received:  by oss.sgi.com id <S305157AbQAMWkZ>;
	Thu, 13 Jan 2000 14:40:25 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32041 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQAMWkR>; Thu, 13 Jan 2000 14:40:17 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA08083; Thu, 13 Jan 2000 14:44:00 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA07330
	for linux-list;
	Thu, 13 Jan 2000 13:46:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA56546;
	Thu, 13 Jan 2000 13:46:33 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po3.glue.umd.edu (po3.glue.umd.edu [128.8.10.123]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03090; Thu, 13 Jan 2000 13:45:56 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po3.glue.umd.edu (8.9.3/8.9.3) with ESMTP id QAA05269;
	Thu, 13 Jan 2000 16:45:43 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id QAA14576;
	Thu, 13 Jan 2000 16:45:43 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id QAA14562;
	Thu, 13 Jan 2000 16:45:42 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Thu, 13 Jan 2000 16:45:41 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
cc:     eak@sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: identifying sgi system type under Linux [patch]
In-Reply-To: <14462.16504.84215.298070@liveoak.engr.sgi.com>
Message-ID: <Pine.GSO.4.21.0001131637260.12920-200000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-947799941=:14459"
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-947799941=:14459
Content-Type: TEXT/PLAIN; charset=US-ASCII


>       Note that the Linux kernel (like the IRIX kernel) has a way of
> detecting the difference, since it needs to know which box it is
> running on, so you could just get the kernel to export the data via
> /proc somewhere.  The kernel variable "sgi_guiness" is 1 if the system
> is an Indy ("Guinness") and 0 if the system is an Indigo2
> ("FullHouse").  Look at the file indy_hpc.c to see how this is detected.

thanks, this is what I needed!  It works (at least for me!)

Here is the patch, I'd like someone with and Indy to try and be sure it
works all around....

bash# cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : R4000SC V3.0
system type             : SGI Indigo2
BogoMIPS                : 49.87
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 38
VCEI exceptions         : 56

[---------------]

patch against CVS as of yesterday....


--- ./linux/include/asm-mips/bootinfo.old.h	Thu Jan 13 12:29:17 2000
+++ ./linux/include/asm-mips/bootinfo.h	Thu Jan 13 12:29:42 2000
@@ -91,8 +91,8 @@
  * Valid machtype for group SGI
  */
 #define MACH_SGI_INDY		0	/* R4?K and R5K Indy workstaions */
-
-#define GROUP_SGI_NAMES { "Indy" }
+#define MACH_SGI_INDIGO2	1
+#define GROUP_SGI_NAMES { "Indy", "Indigo2" }
 
 /*
  * Valid machtype for group COBALT
--- ./linux/arch/mips/arc/identify.old.c	Thu Jan 13 12:45:18 2000
+++ ./linux/arch/mips/arc/identify.c	Thu Jan 13 16:26:27 2000
@@ -17,6 +17,7 @@
 #include <asm/sgi/sgi.h>
 #include <asm/sgialib.h>
 #include <asm/bootinfo.h>
+#include <asm/sgi/sgihpc.h>
 
 struct smatch {
     char *name;
@@ -60,9 +61,9 @@
     p = prom_getchild(PROM_NULL_COMPONENT);
     printk("ARCH: %s\n", p->iname);
     mach = string_to_mach(p->iname);
-
+   
     mips_machgroup = mach->group;
-    mips_machtype = mach->type;
+    mips_machtype = !sgi_guiness;
     prom_flags = mach->flags;
 }
 


---559023410-851401618-947799941=:14459
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=mips_cpuinfo_vmw_patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.21.0001131645410.14459@z.glue.umd.edu>
Content-Description: 
Content-Disposition: attachment; filename=mips_cpuinfo_vmw_patch

LS0tIC4vbGludXgvaW5jbHVkZS9hc20tbWlwcy9ib290aW5mby5vbGQuaAlU
aHUgSmFuIDEzIDEyOjI5OjE3IDIwMDANCisrKyAuL2xpbnV4L2luY2x1ZGUv
YXNtLW1pcHMvYm9vdGluZm8uaAlUaHUgSmFuIDEzIDEyOjI5OjQyIDIwMDAN
CkBAIC05MSw4ICs5MSw4IEBADQogICogVmFsaWQgbWFjaHR5cGUgZm9yIGdy
b3VwIFNHSQ0KICAqLw0KICNkZWZpbmUgTUFDSF9TR0lfSU5EWQkJMAkvKiBS
ND9LIGFuZCBSNUsgSW5keSB3b3Jrc3RhaW9ucyAqLw0KLQ0KLSNkZWZpbmUg
R1JPVVBfU0dJX05BTUVTIHsgIkluZHkiIH0NCisjZGVmaW5lIE1BQ0hfU0dJ
X0lORElHTzIJMQ0KKyNkZWZpbmUgR1JPVVBfU0dJX05BTUVTIHsgIkluZHki
LCAiSW5kaWdvMiIgfQ0KIA0KIC8qDQogICogVmFsaWQgbWFjaHR5cGUgZm9y
IGdyb3VwIENPQkFMVA0KLS0tIC4vbGludXgvYXJjaC9taXBzL2FyYy9pZGVu
dGlmeS5vbGQuYwlUaHUgSmFuIDEzIDEyOjQ1OjE4IDIwMDANCisrKyAuL2xp
bnV4L2FyY2gvbWlwcy9hcmMvaWRlbnRpZnkuYwlUaHUgSmFuIDEzIDE2OjI2
OjI3IDIwMDANCkBAIC0xNyw2ICsxNyw3IEBADQogI2luY2x1ZGUgPGFzbS9z
Z2kvc2dpLmg+DQogI2luY2x1ZGUgPGFzbS9zZ2lhbGliLmg+DQogI2luY2x1
ZGUgPGFzbS9ib290aW5mby5oPg0KKyNpbmNsdWRlIDxhc20vc2dpL3NnaWhw
Yy5oPg0KIA0KIHN0cnVjdCBzbWF0Y2ggew0KICAgICBjaGFyICpuYW1lOw0K
QEAgLTYwLDkgKzYxLDkgQEANCiAgICAgcCA9IHByb21fZ2V0Y2hpbGQoUFJP
TV9OVUxMX0NPTVBPTkVOVCk7DQogICAgIHByaW50aygiQVJDSDogJXNcbiIs
IHAtPmluYW1lKTsNCiAgICAgbWFjaCA9IHN0cmluZ190b19tYWNoKHAtPmlu
YW1lKTsNCi0NCisgICANCiAgICAgbWlwc19tYWNoZ3JvdXAgPSBtYWNoLT5n
cm91cDsNCi0gICAgbWlwc19tYWNodHlwZSA9IG1hY2gtPnR5cGU7DQorICAg
IG1pcHNfbWFjaHR5cGUgPSAhc2dpX2d1aW5lc3M7DQogICAgIHByb21fZmxh
Z3MgPSBtYWNoLT5mbGFnczsNCiB9DQogDQo=
---559023410-851401618-947799941=:14459--
