Received:  by oss.sgi.com id <S554151AbRBCT3J>;
	Sat, 3 Feb 2001 11:29:09 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:63501 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553660AbRBCT2v>;
	Sat, 3 Feb 2001 11:28:51 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C37357FC; Sat,  3 Feb 2001 20:28:35 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8DC5DEEAD; Sat,  3 Feb 2001 20:29:03 +0100 (CET)
Date:   Sat, 3 Feb 2001 20:29:03 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [PATCH] drivers/net/Config.in - CONFIG_IA64_SGI_SN1 vs. $CONFIG_IA64_SGI_SN1#
Message-ID: <20010203202903.A4098@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I guess this is more correct :)

Index: drivers/net/Config.in
===================================================================
RCS file: /cvs/linux/drivers/net/Config.in,v
retrieving revision 1.53
diff -u -r1.53 Config.in
--- drivers/net/Config.in	2001/01/11 04:02:43	1.53
+++ drivers/net/Config.in	2001/02/03 19:27:39
@@ -55,7 +55,7 @@
    if [ "$CONFIG_SGI_IP27" = "y" ]; then
       bool '  SGI IOC3 Ethernet' CONFIG_SGI_IOC3_ETH
    fi
-   if [ "CONFIG_IA64_SGI_SN1" = "y" ]; then
+   if [ "$CONFIG_IA64_SGI_SN1" = "y" ]; then
       bool '  SGI IOC3 Ethernet' CONFIG_SGI_IOC3_ETH
    fi
    if [ "$CONFIG_SUPERH" = "y" ]; then


-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
