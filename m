Received:  by oss.sgi.com id <S305168AbQEPUYN>;
	Tue, 16 May 2000 20:24:13 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:56366 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEPUYE>;
	Tue, 16 May 2000 20:24:04 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA22838; Tue, 16 May 2000 13:19:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA12498
	for linux-list;
	Tue, 16 May 2000 13:18:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from virgil.engr.sgi.com (virgil.engr.sgi.com [163.154.5.20])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA68705
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 May 2000 13:18:55 -0700 (PDT)
	mail_from (bigham@cthulhu.engr.sgi.com)
Received: from engr.sgi.com (localhost [127.0.0.1]) by virgil.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) via ESMTP id NAA10701 for <linux@engr.sgi.com>; Tue, 16 May 2000 13:18:55 -0700 (PDT)
Message-ID: <3921AD2D.95843F5@engr.sgi.com>
Date:   Tue, 16 May 2000 13:18:53 -0700
From:   Nancy Bigham <bigham@cthulhu.engr.sgi.com>
Organization: Linux
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
Subject: [Fwd: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from 
 [Klaus Naumann <spock@mgnet.de>]]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



-------- Original Message --------
Subject: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from
[Klaus Naumann <spock@mgnet.de>]
Date: Tue, 16 May 2000 11:40:21 -0700 (PDT)
From: owner-linux@cthulhu
To: owner-linux@cthulhu

>From owner-linux  Tue May 16 11:40:20 2000
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA22782
	for <linux@engr.sgi.com>;
	Tue, 16 May 2000 11:40:19 -0700 (PDT)
	mail_from (spock@mgnet.de)
Received: from asterix.hrz.tu-chemnitz.de (asterix.hrz.tu-chemnitz.de
[134.109.132.84]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA05149
	for <linux@engr.sgi.com>; Tue, 16 May 2000 11:40:18 -0700 (PDT)
	mail_from (spock@mgnet.de)
Received: from sunnyboy.informatik.tu-chemnitz.de by
asterix.hrz.tu-chemnitz.de 
          with Local SMTP (PP); Tue, 16 May 2000 20:40:13 +0200
Received: from scotty.mgnet.de (sevenofnine.csn.tu-chemnitz.de
[134.109.96.133]) 
          by sunnyboy.informatik.tu-chemnitz.de (8.8.8/8.8.8) with SMTP 
          id UAA05440 for <linux@engr.sgi.com>;
          Tue, 16 May 2000 20:40:11 +0200 (MET DST)
Received: (qmail 22691 invoked from network); 16 May 2000 18:40:12 -0000
Received: from spock.mgnet.de (HELO scotty.mgnet.de) (192.168.1.4) 
          by scotty.mgnet.de with SMTP; 16 May 2000 18:40:12 -0000
Date: Tue, 16 May 2000 20:40:22 +0200
From: Klaus Naumann <spock@mgnet.de>
To: "Linux MIPS engr . sgi . com" <linux@engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>
Subject: [PATCH] Merging CPU & Machine selection in config.in
Message-ID: <20000516204022.B598@spock>
Reply-To: spock@mgnet.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+fexcqMh/evT6CrY"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 0.8.0-pre1


--+fexcqMh/evT6CrY
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit


Hi,

attached is a patch which merges the CPU and machine
selection in the kernel configuration into one Main Menu.
The reason is that I think it's not necessary to have
two main menus used for this task.
Please tell me if you like this idea or not and if so
why you don't like it.

	CU Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/3661/675457  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
--+fexcqMh/evT6CrY
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment;
filename="config.in-cpuandmachine.patch"

diff -Nur linux/arch/mips/config.in linux.build/arch/mips/config.in
--- linux/arch/mips/config.in	Tue May 16 16:56:08 2000
+++ linux.build/arch/mips/config.in	Tue May 16 17:14:36 2000
@@ -10,7 +10,7 @@
 endmenu
 
 mainmenu_option next_comment
-comment 'Machine selection'
+comment 'Machine/CPU selection'
 bool 'Support for Acer PICA 1 chipset' CONFIG_ACER_PICA_61
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    bool 'Support for Algorithmics P4032 (EXPERIMENTAL)'
CONFIG_ALGOR_P4032
@@ -23,6 +23,38 @@
 bool 'Support for SGI IP22' CONFIG_SGI_IP22
 bool 'Support for SNI RM200 PCI' CONFIG_SNI_RM200_PCI
 
+choice 'CPU type' \
+	"R3000 CONFIG_CPU_R3000	\
+	 R6000 CONFIG_CPU_R6000	\
+	 R4300 CONFIG_CPU_R4300	\
+	 R4x00 CONFIG_CPU_R4X00	\
+	 R5000 CONFIG_CPU_R5000	\
+	 R56x0 CONFIG_CPU_NEVADA \
+	 R8000 CONFIG_CPU_R8000	\
+	 R10000 CONFIG_CPU_R10000" R4x00
+
+bool 'Advanced CPU Config' CONFIG_CPU_ADVANCED
+
+if [ "$CONFIG_CPU_ADVANCED" = "y" ]; then
+	bool '  ll/sc Instructions available' CONFIG_CPU_HAS_LLSC
+	bool '  Writeback Buffer available' CONFIG_CPU_HAS_WB
+else
+	if [ "$CONFIG_CPU_R3000" = "y" ]; then
+		if [ "$CONFIG_DECSTATION" = "y" ]; then
+			define_bool CONFIG_CPU_HAS_LLSC n
+			define_bool CONFIG_CPU_HAS_WB y
+		else
+			define_bool CONFIG_CPU_HAS_LLSC n
+			define_bool CONFIG_CPU_HAS_WB n
+		fi
+	else
+		define_bool CONFIG_CPU_HAS_LLSC y
+		define_bool CONFIG_CPU_HAS_WB n
+	fi
+fi
+
+
+
 #
 # Select some configuration options automatically for certain systems.
 #
@@ -76,40 +108,6 @@
 if [ "$CONFIG_PCI" != "y" ]; then
    define_bool CONFIG_PCI n
 fi
-endmenu
-
-mainmenu_option next_comment
-	comment 'CPU selection'
-
-	choice 'CPU type' \
-		"R3000 CONFIG_CPU_R3000	\
-		 R6000 CONFIG_CPU_R6000	\
-		 R4300 CONFIG_CPU_R4300	\
-		 R4x00 CONFIG_CPU_R4X00	\
-		 R5000 CONFIG_CPU_R5000	\
-		 R56x0 CONFIG_CPU_NEVADA \
-		 R8000 CONFIG_CPU_R8000	\
-		 R10000 CONFIG_CPU_R10000" R4x00
-
-	bool 'Override CPU Options' CONFIG_CPU_ADVANCED
-
-	if [ "$CONFIG_CPU_ADVANCED" = "y" ]; then
-		bool '  ll/sc Instructions available' CONFIG_CPU_HAS_LLSC
-		bool '  Writeback Buffer available' CONFIG_CPU_HAS_WB
-	else
-		if [ "$CONFIG_CPU_R3000" = "y" ]; then
-			if [ "$CONFIG_DECSTATION" = "y" ]; then
-				define_bool CONFIG_CPU_HAS_LLSC n
-				define_bool CONFIG_CPU_HAS_WB y
-			else
-				define_bool CONFIG_CPU_HAS_LLSC n
-				define_bool CONFIG_CPU_HAS_WB n
-			fi
-		else
-			define_bool CONFIG_CPU_HAS_LLSC y
-			define_bool CONFIG_CPU_HAS_WB n
-		fi
-	fi
 endmenu
 
 mainmenu_option next_comment

--+fexcqMh/evT6CrY--
